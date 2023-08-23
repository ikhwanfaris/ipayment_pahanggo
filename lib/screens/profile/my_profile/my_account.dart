import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/models/users/email_history.dart';
import 'package:flutterbase/screens/profile/my_profile/passport_history.dart';
import 'package:flutterbase/states/user_state.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/models/users/city.dart';
import 'package:flutterbase/models/users/identity_type.dart';
import 'package:flutterbase/models/users/postcode_city.dart';
import 'package:flutterbase/models/users/postcode_state.dart';
import 'package:flutterbase/models/users/states.dart';
import 'package:flutterbase/models/users/country.dart';
import 'package:flutterbase/models/users/district.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:math' as math;

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class MyAccountScreen extends StatefulWidget {
  MyAccountScreen({Key? key}) : super(key: key);
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {

  var maskFormatterPostcode = new MaskTextInputFormatter(mask: "", type: MaskAutoCompletionType.lazy);
  var maskFormatterIdentityCodeText = new MaskTextInputFormatter(mask: "", type: MaskAutoCompletionType.lazy);
  var maskFormatterPostcodeForeigner = new MaskTextInputFormatter(mask: "", type: MaskAutoCompletionType.lazy);
  
  bool _isCivilServant = false;
  int hasExpiredDate = state.user.getIdentityType!.hasExpiredDate;
  bool _isMyKAS = false;
  bool _isMyPR = false;
  bool _isIcNo = false;
  bool _isMyTentera = false;
  // ignore: unused_field
  String _radioVal = '';
  TextEditingController dateExpiredInput = TextEditingController();
  TextEditingController dateinput = TextEditingController();
  TextEditingController phoneNo = TextEditingController();
  String firstName = state.user.firstName!;
  String lastName = state.user.lastName!;
  String reason = '';
  String email = state.user.email!;
  String officialEmail = state.user.officialEmail ?? '';
  String personalEmail = state.user.personalEmail ?? '';
  int citizenship = state.user.citizenship!;
  String address1 = state.user.address1!;
  String? address2 = state.user.address2;
  String? address3 = state.user.address3;
  int? countryID = state.user.countryId!;
  int? stateID = state.user.stateId;
  int? districtID = state.user.districtId;
  int? cityID = state.user.cityId;
  String postcode = state.user.postcode!;
  String identityNo = state.user.identityNo!;
  int? userIdentityTypeID = state.user.getIdentityType!.id;
  String? stateName = state.user.stateName;
  String? districtName = state.user.districtName;
  String? cityName = state.user.cityName;
  int? countryNationalityId = state.user.countryNationalityId;
  String? identityEndDate = state.user.passport?.passportEndDate ?? '';
  DateTime identityEndDateDisplay = DateTime.now();
  String dateDisplay = '';
  bool isChecked = false;
  bool _isLoading = false;
  bool _isReadOnly = false;
  bool _isDisable = true;
  bool _isFilled = true;
  bool _isCanUpdated = true;
  bool _isCanStored = false;
  bool _isVisibleBtnSubmit = false;
  bool _isVisibleEndDate = false;
  bool _isMalaysia = true;
  bool _isNotMalaysia = false;
  bool _isForeigner = false;
  final _formKey = GlobalKey<FormState>();
  List<String> _reasonOfChangeModel = ['Lost', 'Expired', 'Other'];
  List<Country> _countryModel = [];
  List<States> _statesModel = [];
  // ignore: unused_field
  List<District> _districtModel = [];
  List<City> _cityModel = [];
  // bool _isPostCodeEmpty = true;
  bool _isPostcodeMalaysia = true;
  bool _isPostcodeNotMalaysia = false;
  bool _isPassport = false;
  // ignore: unused_field
  List<IdentityType> _identityTypeCitizenModel = [];
  // ignore: unused_field
  List<IdentityType> _identityTypeNonCitezenModel = [];
  // Need to loop through district Id to get name
  var initialDistrictValue = 'Rembau'; // 506
  // ignore: unused_field
  List<String> _countryNameList = [];
  // ignore: unused_field
  List<String> _stateNameList = [];
  // ignore: unused_field
  List<String> _cityNameList = [];
  List<String> _districtNameList = [];

  List<EmailHistory> emailHistories = [];

  @override
  void dispose() {
    super.dispose();
  }

  // Fix postcode not valid error message
  String getPostcodeStatusLS = 'null';
  // bool _customPostcodeErrorMsg = false;
  // bool _isDisablePostcodeValid = true;
  @override
  void initState() {
    super.initState();
    print('Bukan Warganegara: ' + _isForeigner.toString());
    phoneNo.text = state.user.phoneNo!;
    if (state.user.passport != null) {
      identityEndDateDisplay = DateTime.tryParse(
          state.user.passport?.passportEndDate.toString() ?? '')!;
      dateDisplay = dateFormatterDisplay.format(identityEndDateDisplay);
      print('Date display: ' + dateDisplay);
      dateinput.text = dateDisplay.toString();
    }

    if (state.user.roles?.length != 0) {
      _isCivilServant = true;
    } else {
      _isCivilServant = false;
    }

    _getData();
    print(citizenship);
    onChangedPostcode(postcode);
    onChangedEmail(email);
    _getCharacterCount();
    print('Identity end date : ' + identityEndDate!);

    //Get email history
    getEmailHistory();

    // print(identityTypeID);
    // print(identityNo);
    // initialDistrictValue++;
    // print(initialDistrictValue);
    // Showing waht is from database
    if (citizenship == 1) {
      _isForeigner = false;
    } else {
      _isForeigner = true;
    }
    if (countryID == 458) {
      _isMalaysia = true;
      _isNotMalaysia = false;
      _isPostcodeMalaysia = true;
      _isPostcodeNotMalaysia = false;
    } else {
      _isMalaysia = false;
      _isNotMalaysia = true;
      _isPostcodeMalaysia = false;
      _isPostcodeNotMalaysia = true;
    }

    //todo: get identitytpe has expired date ?
    if (hasExpiredDate == 1) {
      _isVisibleEndDate = true;
    } else {
      _isVisibleEndDate = false;
    }

    if (userIdentityTypeID == 2) {
      // Passport
      // _isVisibleEndDate = true;
      _isPassport = true;
    } else if (userIdentityTypeID == 3) {
      //MyTentera
      _isMyTentera = true;
    } else if (userIdentityTypeID == 1) {
      //MyKAD
      _isIcNo = true;
    } else if (userIdentityTypeID == 5) {
      //MyPR
      _isMyPR = true;
      // _isVisibleEndDate = true;
    } else if (userIdentityTypeID == 4) {
      //MyKAS
      // _isVisibleEndDate = true;
      _isPassport = false;
      _isMyKAS = true;
    } else {
      //kad pengenalan , my tentetra, my pr
      // _isVisibleEndDate = false;
      _isPassport = false;
    }
  }

  // Out of iniState
  void getEmailHistory() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    emailHistories = await api.getEmailHistories();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  bool _isFormEmpty() {
    if (
        // todo:Validate national country id & country id
        email.isEmpty ||
            phoneNo.text.isEmpty ||
            firstName.isEmpty ||
            lastName.isEmpty ||
            address1.isEmpty ||
            postcode.isEmpty ||
            districtID == null) {
      return true;
    } else if (_isPassport) {
      if (isChecked) {
        print(isChecked.toString() + ': isChecked');
        print(identityEndDate.toString() + ': identityEndDate');

        if (identityNo.isEmpty ||
            reason.isEmpty ||
            dateExpiredInput.text.isEmpty) {
          return true;
        } else {
          return false;
        }
      } else {
        print(isChecked.toString() + ': isChecked');

        return false;
      }
    }

    return false;
  }

  // reason.isEmpty || identityNo.isEmpty || identityEndDate != null

  void _getData() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    print('Daerah ID : ' + districtID.toString());
    _countryModel = await api.getCountry();
    _statesModel = await api.getStates();
    _districtModel = await api.getDistrict(stateID);
    _cityModel = await api.getCity();
    _identityTypeCitizenModel = await api.getIndentityType();
    _identityTypeNonCitezenModel = await api.getIndentityTypeNonCitezen();
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  bool _isEmailValid = false;
  bool _isPostCodeValid = true;
  // RegexExp
  final emailRE = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final phoneRE = RegExp(r"^[+.]?\d+\b$|^[+.]$");
  final nameRE = RegExp(r"^(?=.{3})[a-zA-Z0-9_\-=@/',\.;\s]+$");
  final postcodeRE = RegExp(r"^\b\d{5}\b$");
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

  List<PostcodeCity> _postcodeCityModel = [];
  List<PostcodeState> _postcodeStateModel = [];
  // Group postcode api
  void _getDataPostcodeCityState() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _getDataPostcodeState();
    _getDataPostcodeCity();
    _getDataStateCity();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  void _getDataDistrict() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _districtModel = await api.getDistrict(stateID!);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _districtModel.map((item) {
            _districtNameList.add(item.name!);
          }).toList();
          Navigator.pop(context);
        }));
  }

  // State
  void _getDataStateCity() async {
    // _stateModel = await api.getStates();
    _cityModel = await api.getCity();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          // _postcodeStateModel.map((item) {
          //   stateID = item.id;
          // }).toList();
          _postcodeCityModel.map((item) {
            cityID = item.id;
          }).toList();
        }));
  }

  void _getDataPostcodeState() async {
    _postcodeStateModel = await api.getPostcodeState(postcode);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _postcodeStateModel.map((item) {
            stateID = item.id;
            _getDataDistrict();
          }).toList();
        }));
  }

  void _getDataPostcodeCity() async {
    _postcodeCityModel = await api.getPostcodeCity(postcode);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          getPostcodeStatusLS = store.getItem('postcodeValidLS');
          if (getPostcodeStatusLS == 'data') {
            _isPostCodeValid = true;
            print('Postcode is Valid');
          } else if (getPostcodeStatusLS == 'empty') {
            _isPostCodeValid = false;
            print('Postcode is not Valid');
          }
          _postcodeCityModel.map((item) {
            cityID = item.id;
          }).toList();
        }));
  }

  int characterCount = 20;
  String identityTypeLabel = '';
  // onChange validation character count
  void _getCharacterCount() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    await api.getCharacterCount(userIdentityTypeID!);
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          characterCount = store.getItem('characterCountLS');
          identityTypeLabel = store.getItem('typeLS');
          Navigator.pop(context);
        }));
  }

  bool _isShowIdentityNo = true;
  @override
  Widget build(BuildContext context) {
    
    //Make it display only one item if there is duplicate
    Set<String> uniqueEmails = Set();

    for (var emailHistory in emailHistories) {
      for (var email in emailHistory.emailList) {
        uniqueEmails.add(email);
      }
    }

    List<String> uniqueEmailList = uniqueEmails.toList();

    maskFormatterPostcode.updateMask(mask: generateMask(5), filter: { "#": RegExp(r'^\d{0,5}$') });
    maskFormatterIdentityCodeText.updateMask(mask: generateMask(characterCount), filter: { "#": RegExp(r'^[a-zA-Z0-9\s]{0,20}$') });
    maskFormatterPostcodeForeigner.updateMask(mask: generateMask(10), filter: { "#": RegExp(r'^[a-zA-Z0-9\s]{0,10}$') });
    
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              'Update Profile'.tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: state.value.userState,
          builder: (BuildContext context, UserDataState value, Widget? child) {
            return Container(
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Divider(
                                    color: constants.primaryColor,
                                    thickness: 5,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 16),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _isCanUpdated
                                            ? Constants().sixColor
                                            : Colors.redAccent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
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
                                          _isVisibleBtnSubmit =
                                              !_isVisibleBtnSubmit;
                                          isChecked = false;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Visibility(
                            visible: _isCivilServant,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Column(
                                children: [
                                  TextFormField(
                                    autofocus: true,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    enabled: false,
                                    decoration: styles.inputDecoration.copyWith(
                                        label: getRequiredLabel(
                                            'Official Email'.tr),
                                        filled: true),
                                    initialValue: officialEmail,
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    autofocus: true,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    enabled: _isReadOnly,
                                    decoration: styles.inputDecoration.copyWith(
                                        label: getRequiredLabel(
                                            'Personal Email'.tr),
                                        filled: _isFilled,
                                        suffixIcon: _isDisable
                                            ? null
                                            : _isEmailValid
                                                ? IconTheme(
                                                    data: IconThemeData(
                                                        color: Colors.green),
                                                    child: Icon(
                                                      LineIcons.checkCircle,
                                                    ))
                                                : IconTheme(
                                                    data: IconThemeData(
                                                        color: Colors.red),
                                                    child: Icon(
                                                      LineIcons.timesCircle,
                                                    ))),
                                    initialValue: personalEmail,
                                    onChanged: (val) {
                                      onChangedEmail(personalEmail);
                                      personalEmail = personalEmail;
                                      setState(() {
                                        personalEmail = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: !_isCivilServant,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: TextFormField(
                                autofocus: true,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                enabled: _isReadOnly,
                                decoration: styles.inputDecoration.copyWith(
                                    label: getRequiredLabel('Email'.tr),
                                    filled: _isFilled,
                                    suffixIcon: _isDisable
                                        ? null
                                        : _isEmailValid
                                            ? IconTheme(
                                                data: IconThemeData(
                                                    color: Colors.green),
                                                child: Icon(
                                                  LineIcons.checkCircle,
                                                ))
                                            : IconTheme(
                                                data: IconThemeData(
                                                    color: Colors.red),
                                                child: Icon(
                                                  LineIcons.timesCircle,
                                                ))),
                                initialValue: email,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be left blank.'
                                        .tr;
                                  } else if (!emailRE.hasMatch(value)) {
                                    return 'Your email is invalid.'.tr;
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  onChangedEmail(email);
                                  email = email;
                                  setState(() {
                                    email = val;
                                  });
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: uniqueEmailList.isEmpty ? false : true,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('E-mail History'.tr,
                                      style: styles.heading13bold),
                                  SizedBox(
                                      height: uniqueEmailList.length * 20,
                                      child: ListView.builder(
                                        itemCount: uniqueEmailList.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                               Transform.rotate(
                                                angle: math.pi / 2,
                                                child: Icon(
                                                    getIcon('hand-pointing'), size: 15,),
                                              ),
                                              SizedBox(width: 10),
                                              Text(uniqueEmailList[index]),
                                            ],
                                          );
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: uniqueEmailList.isEmpty ? 20 : 0),
                          TextFormField(
                            enabled: _isReadOnly,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r"^[+.]?\d+\b$|^[+.]$")),
                            ],
                            decoration: styles.inputDecoration.copyWith(
                                label: getRequiredLabel('Phone Number'.tr),
                                filled: _isFilled),
                            controller: phoneNo,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be left blank.'.tr;
                              } else if (!phoneRE.hasMatch(value) ||
                                  value.length < 2) {
                                return 'Your phone number is invalid'.tr;
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                val = phoneNo.text;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            enabled: _isReadOnly,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: styles.inputDecoration.copyWith(
                                label: getRequiredLabel('First Name'.tr),
                                filled: _isFilled),
                            initialValue: firstName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be left blank.'.tr;
                              }
                              if (!nameRE.hasMatch(value)) {
                                return 'Your first name is invalid'.tr;
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                firstName = val;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            enabled: _isReadOnly,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            decoration: styles.inputDecoration.copyWith(
                                label: getRequiredLabel('Last Name'.tr),
                                filled: _isFilled),
                            initialValue: lastName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'This field cannot be left blank.'.tr;
                              }
                              if (!nameRE.hasMatch(value)) {
                                return 'Your last name is invalid'.tr;
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                lastName = val;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IgnorePointer(
                                ignoring: true,
                                child: Radio(
                                  value: 1,
                                  groupValue: citizenship,
                                  activeColor: Colors.grey,
                                  onChanged: (value) {
                                    setState(() {
                                      citizenship = value as int;
                                      _radioVal = 'Citizen'.tr;
                                      _isMalaysia = true;
                                      _isNotMalaysia = false;
                                      _isPostcodeMalaysia = true;
                                      _isPostcodeNotMalaysia = false;
                                      _isForeigner = false;
                                      userIdentityTypeID = null;
                                      countryID = null;
                                      _isShowIdentityNo = false;
                                    });
                                  },
                                ),
                              ),
                              Text('Citizen'.tr, style: styles.heading18),
                              IgnorePointer(
                                ignoring: true,
                                child: Radio(
                                  value: 0,
                                  groupValue: citizenship,
                                  activeColor: Colors.grey,
                                  onChanged: (value) {
                                    setState(() {
                                      citizenship = value as int;
                                      _radioVal = 'Non Citizen'.tr;
                                      _isMalaysia = false;
                                      _isNotMalaysia = true;
                                      _isPostcodeMalaysia = false;
                                      _isPostcodeNotMalaysia = true;
                                      countryID = null;
                                      postcode = '';
                                      _isForeigner = true;
                                      userIdentityTypeID = null;
                                      _isShowIdentityNo = false;
                                    });
                                  },
                                ),
                              ),
                              Text('Non Citizen'.tr, style: styles.heading18),
                            ],
                          ),
                          Visibility(
                            visible: _isForeigner,
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                IgnorePointer(
                                  ignoring: _isDisable,
                                  child: DropdownButtonFormField(
                                    icon: Visibility(
                                        visible: false,
                                        child:
                                            Icon(LineIcons.chevronCircleDown)),
                                    isExpanded: true,
                                    decoration: styles.inputDecoration.copyWith(
                                        suffixIcon: _isDisable
                                            ? null
                                            : Icon(LineIcons.chevronCircleDown),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: _isDisable
                                              ? BorderSide(
                                                  color:
                                                      constants.secondaryColor)
                                              : BorderSide(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        label:
                                            getRequiredLabel('Citizenship'.tr),
                                        filled: _isFilled),
                                    hint: Text('Please Select'.tr),
                                    items: _countryModel.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item.name!,
                                            style: _isDisable
                                                ? TextStyle(color: Colors.grey)
                                                : null),
                                        value: item.id,
                                      );
                                    }).toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'This field cannot be left blank.'
                                            .tr;
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        countryNationalityId = val as int?;
                                        print(val);
                                      });
                                    },
                                    value: countryNationalityId,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          IgnorePointer(
                            ignoring: true,
                            child: DropdownButtonFormField(
                              icon: _isDisable
                                  ? Visibility(
                                      visible: false,
                                      child: Icon(LineIcons.chevronCircleDown))
                                  : _isNotMalaysia
                                      ? null
                                      : Visibility(
                                          visible: false,
                                          child: Icon(
                                              LineIcons.chevronCircleDown)),
                              value: userIdentityTypeID,
                              isExpanded: true,
                              decoration: styles.inputDecoration.copyWith(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: constants.secondaryColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  label:
                                      getRequiredLabel('User Identity Type'.tr),
                                  filled: true),
                              hint: Text('Please Select'.tr),
                              items: !_isForeigner
                                  ? _identityTypeCitizenModel.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item.type!,
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        value: item.id,
                                      );
                                    }).toList()
                                  : _identityTypeNonCitezenModel.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item.type!,
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        value: item.id,
                                      );
                                    }).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'This field cannot be left blank.'.tr;
                                }
                                return null;
                              },
                              onChanged: (val) {
                                setState(() {
                                  print(val);
                                  userIdentityTypeID = val as int;
                                  _getCharacterCount();
                                  _isShowIdentityNo = true;
                                  if (userIdentityTypeID == 2) {
                                    // Passport
                                    // _isVisibleEndDate = true;
                                    _isPassport = true;
                                    isChecked = false;
                                    _isMyPR = false;
                                    _isIcNo = false;
                                    _isMyKAS = false;
                                    _isMyTentera = false;
                                  } else if (userIdentityTypeID == 4) {
                                    //MyKAS
                                    // _isVisibleEndDate = true;
                                    _isPassport = false;
                                    isChecked = false;
                                    _isMyPR = false;
                                    _isIcNo = false;
                                    _isMyKAS = true;
                                    _isMyTentera = true;
                                  } else if (userIdentityTypeID == 5) {
                                    //MyPR
                                    // _isVisibleEndDate = true;
                                    _isPassport = false;
                                    isChecked = false;
                                    _isMyPR = true;
                                    _isIcNo = false;
                                    _isMyKAS = false;
                                    _isMyTentera = false;
                                  } else if (userIdentityTypeID == 1) {
                                    // _isVisibleEndDate = false;
                                    _isPassport = false;
                                    isChecked = false;
                                    _isMyPR = false;
                                    _isMyKAS = false;
                                    _isIcNo = true;
                                    _isMyTentera = false;
                                  } else if (userIdentityTypeID == 3) {
                                    // _isVisibleEndDate = false;
                                    _isPassport = false;
                                    isChecked = false;
                                    _isMyPR = false;
                                    _isMyKAS = false;
                                    _isMyTentera = true;
                                  } else {
                                    //kad pengenalan , my tentetra, my pr
                                    // _isVisibleEndDate = false;
                                    _isPassport = false;
                                    isChecked = false;
                                    _isMyPR = false;
                                    _isIcNo = false;
                                    _isMyKAS = false;
                                    _isMyTentera = false;
                                  }
                                });
                              },
                            ),
                          ),
                          // todo: add checkbox and mata > inline
                          SizedBox(height: _isPassport ? 0 : 20),
                          Visibility(
                            visible: _isPassport,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                        checkColor: Colors.white,
                                        value: isChecked,
                                        onChanged: _isReadOnly
                                            ? (
                                                bool? value,
                                              ) {
                                                setState(() {
                                                  isChecked = value!;
                                                  dateExpiredInput.clear();
                                                });
                                              }
                                            : null),
                                    Text('Add new passport'.tr,
                                        style: _isReadOnly
                                            ? null
                                            : styles.heading14),
                                  ],
                                ),
                                Visibility(
                                  visible: _isPassport,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: InkWell(
                                        onTap: () {
                                          navigate(
                                              context, PassportHistoryScreen());
                                        },
                                        child: Icon(Icons.visibility)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // todo: Add new form field for passport
                          Visibility(
                            visible: isChecked,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: DropdownButtonFormField(
                                    icon: Visibility(
                                        visible: false,
                                        child:
                                            Icon(LineIcons.chevronCircleDown)),
                                    isExpanded: true,
                                    decoration: styles.inputDecoration.copyWith(
                                      suffixIcon: _isDisable
                                          ? null
                                          : Icon(LineIcons.chevronCircleDown),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      label: getRequiredLabel(
                                          'Reason of Change'.tr),
                                    ),
                                    hint: Text('Please Select'.tr),
                                    items: _reasonOfChangeModel.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item.tr),
                                        value: item,
                                      );
                                    }).toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'This field cannot be left blank.'
                                            .tr;
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        reason = val as String;
                                        print(val);
                                      });
                                    },
                                    // value: reason
                                  ),
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  // maxLength: characterCount,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: _isPassport
                                      ? TextInputType.text
                                      : TextInputType.number,
                                  inputFormatters: _isPassport
                                      ? [maskFormatterIdentityCodeText]
                                      : [
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                  decoration: styles.inputDecoration.copyWith(
                                    label: getRequiredLabel(
                                        'Number '.tr + identityTypeLabel),
                                        hintText: generateHintText(characterCount),
                                  ),
                                  // initialValue: identityNo,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field cannot be left blank.'
                                          .tr;
                                    } else if (value.length != characterCount) {
                                      return 'The registration number must be '
                                              .tr +
                                          characterCount.toString() +
                                          ' character'.tr;
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      identityNo = val;
                                    });
                                  },
                                ),
                                SizedBox(height: 20),
                                TextFormField(
                                  controller: dateExpiredInput,
                                  // initialValue: dateDisplay.toString(),
                                  decoration: styles.inputDecoration.copyWith(
                                      suffix: Icon(LineIcons.calendarAlt),
                                      label: getRequiredLabel('Expiry Date'.tr +
                                          ' ' +
                                          identityTypeLabel),
                                      filled: _isFilled),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        locale: Get.locale?.languageCode == 'en'
                                            ? Locale("en")
                                            : Locale("ms"),
                                        fieldHintText: 'DD/MM/YYYY',
                                        fieldLabelText: 'Enter Date'.tr,
                                        helpText: 'Select Date'.tr,
                                        cancelText: 'Cancel'.tr,
                                        confirmText: 'Yes'.tr,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101));
                                    if (pickedDate != null) {
                                      String formattedDate =
                                          dateFormatter.format(pickedDate);
                                      String formattedDateDisplay =
                                          dateFormatterDisplay
                                              .format(pickedDate);
                                      setState(() {
                                        dateExpiredInput.text =
                                            formattedDateDisplay;
                                        identityEndDate = formattedDate;
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                                SizedBox(height: 15),
                              ],
                            ),
                          ),
                          // todo-closed: Add new form field for passport
                          // Todo passport & kad pengenalan
                          SizedBox(height: 5),
                          Visibility(
                            visible: _isShowIdentityNo,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom:20),
                              child: TextFormField(
                                enabled: _isPassport ||
                                        _isMyPR ||
                                        _isIcNo ||
                                        _isMyTentera ||
                                        _isMyKAS
                                    ? false
                                    : _isReadOnly,
                                // maxLength: _isPassport ? null : characterCount,
                                textInputAction: TextInputAction.next,
                                keyboardType: _isPassport
                                    ? TextInputType.text
                                    : TextInputType.number,
                                inputFormatters: _isPassport
                                    ? null
                                    : [FilteringTextInputFormatter.digitsOnly],
                                decoration: styles.inputDecoration.copyWith(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: _isDisable
                                          ? BorderSide(
                                              color: constants.secondaryColor)
                                          : BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    label: getRequiredLabel(
                                        'Number '.tr + identityTypeLabel),
                                    filled: _isFilled
                                        ? true
                                        : _isNotMalaysia
                                            ? false
                                            : true),
                                initialValue: identityNo,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be left blank.'.tr;
                                  } else if (_isPassport == false &&
                                      value.length != characterCount) {
                                    return 'The registration number must be '.tr +
                                        characterCount.toString() +
                                        ' character'.tr;
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    identityNo = val;
                                  });
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _isVisibleEndDate,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom:20),
                                  child: TextFormField(
                                    enabled: _isPassport || _isMyPR
                                        ? false
                                        : _isReadOnly,
                                    controller: dateinput,
                                    decoration: styles.inputDecoration.copyWith(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: _isDisable
                                              ? BorderSide(
                                                  color: constants.secondaryColor)
                                              : BorderSide(color: Colors.grey),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        suffix: _isDisable
                                            ? Visibility(
                                                visible: false,
                                                child:
                                                    Icon(LineIcons.calendarAlt))
                                            : _isNotMalaysia
                                                ? null
                                                : Visibility(
                                                    visible: false,
                                                    child: Icon(
                                                        LineIcons.calendarAlt)),
                                        label: getRequiredLabel('Expiry Date'.tr +
                                            ' ' +
                                            identityTypeLabel),
                                        filled: _isFilled
                                            ? true
                                            : _isPassport || _isMyPR
                                                ? true
                                                : false),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          locale: Get.locale?.languageCode == 'en'
                                              ? Locale("en")
                                              : Locale("ms"),
                                          fieldHintText: 'DD/MM/YYYY',
                                          fieldLabelText: 'Enter Date'.tr,
                                          helpText: 'Select Date'.tr,
                                          cancelText: 'Cancel'.tr,
                                          confirmText: 'Yes'.tr,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2000),
                                          lastDate: DateTime(2101));
                                
                                      if (pickedDate != null) {
                                        // print(pickedDate);
                                        String formattedDate =
                                            dateFormatter.format(pickedDate);
                                        String formattedDateDisplay =
                                            dateFormatterDisplay
                                                .format(pickedDate);
                                        // print(formattedDate);
                                        setState(() {
                                          dateinput.text = formattedDateDisplay;
                                          identityEndDate = formattedDate;
                                          // toIso8601String(),
                                          print(formattedDate);
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.streetAddress,
                            textInputAction: TextInputAction.next,
                            enabled: _isReadOnly,
                            decoration: styles.inputDecoration.copyWith(
                                label: getRequiredLabel('Address 1'.tr),
                                filled: _isFilled),
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
                                labelText: 'Address 2'.tr, filled: _isFilled),
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
                                labelText: 'Address 3'.tr, filled: _isFilled),
                            initialValue: address3,
                            onChanged: (val) {
                              setState(() {
                                address3 = val;
                              });
                            },
                          ),
                          SizedBox(height: 20),
                          IgnorePointer(
                            ignoring: _isDisable,
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
                                      : Icon(LineIcons.chevronCircleDown),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: _isDisable
                                        ? BorderSide(
                                            color: constants.secondaryColor)
                                        : BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  label: getRequiredLabel('Country'.tr),
                                  filled: _isFilled,
                                ),
                                items: _countryModel.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item.name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: _isDisable
                                            ? TextStyle(color: Colors.grey)
                                            : null),
                                    value: item.id,
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field cannot be left blank.'
                                        .tr;
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    countryID = val as int?;
                                    print(countryID);
                                    if (countryID == 458) {
                                      print('Warganegara & Malaysia');
                                      _isMalaysia = true;
                                      _isNotMalaysia = false;
                                      _isPostcodeMalaysia = true;
                                      _isPostcodeNotMalaysia = false;
                                    } else {
                                      print('Warganegara & Bukan Malaysia');
                                      _isMalaysia = false;
                                      _isNotMalaysia = true;
                                      _isPostcodeMalaysia = false;
                                      _isPostcodeNotMalaysia = true;
                                    }
                                  });
                                },
                                value: countryID,
                              ),
                            ),
                          ),
                          // Postcode is malaysia
                          Visibility(
                            visible: _isPostcodeMalaysia,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom:20),
                              child: TextFormField(
                                enabled: _isReadOnly,
                                // maxLength: 5,
                                textAlign: TextAlign.start,
                                initialValue: postcode,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
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
                                                data: IconThemeData(
                                                    color: Colors.green),
                                                child: Icon(
                                                  LineIcons.checkCircle,
                                                ))
                                            : IconTheme(
                                                data: IconThemeData(
                                                    color: Colors.red),
                                                child: Icon(
                                                  LineIcons.timesCircle,
                                                ))),
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
                                    // print(postcode);
                                    // initialDistrictValue++;
                                    postcode = val;
                                    onChangedPostcode(postcode.toString());
                                    postcode = postcode;
                                    if (postcode.length >= 5) {
                                      _getDataPostcodeCityState();
                                    } else {
                                      stateID = null;
                                      cityID = null;
                                      districtID = null;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          // Postcode not malaysia
                          Visibility(
                            visible: _isPostcodeNotMalaysia,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                inputFormatters: [maskFormatterPostcodeForeigner],
                                enabled: _isReadOnly,
                                initialValue: postcode,
                                decoration: styles.inputDecoration.copyWith(
                                    hintText: generateHintText(10),
                                    label: getRequiredLabel('Postcode'.tr),
                                    filled: _isFilled),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be left blank.'
                                        .tr;
                                  } else if (value.length < 4) {
                                    return 'The poscode you entered is invalid.'
                                        .tr;
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    print(postcode);
                                    postcode = val;
                                  });
                                },
                              ),
                            ),
                          ),
                          // SizedBox(height: 7),
                          // Negeri
                          Visibility(
                            visible: _isMalaysia,
                            child: IgnorePointer(
                              ignoring: true,
                              child: DropdownButtonFormField(
                                icon: Visibility(
                                    visible: false,
                                    child: Icon(LineIcons.chevronCircleDown)),
                                isExpanded: true,
                                decoration: styles.inputDecoration.copyWith(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: constants.secondaryColor),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    label: getRequiredLabel('State'.tr),
                                    filled: true),
                                hint: Text('Please Select'.tr,
                                    overflow: TextOverflow.ellipsis),
                                items: _statesModel.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item.name!,
                                        style: TextStyle(color: Colors.grey)),
                                    value: item.id,
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field cannot be left blank.'
                                        .tr;
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    stateID = val as int;
                                    districtID = null;
                                    _getDataDistrict();
                                  });
                                },
                                value: stateID,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _isNotMalaysia,
                            child: TextFormField(
                              enabled: _isReadOnly,
                              decoration: styles.inputDecoration.copyWith(
                                  label: getRequiredLabel('State'.tr),
                                  filled: _isFilled),
                              initialValue: stateName,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field cannot be left blank.'.tr;
                                }
                                return null;
                              },
                              onChanged: (val) {
                                setState(() {
                                  stateName = val;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Visibility(
                            visible: _isMalaysia,
                            child: IgnorePointer(
                              ignoring: _isDisable
                                  ? true
                                  : _isPostCodeValid
                                      ? false
                                      : true,
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
                                        ? BorderSide(
                                            color: constants.secondaryColor)
                                        : _isPostCodeValid
                                            ? BorderSide(
                                                color: Colors.grey)
                                            : 
                                        BorderSide(color: constants.secondaryColor),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  label: getRequiredLabel('District'.tr),
                                  filled: _isDisable
                                      ? true
                                      : _isPostCodeValid
                                          ? false
                                          : true,
                                ),
                                hint: Text('Please Select'.tr),
                                items: _districtModel.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item.name!,
                                        overflow: TextOverflow.ellipsis,
                                        style: _isDisable
                                            ? TextStyle(color: Colors.grey)
                                            : null),
                                    value: item.id,
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field cannot be left blank.'
                                        .tr;
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    print(districtID);
                                    districtID = val as int;
                                  });
                                },
                                value: districtID,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _isMalaysia,
                            child: IgnorePointer(
                              ignoring: true,
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  DropdownButtonFormField(
                                    icon: Visibility(
                                        visible: false,
                                        child:
                                            Icon(LineIcons.chevronCircleDown)),
                                    isExpanded: true,
                                    decoration: styles.inputDecoration.copyWith(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: constants.secondaryColor),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      label: getRequiredLabel('City'.tr),
                                      filled: true,
                                    ),
                                    hint: Text('Please Select'.tr),
                                    items: _cityModel.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item.name!,
                                            style:
                                                TextStyle(color: Colors.grey)),
                                        value: item.id,
                                      );
                                    }).toList(),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'This field cannot be left blank.'
                                            .tr;
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {
                                        cityID = val as int;
                                      });
                                    },
                                    value: cityID,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _isNotMalaysia,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                enabled: _isReadOnly,
                                decoration: styles.inputDecoration.copyWith(
                                    label: getRequiredLabel('District'.tr),
                                    filled: _isFilled),
                                initialValue: districtName,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field cannot be left blank.'
                                        .tr;
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    districtName = val;
                                  });
                                },
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _isNotMalaysia,
                            child: Column(
                              children: [
                                TextFormField(
                                  enabled: _isReadOnly,
                                  decoration: styles.inputDecoration.copyWith(
                                      label: getRequiredLabel('City'.tr),
                                      filled: _isFilled),
                                  initialValue: cityName,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'This field cannot be left blank.'
                                          .tr;
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      cityName = val;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: _isVisibleBtnSubmit,
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                _isLoading
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        child: DefaultLoadingBar(),
                                      )
                                    : PrimaryButton(
                                        isLoading: _isLoading,
                                        text: 'Update'.tr,
                                        onPressed: _isFormEmpty()
                                            ? null
                                            : () async {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  // print('First Name: ' +
                                                  //     firstName +
                                                  //     '\n LastName: ' +
                                                  //     lastName +
                                                  //     '\n Email: ' +
                                                  //     email +
                                                  //     '\n Phone: ' +
                                                  //     phoneNo.text +
                                                  //     '\n Citizenship: ' +
                                                  //     citizenship.toString() +
                                                  //     '\n Address 1: ' +
                                                  //     address1 +
                                                  //     '\n Address 2: ' +
                                                  //     address2.toString() +
                                                  //     '\n Address 3: ' +
                                                  //     address3.toString() +
                                                  //     '\n State Id: ' +
                                                  //     stateID.toString() +
                                                  //     '\n Daerah Id: ' +
                                                  //     districtID.toString() +
                                                  //     '\n Bandar Id: ' +
                                                  //     cityID.toString() +
                                                  //     '\n Poskod: ' +
                                                  //     postcode +
                                                  //     '\n Kewarganegaraan: ' +
                                                  //     countryNationalityId
                                                  //         .toString() +
                                                  //     '\n Country Id: ' +
                                                  //     countryID.toString() +
                                                  //     '\n State Name: ' +
                                                  //     stateName.toString() +
                                                  //     '\n Daerah Name:' +
                                                  //     districtName.toString() +
                                                  //     '\n City Name: ' +
                                                  //     cityName.toString() +
                                                  //     '\n Jenis ID: ' +
                                                  //     userIdentityTypeID.toString() +
                                                  //     '\n Nombor ID pengguna: ' +
                                                  //     identityNo +
                                                  //     '\n Tarikh tamat: ' +
                                                  //     identityEndDate.toString());
                                                  try {
                                                    var response =
                                                        await api.updateProfile(
                                                            firstName,
                                                            lastName,
                                                            email,
                                                            personalEmail,
                                                            phoneNo.text,
                                                            citizenship,
                                                            address1,
                                                            address2,
                                                            address3,
                                                            stateID,
                                                            districtID,
                                                            cityID,
                                                            postcode,
                                                            countryNationalityId,
                                                            countryID,
                                                            stateName,
                                                            districtName,
                                                            cityName,
                                                            userIdentityTypeID,
                                                            identityNo,
                                                            identityEndDate,
                                                            reason);
                                                    if (response.isSuccessful) {
                                                      print('response success');
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                      getEmailHistory();
                                                      snack(
                                                          context,
                                                          'Your profile has been updated.'
                                                              .tr,
                                                          level: SnackLevel
                                                              .Success);
                                                      
                                                      return;
                                                    }
                                                    hideSnacks(context);
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                    Get.snackbar(
                                                      snackPosition:
                                                          SnackPosition.TOP,
                                                      "".tr,
                                                      response.message,
                                                      messageText: Text(
                                                        response.message,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          bottom: 30, left: 16),
                                                      backgroundColor:
                                                          Colors.red,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
