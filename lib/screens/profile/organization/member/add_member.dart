import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/models/users/add_member.dart';
import 'package:flutterbase/models/users/identity_type.dart';
import 'package:flutterbase/models/users/list_add_member.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddMemberScreen extends StatefulWidget {
  final Organization organization;
  const AddMemberScreen(this.organization, {Key? key});

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  TextEditingController verifiedIcNo = TextEditingController();

  bool _isBtnAddDisable = false;
  int userIdentityTypeId = 1;

  int characterCount = 12;
  String identityTypeLabel = 'Kad Pengenalan';

  int? orgID;
  List<ListLocalAddMember> userInfo = [];
  List<IdentityType> _identityTypeAllModel = [];

  var maskFormatter =
      new MaskTextInputFormatter(mask: "", type: MaskAutoCompletionType.lazy);

  List<AddMember> _addMemberModel = [];

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
    var oId = widget.organization.id;
    orgID = oId;

    _identityType();
    _getCharacterCount();
  }

  void _identityType() async {
    _identityTypeAllModel = await api.getIndentityTypeAll();

    _identityTypeAllModel.sort((a, b) {
      return a.type!.toLowerCase().compareTo(b.type!.toLowerCase());
    });
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  // onChange validation chracter count
  void _getCharacterCount() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));

    // print('Execeute this api character count!');

    await api.getCharacterCount(userIdentityTypeId);
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          characterCount = store.getItem('characterCountLS');
          identityTypeLabel = store.getItem('typeLS');

          // print(characterCount);
          // print(identityTypeLabel);
          Navigator.pop(context);
        }));
  }

  String generateMask() {
    var mask = '';
    for (var i = 0; i < characterCount; i++) {
      mask += '#';
    }
    return mask;
  }

  String generateHintText() {
    var mask = '';
    for (var i = 0; i < characterCount; i++) {
      mask += '_ ';
    }
    return mask;
  }

  // Validate identity code user
  void _validateUser() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));

    _addMemberModel = await api.getOrganizationUserByIc(
        verifiedIcNo.text, userIdentityTypeId);

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          if (_addMemberModel.isNotEmpty) {
            userInfo.add(ListLocalAddMember(
                icNo: verifiedIcNo.text,
                firstName: _addMemberModel[0].firstName!,
                lastName: _addMemberModel[0].lastName!));

            if (userInfo.isNotEmpty) {
              _isShowList = true;
              _isEnabled = true;
            } else {
              _isEnabled = false;
              _isShowList = false;
            }
          } else {
            snack(context, 'No users found.'.tr, level: SnackLevel.Error);
          }
          Navigator.pop(context);
        }));
  }

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isEnabled = false;
  bool _isShowList = false;

  bool _isNumber = true;

  @override
  Widget build(BuildContext context) {
    maskFormatter.updateMask(mask: generateMask());

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              'Add Member'.tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Enter the user ID number to add a member to the organization"
                        .tr,
                    style: styles.heading5,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Container(
                    child: new DropdownButtonFormField(
                      value: userIdentityTypeId,
                      isExpanded: true,
                      decoration: styles.inputDecoration.copyWith(
                        label: getRequiredLabel('User ID Type'.tr),
                      ),
                      items: _identityTypeAllModel.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item.type!),
                          value: item.id,
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'This field cannot be left blank.'.tr;
                        }
                        return null;
                      },
                      onChanged: (newVal) {
                        setState(() {
                          verifiedIcNo.clear();
                          print(newVal);
                          userIdentityTypeId = newVal as int;
                          if (newVal == 2) {
                            _isNumber = false;
                          } else {
                            _isNumber = true;
                          }
                          _getCharacterCount();
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          // maxLength: characterCount,
                          controller: verifiedIcNo,
                          style: styles.heading2,
                          keyboardType: _isNumber
                              ? TextInputType.number
                              : TextInputType.text,
                          inputFormatters: _isNumber
                              ? [maskFormatter]
                              : [
                                  LengthLimitingTextInputFormatter(
                                      characterCount)
                                ],
                          decoration: styles.inputDecoration.copyWith(
                            labelText: 'Number '.tr + identityTypeLabel,
                            hintStyle: styles.heading2,
                            hintText: generateHintText(),
                            // suffixIcon: Icon(LineIcons.identificationBadge),
                          ),
                          onChanged: (val) {
                            setState(() {
                              val = verifiedIcNo.text;

                              if (val.length == characterCount) {
                                _isBtnAddDisable = true;
                              } else {
                                _isBtnAddDisable = false;
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Card(
                          color: _isBtnAddDisable
                              ? constants.sixColor
                              : constants.secondaryColor,
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: _isBtnAddDisable
                                ? () {
                                    setState(() {
                                      // userInfo.add(verifiedIcNo.text);
                                      _isBtnAddDisable = false;
                                      // verifiedIcNo.clear();
                                      _validateUser();

                                      print(userInfo.toString() +
                                          ': INI ADALAH USER INFO');

                                      print(userInfo.length.toString() +
                                          ': INI ADALAH PANJANG USER INFO');
                                    });
                                  }
                                : null,
                            child: Container(
                              height: 55,
                              child: Icon(LineIcons.plusCircle),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _isShowList,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Card(
                        color: constants.secondaryColor,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (var item in userInfo)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              // color: Colors.blue,
                                              // height: 50,
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      print(item);
                                                      print(userInfo.length);
                                                      if (userInfo.length ==
                                                          1) {
                                                        userInfo.removeAt(
                                                            userInfo
                                                                .indexOf(item));
                                                        _isShowList = false;
                                                        _isEnabled = false;
                                                      } else if (userInfo
                                                              .length >
                                                          1) {
                                                        userInfo.removeAt(
                                                            userInfo
                                                                .indexOf(item));
                                                      }
                                                    });
                                                  },
                                                  child: Icon(
                                                    LineIcons.trash,
                                                    color: Colors.redAccent,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                // color: Colors.redAccent,
                                                // height: 50,
                                                child: Center(
                                                  child: Text(
                                                      item.firstName +
                                                          ' ' +
                                                          item.lastName,
                                                      maxLines: 1,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                // color: Colors.green,
                                                // height: 50,
                                                child: Center(
                                                  child: Text(item.icNo,
                                                      style:
                                                          styles.heading6bold),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Column(
                      children: [
                        _isLoading
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: DefaultLoadingBar(),
                              )
                            : PrimaryButton(
                                isLoading: _isLoading,
                                text: 'Add'.tr,
                                onPressed: !_isEnabled
                                    ? null
                                    : () async {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          try {
                                            var response = await api.addMember(
                                                orgID!, userInfo);
                                            if (response.isSuccessful) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              snack(
                                                  context,
                                                  'Member successfully added'
                                                      .tr,
                                                  level: SnackLevel.Success);

                                              return;
                                            }
                                            hideSnacks(context);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            snack(
                                              context,
                                              response.message,
                                              level: SnackLevel.Error,
                                            );
                                          } catch (e) {
                                            snack(
                                                context,
                                                "There is a problem connecting to the server. Please try again."
                                                    .tr);
                                          }
                                        }
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
