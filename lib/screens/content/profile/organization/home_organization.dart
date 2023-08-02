import 'package:flutter/scheduler.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/screens/content/profile/organization/add_organization.dart';
import 'package:flutterbase/screens/content/profile/organization/tab_main_organization.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/helpers.dart';

class HomeOrganizationScreen extends StatefulWidget {
  @override
  State<HomeOrganizationScreen> createState() => _HomeOrganizationScreenState();
}

class _HomeOrganizationScreenState extends State<HomeOrganizationScreen> {
  // ignore: unused_field
  bool _isAdmin = true;
  List<Organization> _organizationModel = [];
  int? orgId;
  int? userId;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _organizationModel = await api.getOrganization();
    userId = state.user.id;
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  Widget buildTile(Organization organization) => ListTile(
        title: Text(organization.orgName!),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            LineIcons.angleLeft,
            color: Colors.white,
          ),
          onPressed: () => back(context),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              'List of Organizations'.tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
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
                        Icon(LineIcons.plusCircle, color: constants.paleWhite),
                        SizedBox(width: 10),
                        Text(
                          "Register Organization".tr,
                          style: styles.heading6boldPaleWhite,
                        )
                      ],
                    ),
                  ),
                  onPressed: () {
                    navigate(context, AddOrganizationScreen());
                  }),
            ),
            _organizationModel.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        children: [
                          Text(
                            'There is no organization registered under this user.'
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
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'List of Organizations'.tr +
                                ' (' +
                                _organizationModel.length.toString() +
                                ')',
                            style: styles.heading5bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Divider(
                          color: constants.primaryColor,
                          thickness: 5,
                        ),
                      ],
                    ),
                  ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _organizationModel.length,
              itemBuilder: (context, index) {
                void activateOrganization(BuildContext context) async {
                  var oId = _organizationModel[index].id;
                  await api.checkAdminOrganization(oId, state.user.id);
                  setState(() async {
                    if (store.getItem('isMemberAdminLS').toString() ==
                        'Pentadbir') {
                      _isAdmin = true;

                      if (_organizationModel[index].status.toString() == '1') {
                        var response = await deactivateConfirmation(context, [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 0, 20),
                            child: Column(
                              children: [
                                Text(
                                  "Are you sure to deactivate the organization"
                                          .tr +
                                      ' ' +
                                      _organizationModel[index]
                                          .orgName
                                          .toString() +
                                      "?",
                                  style: TextStyle(color: Color(0xff666666)),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          )
                        ]);
                        if (response == 'yes') {
                          try {
                            var response =
                                await api.updateStatusAdminOrganization(
                                    _organizationModel[index].id, userId);
                            if (response.isSuccessful) {
                              snack(
                                  context,
                                  'Successfully deactivated the organization'
                                      .tr,
                                  level: SnackLevel.Success);

                              setState(() {
                                _getData();
                              });

                              return;
                            } else {
                              hideSnacks(context);
                              snack(
                                  context,
                                  'Please contact the system administrator to activate the organization.'
                                      .tr,
                                  level: SnackLevel.Error);
                            }
                          } catch (e) {
                            snack(
                                context,
                                "There is a problem connecting to the server. Please try again."
                                    .tr);
                          }
                        }
                      } 
                    } 
                  });
                }
                return SlidableAutoCloseBehavior(
                  closeWhenTapped: true,
                  child: Slidable(
                    groupTag: '0',
                    key: UniqueKey(),
                    closeOnScroll: false,
                    endActionPane: _organizationModel[index].isAdmin == true && _organizationModel[index].status.toString() == '1'
                        ? ActionPane(
                            motion: DrawerMotion(),
                            children: [
                              SlidableAction(
                                autoClose: false,
                                onPressed: activateOrganization,
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                icon: LineIcons.timesCircle,
                                label: 'Deactivate'.tr,
                              ),
                            ],
                          )
                        : null,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                            child: Card(
                              color: (_organizationModel[index]
                                          .status
                                          .toString() ==
                                      '1')
                                  ? Color(0xffF1F3F6)
                                  : Color.fromARGB(255, 200, 203, 207),
                              child: InkWell(
                                onTap: () {
                                  print(index);
                                  setState(() {
                                    orgId = _organizationModel[index].id;
                                  });
                                  if (_organizationModel[index]
                                          .status
                                          .toString() ==
                                      '1') {
                                    navigate(
                                        context,
                                        TabMainOrganizationScreen(
                                            _organizationModel[index]));
                                  } else {
                                    snack(
                                        context,
                                        'Please contact the system administrator to activate the organization.'
                                            .tr,
                                        level: SnackLevel.Error);
                                  }
                                },
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(LineIcons.building),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Text(
                                                _organizationModel[index]
                                                    .orgName
                                                    .toString(),
                                                style: styles.heading6bold,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(LineIcons.phone),
                                            SizedBox(width: 16),
                                            Text(
                                              _organizationModel[index]
                                                  .phoneNo
                                                  .toString(),
                                              style: styles.heading2,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(LineIcons.envelope),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Text(
                                                  _organizationModel[index]
                                                      .orgEmail
                                                      .toString(),
                                                  style: styles.heading2,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(LineIcons.mapPin),
                                            SizedBox(width: 16),
                                            Expanded(
                                              child: Text(
                                                _organizationModel[index]
                                                    .address1
                                                    .toString(),
                                                style: styles.heading2,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              (_organizationModel[index]
                                                          .status
                                                          .toString() ==
                                                      '1')
                                                  ? LineIcons.checkCircle
                                                  : LineIcons.timesCircle,
                                              color: (_organizationModel[index]
                                                          .status
                                                          .toString() ==
                                                      '1')
                                                  ? Colors.green
                                                  : Colors.red,
                                              size: 25,
                                            ),
                                            SizedBox(width: 16),
                                            (_organizationModel[index]
                                                        .status
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
                                                      'Not Active'.tr,
                                                      style: styles
                                                          .heading2inactive,
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
