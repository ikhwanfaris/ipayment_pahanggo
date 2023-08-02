import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/organizations/list_organization_member.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/screens/content/profile/organization/member/add_member.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ViewMemberScreen extends StatefulWidget {
  final Organization organization;
  const ViewMemberScreen(this.organization, {Key? key});
  @override
  State<ViewMemberScreen> createState() => _ViewMemberScreenState();
}

class _ViewMemberScreenState extends State<ViewMemberScreen> {
  List<ListOrganizationMember> _memberModel = [];
  // ignore: unused_field
  bool _isSuperAdmin = false;
  int? userId;

  bool _isCheckAdmin = false;

  @override
  void initState() {
    super.initState();
    _getData();
    userId = widget.organization.userId;
    if (store.getItem('isMemberAdminLS').toString() == 'Pentadbir') {
      _isCheckAdmin = true;
    } else {
      _isCheckAdmin = false;
    }
  }

  void _getData() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    var oId = widget.organization.id;
    _memberModel = (await api.getOrganizationMember(oId!));
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(children: [
              Visibility(
                visible: _isCheckAdmin,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: constants.sixColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Container(
                            height: 50,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(LineIcons.plusCircle,
                                    color: constants.paleWhite),
                                SizedBox(width: 10),
                                Text(
                                  "Add Organization Member".tr,
                                  style: styles.heading6boldPaleWhite,
                                )
                              ],
                            ),
                          ),
                          onPressed: () async {
                            await navigate(
                                context, AddMemberScreen(widget.organization));
                            // run refresh code ` here
                            _getData();
                          }),
                    ),
                  ],
                ),
              ),
              _memberModel.isEmpty
                  ? Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Column(
                          children: [
                            Text(
                              'There are no registered members under this organization.'
                                  .tr,
                              style: styles.heading5,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(16),
                      child: SingleChildScrollView(
                        child: Container(
                          child: Column(
                            children: [
                              Card(
                                color: Constants().nineColor,
                                shadowColor: Constants().primaryColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(LineIcons.building),
                                          SizedBox(width: 16),
                                          Text(
                                            widget.organization.orgName
                                                .toString(),
                                            style: styles.heading6bold,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(LineIcons.phone),
                                          SizedBox(width: 16),
                                          Text(
                                            widget.organization.phoneNo
                                                .toString(),
                                            style: styles.heading2,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(LineIcons.envelope),
                                          SizedBox(width: 16),
                                          Text(
                                            widget.organization.orgEmail
                                                .toString(),
                                            style: styles.heading2,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(LineIcons.mapPin),
                                          SizedBox(width: 16),
                                          Text(
                                            widget.organization.address1
                                                .toString(),
                                            style: styles.heading2,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            (widget.organization.status
                                                        .toString() ==
                                                    '1')
                                                ? LineIcons.checkCircle
                                                : LineIcons.timesCircle,
                                            color: (widget.organization.status
                                                        .toString() ==
                                                    '1')
                                                ? Colors.green
                                                : Colors.red,
                                            size: 25,
                                          ),
                                          SizedBox(width: 16),
                                          (widget.organization.status
                                                      .toString() ==
                                                  '1')
                                              ? Expanded(
                                                  child: Text(
                                                    'Active'.tr,
                                                    style:
                                                        styles.heading2active,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                )
                                              : Expanded(
                                                  child: Text(
                                                    'Inactive'.tr,
                                                    style:
                                                        styles.heading2inactive,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'List of Members'.tr +
                                      ' (' +
                                      _memberModel.length.toString() +
                                      ')',
                                  style: styles.heading5bold,
                                ),
                              ),
                              SizedBox(height: 20),
                              Divider(
                                color: constants.primaryColor,
                                thickness: 5,
                              ),
                              SizedBox(height: 20),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: _memberModel.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var _isAdmin =
                                        _memberModel[index].isAdmin.toString();

                                    //! promote to admin
                                    void promoteToAdmin(
                                        BuildContext context) async {
                                      var response =
                                          await promoteUserToAdminConfirmation(
                                              context, [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 20),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Confirm appointment of".tr +
                                                    ' ' +
                                                    _memberModel[index]
                                                        .user!
                                                        .firstName
                                                        .toString() +
                                                    ' ' +
                                                    _memberModel[index]
                                                        .user!
                                                        .lastName
                                                        .toString() +
                                                    ' ' +
                                                    'as Organization Administrator?'
                                                        .tr,
                                                style: TextStyle(
                                                  color: Color(0xff666666),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        )
                                      ]);
                                      if (response == 'yes') {
                                        try {
                                          var response = await api
                                              .promoteUserToAdminOrganization(
                                            widget.organization.id,
                                            _memberModel[index].user!.id,
                                          );
                                          if (response.isSuccessful) {
                                            snack(
                                                context,
                                                'Members are successfully appointed as administrators of the organization.'
                                                    .tr,
                                                level: SnackLevel.Success);
                                            // back(context);
                                            setState(() {
                                              _getData();
                                            });
                                            return;
                                          } else {
                                            hideSnacks(context);
                                            Get.snackbar(
                                              snackPosition: SnackPosition.TOP,
                                              "".tr,
                                              response.message,
                                              messageText: Text(
                                                response.message,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              padding: EdgeInsets.only(
                                                  bottom: 30, left: 16),
                                              backgroundColor: Colors.red,
                                            );
                                          }
                                        } catch (e) {
                                          snack(
                                              context,
                                              "There is a problem connecting to the server. Please try again."
                                                  .tr);
                                        }
                                      }
                                    }

                                    //! demote to user
                                    void demoteToUser(
                                        BuildContext context) async {
                                      var response =
                                          await demoteConfirmation(context, [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 20),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Confirm demotion of".tr +
                                                    ' ' +
                                                    _memberModel[index]
                                                        .user!
                                                        .firstName
                                                        .toString() +
                                                    ' ' +
                                                    _memberModel[index]
                                                        .user!
                                                        .lastName
                                                        .toString() +
                                                    ' ' +
                                                    'as Organization Administrator?'
                                                        .tr,
                                                style: TextStyle(
                                                  color: Color(0xff666666),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        )
                                      ]);

                                      if (response == 'yes') {
                                        try {
                                          var response = await api
                                              .demoteAdminToUserOrganization(
                                            widget.organization.id,
                                            _memberModel[index].user!.id,
                                          );
                                          if (response.isSuccessful) {
                                            snack(
                                                context,
                                                'The organization member was successfully demoted.'
                                                    .tr,
                                                level: SnackLevel.Success);
                                            // back(context);
                                            setState(() {
                                              _getData();
                                            });
                                            return;
                                          } else {
                                            hideSnacks(context);
                                            Get.snackbar(
                                              snackPosition: SnackPosition.TOP,
                                              "".tr,
                                              response.message,
                                              messageText: Text(
                                                response.message,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              padding: EdgeInsets.only(
                                                  bottom: 30, left: 16),
                                              backgroundColor: Colors.red,
                                            );
                                          }
                                        } catch (e) {
                                          snack(
                                              context,
                                              "There is a problem connecting to the server. Please try again."
                                                  .tr);
                                        }
                                      }
                                    }

                                    //! kick user / admin
                                    void deleteOrganization(
                                        BuildContext context) async {
                                      var response =
                                          await deleteConfirmation(context, [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 20),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Confirm remove".tr +
                                                    ' ' +
                                                    _memberModel[index]
                                                        .user!
                                                        .firstName
                                                        .toString() +
                                                    ' ' +
                                                    _memberModel[index]
                                                        .user!
                                                        .lastName
                                                        .toString() +
                                                    ' ' +
                                                    'from organization?'.tr,
                                                style: TextStyle(
                                                  color: Color(0xff666666),
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        )
                                      ]);

                                      if (response == 'yes') {
                                        try {
                                          var response = await api
                                              .deleteMemberAdminOrganization(
                                            widget.organization.id,
                                            _memberModel[index].user!.id,
                                          );
                                          if (response.isSuccessful) {
                                            snack(
                                                context,
                                                'The organization member was successfully deleted'
                                                    .tr,
                                                level: SnackLevel.Success);
                                            // back(context);

                                            setState(() {
                                              _getData();
                                            });

                                            return;
                                          } else {
                                            hideSnacks(context);
                                            Get.snackbar(
                                              snackPosition: SnackPosition.TOP,
                                              "".tr,
                                              response.message,
                                              messageText: Text(
                                                response.message,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              padding: EdgeInsets.only(
                                                  bottom: 30, left: 16),
                                              backgroundColor: Colors.red,
                                            );
                                          }
                                        } catch (e) {
                                          snack(
                                              context,
                                              "There is a problem connecting to the server. Please try again."
                                                  .tr);
                                        }
                                      }
                                    }

                                    //! Swipe for action
                                    return SlidableAutoCloseBehavior(
                                      closeWhenTapped: true,
                                      child: Slidable(
                                        groupTag: '0',
                                        key: UniqueKey(),
                                        closeOnScroll: false,
                                        endActionPane: _isCheckAdmin == true
                                            ? ActionPane(
                                                motion: DrawerMotion(),
                                                children: [
                                                  SlidableAction(
                                                    autoClose: false,
                                                    onPressed: _isAdmin == '1'
                                                        ? demoteToUser
                                                        : promoteToAdmin,
                                                    backgroundColor: _isAdmin ==
                                                            '1'
                                                        ? Colors.grey
                                                        : constants.sixColor,
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: LineIcons.userAlt,
                                                    label: _isAdmin == '1'
                                                        ? 'Lucut'
                                                        : 'Lantik',
                                                  ),
                                                  SlidableAction(
                                                    autoClose: false,
                                                    onPressed:
                                                        deleteOrganization,
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    foregroundColor:
                                                        Colors.white,
                                                    icon: Icons.delete,
                                                    label: 'Hapus',
                                                  ),
                                                ],
                                              )
                                            : _memberModel[index]
                                                        .user!
                                                        .id
                                                        .toString() ==
                                                    state.user.id.toString()
                                                ? ActionPane(
                                                    motion: DrawerMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        autoClose: false,
                                                        onPressed:
                                                            deleteOrganization,
                                                        backgroundColor:
                                                            Colors.redAccent,
                                                        foregroundColor:
                                                            Colors.white,
                                                        icon: Icons.delete,
                                                        label: 'Hapus',
                                                      ),
                                                    ],
                                                  )
                                                : null,
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Card(
                                            color: constants.secondaryColor,
                                            child: ListTile(
                                              title: Padding(
                                                padding: _isAdmin == '1'
                                                    ? EdgeInsets.only(
                                                        top: 20, bottom: 20)
                                                    : EdgeInsets.only(
                                                        top: 0, bottom: 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(LineIcons.user),
                                                        SizedBox(width: 16),
                                                        Expanded(
                                                          child: Text(
                                                            _memberModel[index]
                                                                    .user!
                                                                    .firstName
                                                                    .toString() +
                                                                ' ' +
                                                                _memberModel[
                                                                        index]
                                                                    .user!
                                                                    .lastName
                                                                    .toString(),
                                                            style: styles
                                                                .heading6bold,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            LineIcons.envelope),
                                                        SizedBox(width: 16),
                                                        Expanded(
                                                          child: Text(
                                                            _memberModel[index]
                                                                .user!
                                                                .email
                                                                .toString(),
                                                            style:
                                                                styles.heading3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                            (_isAdmin == '1')
                                                                ? LineIcons
                                                                    .userSecret
                                                                : LineIcons
                                                                    .userCircle,
                                                            color: (_isAdmin ==
                                                                    '1')
                                                                ? constants
                                                                    .sixColor
                                                                : null),
                                                        SizedBox(width: 16),
                                                        (_isAdmin == '1')
                                                            ? Expanded(
                                                                child: Text(
                                                                  'Administrator'
                                                                      .tr,
                                                                  style: styles
                                                                      .heading6boldYellow,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              )
                                                            : Expanded(
                                                                child: Text(
                                                                  'Member'.tr,
                                                                  style: styles
                                                                      .heading3,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    )
            ])));
  }
}
