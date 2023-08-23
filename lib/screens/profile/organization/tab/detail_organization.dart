import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/screens/profile/organization/home_organization.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/models/users/city.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/models/organizations/organization_type.dart';
import 'package:flutterbase/models/users/postcode_city.dart';
import 'package:flutterbase/models/users/postcode_state.dart';
import 'package:flutterbase/models/users/states.dart';
import 'package:flutterbase/models/users/district.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

enum SingingCharacter { citizenship, nonCitizenship }

class DetailOrganizationScreen extends StatefulWidget {
  final Organization organization;
  const DetailOrganizationScreen(this.organization, {Key? key});
  @override
  _DetailOrganizationScreenState createState() =>
      _DetailOrganizationScreenState();
}

class _DetailOrganizationScreenState extends State<DetailOrganizationScreen> {
  // TextEditingController organizationNoController = TextEditingController();
  // var maskFormatter;

  var maskFormatterPhone = new MaskTextInputFormatter(mask: "", type: MaskAutoCompletionType.lazy);
  var maskFormatterPostcode = new MaskTextInputFormatter(mask: "", type: MaskAutoCompletionType.lazy);

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // print('Organisasi type id: ' + orgTypeId.toString());

    _getData();
    _getOrganization();
    _getCharacterCount();
    // if (orgTypeId == 6) {
    //   print('Show SSM');
    //   _isShowCheckOldSSM = false;
    //   _isShowSSM = true;
    // } else if (orgTypeId == 7) {
    //   print('Show ROS');
    //   _isShowROS = true;
    // } else {
    //   print('Show SKM');
    //   _isShowSKM = true;
    // }
    onChangedPostcode(postcode);
    onChangedEmail(orgEmail);

    //* Get admin status from member organization table
  }

  bool _isFormEmpty() {
    if (orgEmail.isEmpty ||
        orgName.isEmpty ||
        orgTypeId == null ||
        orgRegistrationNo.isEmpty ||
        // dateinput.text.isEmpty ||
        phoneNo.isEmpty ||
        address1.isEmpty ||
        postcode.isEmpty ||
        stateId == null ||
        districtId == null ||
        cityId == null) {
      return true;
    }

    return false;
  }

  // Fix postcode not valid error message
  String getPostcodeStatusLS = 'null';
  bool _isDisablePostcodeValid = true;

  final _formKey = GlobalKey<FormState>();

  List<States> _statesModel = [];
  List<District> _districtModel = [];
  List<City> _cityModel = [];
  List<OrganizationType> _orgTypeModel = [];
  // ignore_for_file: unused_field
  List<PostcodeCity> _postcodeCityModel = [];
  List<PostcodeState> _postcodeStateModel = [];

  int? orgId;
  String orgName = '';
  String orgEmail = '';
  int? orgTypeId;
  String orgRegistrationNo = '';
  String dateExtablished = '';
  DateTime dateExtablishedDisplay = DateTime.now();
  String dateDisplay = '';
  String address1 = '';
  String address2 = '';
  String address3 = '';
  String postcode = '';
  String phoneNo = '';
  int? countryId = 458;
  int? stateId;
  int? districtId;
  int? cityId;
  int? userId;

  String stateName = '';
  String districtName = '';
  String cityName = '';

  bool isChecked = false;
  bool _isLoading = false;
  bool _isReadOnly = false;
  bool _isDisable = true;
  bool _isFilled = true;
  bool _isCanUpdated = true;
  bool _isCanStored = false;
  bool _isVisibleBtnSubmit = false;
  bool _isEmailValid = false;
  bool _isPostCodeValid = true;
  bool _isCheckOldSSM = false;
  bool _isShowCheckOldSSM = false;
  bool _isShowOldSSM = false;
  bool _isShowSSM = false;
  bool _isShowROS = false;
  bool _isShowSKM = false;
  bool _sizedBox = true;
  bool _isAdmin = false;

  void _getOrganization() async {
    orgId = widget.organization.id;
    orgName = widget.organization.orgName.toString();
    orgEmail = widget.organization.orgEmail.toString();
    orgTypeId = widget.organization.orgTypeId;
    orgRegistrationNo = widget.organization.orgRegistrationNo.toString();
    dateExtablished = widget.organization.dateExtablished.toString();
    dateExtablishedDisplay =
        DateTime.tryParse(widget.organization.dateExtablished.toString())!;
    address1 = widget.organization.address1.toString();
    address2 = widget.organization.address2?.toString() ?? '';
    address3 = widget.organization.address3?.toString() ?? '';
    postcode = widget.organization.postcode.toString();
    phoneNo = widget.organization.phoneNo.toString();
    stateId = widget.organization.stateId;
    districtId = widget.organization.districtId;
    cityId = widget.organization.cityId;
    userId = widget.organization.userId;

    // organizationNoController.text =
    //     widget.organization.orgRegistrationNo.toString();

    // maskFormatter = new MaskTextInputFormatter(
    //     mask: "AAA-###-##-########",
    //     initialText: orgRegistrationNo,
    //     type: MaskAutoCompletionType.lazy);

    // value = maskFormatter.updateMask(mask: "##-##-##-##");
    dateDisplay = dateFormatterDisplay.format(dateExtablishedDisplay);
    print(dateFormatterDisplay.format(dateExtablishedDisplay));
    print(dateExtablished);
  }

  void _getData() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _statesModel = await api.getStates();
    _orgTypeModel = await api.getOrganizationType();
    _districtModel = await api.getDistrict(stateId!);
    _cityModel = await api.getCity();
    _getDataCheckAdmin();
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  // Check if admin
  void _getDataCheckAdmin() async {
    var oId = widget.organization.id;
    await api.checkAdminOrganization(oId, state.user.id);
    setState(() {
      if (store.getItem('isMemberAdminLS').toString() == 'Pentadbir') {
        _isAdmin = true;
      } else {
        _isAdmin = false;
      }
    });
  }

  // Group postcode api
  void _getDataPostcodeCityState() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _getDataPostcodeState();
    _getDataPostcodeCity();

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  void _getDataPostcodeState() async {
    _postcodeStateModel = await api.getPostcodeState(postcode);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _postcodeStateModel.map((item) {
            stateId = item.id;
            _getDataDistrict();
          }).toList();
        }));
  }

  void _getDataDistrict() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _districtModel = await api.getDistrict(stateId!);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  void _getDataPostcodeCity() async {
    _postcodeCityModel = await api.getPostcodeCity(postcode);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          getPostcodeStatusLS = store.getItem('postcodeValidLS');

          if (getPostcodeStatusLS == 'data') {
            _isPostCodeValid = true;
            _isDisablePostcodeValid = true;
            print('Postcode is Valid');
          } else if (getPostcodeStatusLS == 'empty') {
            _isPostCodeValid = false;
            _isDisablePostcodeValid = false;
            print('Postcode is not Valid');
          }
          _postcodeCityModel.map((item) {
            cityId = item.id;
          }).toList();
        }));
  }

// RegexExp
  final emailRE = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final postcodeRE = RegExp(r"^\b\d{5}\b$");
  final phoneRE = RegExp(r"^[+.]?\d+\b$|^[+.]$");
  final nameRE = RegExp(r"^(?=.{3})[a-zA-Z0-9_\-=@/',\.;\s]+$");

  // Email
  onChangedEmail(String emailPattern) {
    setState(
      () {
        _isEmailValid = false;
        if (emailRE.hasMatch(emailPattern)) _isEmailValid = true;
      },
    );
  }

  // PostCode
  onChangedPostcode(String postCodePattern) {
    setState(
      () {
        _isPostCodeValid = false;
        if (postcodeRE.hasMatch(postCodePattern)) _isPostCodeValid = true;
      },
    );
  }

  int characterCount = 20;
  bool _isFetching = false;
  String identityTypeLabel = '';

  // onChange validation character count
  void _getCharacterCount() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    await api.getCharacterCount(orgTypeId!);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          identityTypeLabel = store.getItem('codeLS') ?? '';

          // Change label identity type label
          // if (orgTypeId == 6) {
          //   identityTypeLabel = 'SSM';
          // } else if (orgTypeId == 7) {
          //   identityTypeLabel = 'ROS';
          // }
          Navigator.pop(context);
        }));
  }

  // var textEditingController = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    maskFormatterPhone.updateMask(mask: generateMask(20), filter: { "#": RegExp(r"^[+.]?\d+\b$|^[+.]$") });
    maskFormatterPostcode.updateMask(mask: generateMask(5), filter: { "#": RegExp(r'^\d{0,5}$') });
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListTile(
          title: ListView(
            children: [
              SizedBox(height: 20),
              Visibility(
                visible: _isAdmin,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Expanded(
                    //   child: SizedBox(
                    //     child: Divider(
                    //       color: constants.primaryColor,
                    //       thickness: 5,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(width: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isCanUpdated
                                  ? Constants().sixColor
                                  : Colors.redAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(LineIcons.edit),
                                SizedBox(width: 2),
                                _isCanUpdated
                                    ? Text("Update".tr)
                                    : Text("Cancel".tr)
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                _isReadOnly = !_isReadOnly;
                                _isDisable = !_isDisable;
                                _isFilled = !_isFilled;
                                _isCanStored = !_isCanStored;
                                _isCanUpdated = !_isCanUpdated;
                                _isVisibleBtnSubmit = !_isVisibleBtnSubmit;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              IgnorePointer(
                ignoring: true,
                child: DropdownButtonFormField(
                  icon: Visibility(
                      visible: false, child: Icon(Icons.arrow_downward)),
                  isExpanded: true,
                  decoration: styles.inputDecoration.copyWith(
                    enabledBorder: OutlineInputBorder(
                      borderSide: _isDisable
                          ? BorderSide(color: constants.secondaryColor)
                          : BorderSide(color: constants.secondaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    label: getRequiredLabel('Organization Type'.tr),
                    filled: true,
                  ),
                  items: _orgTypeModel.map((item) {
                    return new DropdownMenuItem(
                      child: new Text(item.type!,
                          style: TextStyle(color: Colors.grey)),
                      value: item.id,
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Sila pilih jenis organisasi';
                    }
                    return null;
                  },
                  onChanged: (newVal) {
                    setState(() {
                      orgTypeId = newVal as int;
                      print(orgTypeId);
                      if (orgTypeId == 6) {
                        //show SSM & LAMA
                        _isShowCheckOldSSM = true;
                        _isShowSSM = true;
                        _isShowROS = false;
                        _isShowSKM = false;
                        orgRegistrationNo = '';
                      } else if (orgTypeId == 7) {
                        //show ROS
                        _isShowCheckOldSSM = false;
                        _isShowOldSSM = false;
                        _isShowSSM = false;
                        _isShowROS = true;
                        _isShowSKM = false;
                        orgRegistrationNo = '';
                      } else if (orgTypeId == 8) {
                        //show SKM
                        _isShowOldSSM = false;
                        _isShowCheckOldSSM = false;
                        _isShowSSM = false;
                        _isShowROS = false;
                        _isShowSKM = true;
                        orgRegistrationNo = '';
                      }
                    });
                  },
                  value: orgTypeId,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: styles.inputDecoration.copyWith(
                   label: getRequiredLabel("@identityTypeLabel Registration No."
                      .trParams({'identityTypeLabel.': identityTypeLabel})),
                  filled: true,
                ),
                initialValue: orgRegistrationNo,
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: false,
                decoration: styles.inputDecoration.copyWith(
                  label: getRequiredLabel('Establishment Date'.tr),
                  filled: true,
                ),
                // initialValue: dateFormatter.format(dateExtablished),
                initialValue: dateDisplay.toString(),
                onChanged: (val) {
                  setState(() {
                    dateExtablished = val;
                    print(dateExtablished);
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                autofocus: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                enabled: _isReadOnly,
                decoration: styles.inputDecoration.copyWith(
                    label: getRequiredLabel('Organization Email'.tr),
                    filled: _isFilled,
                    suffixIcon: _isDisable
                        ? null
                        : _isEmailValid
                            ? IconTheme(
                                data: IconThemeData(color: Colors.green),
                                child: Icon(
                                  LineIcons.checkCircle,
                                ))
                            : IconTheme(
                                data: IconThemeData(color: Colors.red),
                                child: Icon(
                                  LineIcons.timesCircle,
                                ))),
                initialValue: orgEmail,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be left blank.'.tr;
                  } else if (!emailRE.hasMatch(value)) {
                    return 'Your organization email is invalid'.tr;
                  }
                  return null;
                },
                onChanged: (val) {
                  onChangedEmail(orgEmail);
                  orgEmail = orgEmail;
                  setState(() {
                    orgEmail = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: _isReadOnly,
                textInputAction: TextInputAction.next,
                decoration: styles.inputDecoration.copyWith(
                  label: getRequiredLabel('Organization Name'.tr),
                  filled: _isFilled,
                ),
                initialValue: orgName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be left blank.'.tr;
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    orgName = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: _isReadOnly,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [maskFormatterPhone],
                decoration: styles.inputDecoration.copyWith(
                  hintText: generateHintText(20),
                  label: getRequiredLabel('Phone Number'.tr),
                  filled: _isFilled,
                ),
                initialValue: phoneNo.toString(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be left blank.'.tr;
                  } else if (!phoneRE.hasMatch(value) || value.length < 2) {
                    return 'Your phone number is invalid'.tr;
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    phoneNo = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: _isReadOnly,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                decoration: styles.inputDecoration.copyWith(
                  label: getRequiredLabel('Address 1'.tr),
                  filled: _isFilled,
                ),
                initialValue: address1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be left blank.'.tr;
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    address1 = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: _isReadOnly,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                decoration: styles.inputDecoration.copyWith(
                  labelText: 'Address 2'.tr,
                  filled: _isFilled,
                ),
                initialValue: address2,
                onChanged: (val) {
                  setState(() {
                    address2 = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: _isReadOnly,
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.next,
                decoration: styles.inputDecoration.copyWith(
                  labelText: 'Address 3'.tr,
                  filled: _isFilled,
                ),
                initialValue: address3,
                onChanged: (val) {
                  setState(() {
                    address3 = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: _isReadOnly,
                // maxLength: 5,
                textAlign: TextAlign.start,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
                inputFormatters: [maskFormatterPostcode],
                decoration: styles.inputDecoration.copyWith(
                  hintText: generateHintText(5),
                    label: getRequiredLabel('Postcode'.tr),
                    filled: _isFilled,
                    errorMaxLines: 5,
                    suffixIcon: _isDisable
                        ? null
                        : _isPostCodeValid
                            ? IconTheme(
                                data: IconThemeData(color: Colors.green),
                                child: Icon(
                                  LineIcons.checkCircle,
                                ))
                            : IconTheme(
                                data: IconThemeData(color: Colors.red),
                                child: Icon(
                                  LineIcons.timesCircle,
                                ))),
                initialValue: postcode,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be left blank.'.tr;
                  } else if (!postcodeRE.hasMatch(value)) {
                    return 'The postcode you entered is invalid. Please contact the system administrator'
                        .tr;
                  } else if (getPostcodeStatusLS == 'empty') {
                    return 'The postcode you entered is invalid. Please contact the system administrator'
                        .tr;
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    postcode = val;
                    onChangedPostcode(postcode);
                    postcode = postcode;
                    if (postcode.length >= 5) {
                      _getDataPostcodeCityState();
                    } else {
                      stateId = null;
                      cityId = null;
                      districtId = null;
                    }
                  });
                },
              ),
              SizedBox(height: 20),
              IgnorePointer(
                ignoring: true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: DropdownButtonFormField(
                    icon: Visibility(
                        visible: false, child: Icon(Icons.arrow_downward)),
                    isExpanded: true,
                    decoration: styles.inputDecoration.copyWith(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: getRequiredLabel('State'.tr),
                      filled: true,
                    ),
                    items: _statesModel.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item.name!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey)),
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
                        // districtID = null;
                        // cityID = null;
                        // stateID = newVal as int?;
                        // print(stateID);
                        // _getDataDistrict();
                        stateId = newVal as int?;
                      });
                    },
                    value: stateId,
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: _isDisable
                    ? true
                    : _isPostCodeValid
                        ? false
                        : true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: DropdownButtonFormField(
                    icon: Visibility(
                        visible: false,
                        child: Icon(LineIcons.chevronCircleDown)),
                    isExpanded: true,
                    decoration: styles.inputDecoration.copyWith(
                        suffixIcon: _isDisable
                            ? null
                            : _isPostCodeValid
                                ? Icon(LineIcons.chevronCircleDown)
                                : null,
                        enabledBorder: OutlineInputBorder(
                          borderSide: _isDisable
                              ? BorderSide(color: constants.secondaryColor)
                              : BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        label: getRequiredLabel('District'.tr),
                        filled: _isDisable
                            ? true
                            : _isPostCodeValid
                                ? false
                                : true),
                    items: _districtModel.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item.name!,
                            overflow: TextOverflow.ellipsis,
                            style: _isReadOnly
                                ? TextStyle(color: Colors.black)
                                : TextStyle(color: Colors.grey)),
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
                        // districtID = null;
                        // cityID = null;
                        // stateID = newVal as int?;
                        // print(stateID);
                        // _getDataDistrict();
                        districtId = newVal as int?;
                      });
                    },
                    value: districtId,
                  ),
                ),
              ),
              IgnorePointer(
                ignoring: true,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: DropdownButtonFormField(
                    icon: Visibility(
                        visible: false,
                        child: Icon(LineIcons.chevronCircleDown)),
                    value: cityId,
                    isExpanded: true,
                    decoration: styles.inputDecoration.copyWith(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      label: getRequiredLabel('City'.tr),
                      filled: true,
                    ),
                    items: _cityModel.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item.name!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.grey)),
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
                        cityId = newVal as int?;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              Visibility(
                visible: _isVisibleBtnSubmit,
                child: Column(
                  children: [
                    _isLoading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: DefaultLoadingBar(),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: PrimaryButton(
                                isLoading: _isLoading,
                                text: 'Save'.tr,
                                onPressed: _isFormEmpty()
                                    ? null
                                    : () async {
                                        setState(() {
                                          _isLoading = true;
                                          print(orgEmail);
                                        });
                                        if (_formKey.currentState!.validate()) {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          try {
                                            var response =
                                                await api.updateOrganization(
                                              orgId!,
                                              orgName,
                                              orgEmail,
                                              orgTypeId!,
                                              orgRegistrationNo,
                                              dateExtablished,
                                              address1,
                                              address2,
                                              address3,
                                              postcode,
                                              stateId,
                                              districtId,
                                              cityId,
                                              stateName,
                                              districtName,
                                              cityName,
                                              countryId!,
                                              phoneNo,
                                            );
                                            if (response.isSuccessful) {
                                              var homeRoute = MaterialPageRoute(
                                                  builder: (_) =>
                                                      HomeOrganizationScreen());

                                              setState(() {
                                                _isLoading = false;
                                              });

                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(homeRoute,
                                                      (route) => false);
                                              hideSnacks(context);
                                              snack(
                                                  context,
                                                  'Your organization information has been successfully updated.'
                                                      .tr,
                                                  level: SnackLevel.Success);

                                              return;
                                            }
                                            hideSnacks(context);
                                            setState(() {
                                              _isLoading = false;
                                            });
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
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
