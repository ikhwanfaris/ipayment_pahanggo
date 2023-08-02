import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/models/users/auth_config.dart';
import 'package:flutterbase/models/users/city.dart';
import 'package:flutterbase/models/users/states.dart';
import 'package:flutterbase/screens/content/home/tnc.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/models/users/identity_type.dart';
import 'package:flutterbase/models/users/postcode_city.dart';
import 'package:flutterbase/models/users/postcode_state.dart';
import 'package:flutterbase/models/users/country.dart';
import 'package:flutterbase/models/users/district.dart';
import 'package:flutterbase/screens/auth/verify.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:slider_captcha/slider_captcha.dart';
import 'package:flutterbase/screens/maintenance/maintenance.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  // var maskFormatterCitizen = new MaskTextInputFormatter(
  //     mask: "#####-##-####", type: MaskAutoCompletionType.lazy);

  TextEditingController dateinput = TextEditingController();
  TextEditingController phoneNo = TextEditingController();

  TextEditingController controller = TextEditingController();

  bool _isShowIdentityNo = false;

  bool _isRecaptcha = false;
  bool isCheckedRobot = false;

  // ignore: unused_field
  String _radioVal = '';

  String email = '';
  bool isBanned = true;
  String firstName = '';
  String lastName = '';
  int citizenship = 1; // 1 = Warganegara
  int? countryID = 458;
  int? stateID;
  String address1 = '';
  String address2 = '';
  String address3 = '';
  String postcode = '';
  int? districtID;
  int? cityID;
  bool isCheckedTnc = false;
  String password = '';
  String passwordConfirmation = '';
  int? identityTypeID; // Kad pegenalan
  String identityNo = '';
  String identityEndDate = '';
  String stateName = '';
  String districtName = '';
  String cityName = '';
  int? countryNationalityId;

  bool _isLoading = false;
  bool _isVisiblePass = false;

  List<District> _districtModel = [];
  List<PostcodeCity> _postcodeCityModel = [];
  List<PostcodeState> _postcodeStateModel = [];

  List<States> _stateModel = [];
  List<City> _cityModel = [];

  bool _isEmailValid = false;
  bool _isPostCodeValid = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;

  List<IdentityType> _identityTypeCitizenModel = [];
  List<IdentityType> _identityTypeNonCitizenModel = [];
  List<Country> _countryModel = [];

  // ignore: unused_field
  bool _isMalaysia = true;
  bool _isNotMalaysia = false;
  bool _isVisibleEndDate = false;
  // bool _isCountryIdMalaysia = false;
  bool _isPostcodeMalaysia = true;
  bool _isPassport = false;

  bool _isForeigner = false;

  // Update bkp test
  // bool _isPostCodeAuto = false;
  bool _isPostCodeNormal = true;
  int characterCount = 20;
  bool _isFetching = false;
  String identityTypeLabel = 'Kad Pengenalan';

  var initialCountryValue = 'Malaysia';
  var initialDistrictValue = 0;

  // RegexExp
  final emailRE = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final phoneRE = RegExp(r"^[+.]?\d+\b$|^[+.]$");
  final nameRE = RegExp(r"^(?=.{3})[a-zA-Z0-9_\-=@/',\.;\s]+$");
  final postcodeRE = RegExp(r"^\b\d{5}\b$");

  // final passwordRE = RegExp(
  //     r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!#^,()%*?&.\/])[A-Za-z\d@$!#^(),%*?&.\/]{8,20}$");

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

  // Password
  onChangedPassword(String passwordPattern) {
    setState(
      () {
        _isPasswordValid = false;

        print(passwordRE.toString());

        if (passwordRE.hasMatch(passwordPattern)) _isPasswordValid = true;
      },
    );
  }

  // Confirm Password
  onChangedConfirmPassword(String confirmPasswordPattern) {
    setState(
      () {
        _isConfirmPasswordValid = false;
        if (password.isEmpty)
          _isConfirmPasswordValid = false;
        else if (password == confirmPasswordPattern)
          _isConfirmPasswordValid = true;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getData();

    // var test = 2;
    // var uppercasePattern = 'A-Z';

    // passwordRE = RegExp(r'^\w{' + test.toString() + ',' + r'}$');
    // passwordRE = RegExp(r"^.{2,}$");

    // passwordRE = RegExp(r"(?=.*[$uppercasePattern])\w+");
    // passwordRE = RegExp(r"(?=.*[A-Z])\w+");

    // passwordRE = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+"); // minimum 1 uppercase and 1 lowercase

    // final passwordRE = RegExp(
    //     r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!#^,()%*?&.\/])[A-Za-z\d@$!#^(),%*?&.\/]{8,20}$");

    // passwordRE = new RegExp("^\\w.{$passwordMinimumLength,}\$");

    // print(initialDistrictValue);
    _getAuthConfig();
    // api.getCity(postcodeId!);
    // if (mounted) {
    //   setState(() {
    //     _getData();
    //   });
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Fix postcode not valid error message
  int citizenMaxLength = 0;
  int foreignerMaxLength = 0;

  // Fix postcode not valid error message
  String getPostcodeStatusLS = 'null';
  // bool _customPostcodeErrorMsg = false;

  List<String> _countryNameList = [];
  List<String> _stateNameList = [];
  List<String> _cityNameList = [];
  List<String> _districtNameList = [];

  List<String> _identityTypeCitizenModelTypeList = [];
  List<String> _identityTypeNonCitizenModelTypeList = [];

  void _getData() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));

    _countryModel = await api.getCountry();
    _identityTypeCitizenModel = await api.getIndentityType();
    _identityTypeNonCitizenModel = await api.getIndentityTypeNonCitezen();

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          // Add country name to list and check when user write value not exits
          _countryModel.map((item) {
            _countryNameList.add(item.name!);
          }).toList();

          _identityTypeCitizenModel.map((item) {
            _identityTypeCitizenModelTypeList.add(item.type!);
          }).toList();

          _identityTypeNonCitizenModel.map((item) {
            _identityTypeNonCitizenModelTypeList.add(item.type!);
          }).toList();

          Navigator.pop(context);
        }));
  }

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

//  No dependent with any postcode & normal
  void _getDataDistrict() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _districtModel.clear();
    _districtModel = await api.getDistrict(stateID!);
    _districtNameList.clear();
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          _districtModel.map((item) {
            _districtNameList.add(item.name!);
          }).toList();

          Navigator.pop(context);
        }));
  }

  // Postcode state
  void _getDataPostcodeState() async {
    _postcodeStateModel = await api.getPostcodeState(postcode);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _postcodeStateModel.map((item) {
            stateID = item.id;
            _getDataDistrict();
          }).toList();
        }));
  }

  // City & State > If postcode not valid
  void _getDataStateCity() async {
    _stateModel = await api.getStates();
    _cityModel = await api.getCity();
    _cityNameList.clear();
    _stateNameList.clear();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _stateModel.map((item) {
            _stateNameList.add(item.name!);
          }).toList();

          _cityModel.map((item) {
            _cityNameList.add(item.name!);
          }).toList();

          _postcodeStateModel.map((item) {
            stateID = item.id;
          }).toList();

          _postcodeCityModel.map((item) {
            cityID = item.id;
          }).toList();
        }));
  }

  void _getDataPostcodeCity() async {
    _postcodeCityModel = await api.getPostcodeCity(postcode);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          getPostcodeStatusLS = store.getItem('postcodeValidLS');

          if (getPostcodeStatusLS == 'data') {
            _isPostCodeValid = true;
            // _isDisablePostcodeValid = true;
            // _isPostCodeAuto = false;
            _isPostCodeNormal = true;
            // _customPostcodeErrorMsg = false;
            print('Postcode is Valid');
          } else if (getPostcodeStatusLS == 'empty') {
            _isPostCodeValid = false;
            // _isDisablePostcodeValid = false;
            // _isPostCodeAuto = true;
            // _isPostCodeNormal = false;
            // _customPostcodeErrorMsg = true;
            print('Postcode is not Valid');
          }

          _postcodeCityModel.map((item) {
            cityID = item.id;
          }).toList();
        }));
  }

  // onChange validation chracter count
  void _getCharacterCount() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    await api.getCharacterCount(identityTypeID!);
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          _isFetching = true;
          characterCount = store.getItem('characterCountLS');
          identityTypeLabel = store.getItem('typeLS');

          Navigator.pop(context);
        }));
  }

  //! PASSWORD ALGORITHM INTEGRATED WITH MSP
  List<AuthConfig> _authConfigModel = [];

  String errorMessage = '';

  // 1st you check whether its true or false
  int getPasswordLength = 8;
  int? getPasswordUpperCase;
  int? getPasswordLowerCase;
  int? getPasswordNumber;
  int? getPasswordSymbol;

  //* Password pattern
  var error = false;
  var errorPlus = [];
  var passwordRE;

  //* Closed Password pattern

  // Get authentication setting
  void _getAuthConfig() async {
    _authConfigModel = await api.getAuthConfig();

    // default follow pelangan with no rule when register > When updating refer its on column
    getPasswordLength = _authConfigModel[0].passwordLength!;

    getPasswordUpperCase = _authConfigModel[0].hasUppercase;
    getPasswordLowerCase = _authConfigModel[0].hasLowercase;
    getPasswordNumber = _authConfigModel[0].hasNumber;
    getPasswordSymbol = _authConfigModel[0].hasSymbol;

    String uppercasePattern = '';
    String lowercasePattern = '';
    String numberPattern = '';
    String customSymbolPattern = '';

    print('Password length : ' + getPasswordLength.toString());

    // The value here is been put in regex
    if (getPasswordUpperCase == 1) {
      print('hasUpperCase');
      uppercasePattern = '(?=.*?[A-Z])';
      errorPlus.add("sekurang-kurangnya satu huruf besar");
    }
    if (getPasswordLowerCase == 1) {
      print('hasLowerCase');
      lowercasePattern = '(?=.*?[a-z])';
      errorPlus.add("satu huruf kecil");
    }
    if (getPasswordNumber == 1) {
      print('hasNumber');
      numberPattern = '(?=.*?[0-9])';
      errorPlus.add("satu nombor");
    }
    if (getPasswordSymbol == 1) {
      print('hasSymbol');
      customSymbolPattern = '(?=.*?[#?!@\$%^&*-])';
      errorPlus.add("satu simbol");
    }

    if (errorPlus.length > 1) {
      var last =
          errorPlus[errorPlus.length - 1]; // Get last added array and subtract
      errorPlus.removeLast();

      errorMessage =
          'Kata laluan anda tidak menepati polisi kata laluan yang ditetapkan. (Kombinasi ' +
              getPasswordLength.toString() +
              ' minimum karakter, ' +
              errorPlus.join(", ") +
              ' dan ' +
              last +
              ')';
    }

    passwordRE = RegExp(r'^' +
        uppercasePattern +
        lowercasePattern +
        numberPattern +
        customSymbolPattern +
        '.' +
        '{' +
        getPasswordLength.toString() +
        ',' +
        r'}$');
  }
  //! CLOSED PASSWORD ALGORITHM INTEGRATED WITH MSP

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              'User Profile Registration'.tr,
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
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autofocus: true,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Email'.tr),
                      hintText: 'Use your personal email.'.tr,
                      suffixIcon: _isEmailValid
                          ? IconTheme(
                              data: IconThemeData(color: Colors.green),
                              child: Icon(
                                LineIcons.checkCircle,
                              ))
                          : IconTheme(
                              data: IconThemeData(color: Colors.red),
                              child: Icon(
                                LineIcons.timesCircle,
                              )),
                    ),
                    initialValue: email,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be left blank.'.tr;
                      }
                      if (!emailRE.hasMatch(value)) {
                        return 'Your email is invalid.'.tr;
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        email = val;
                        onChangedEmail(email);
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 20,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r"^[+.]?\d+\b$|^[+.]$"),
                      ),
                    ],
                    decoration: styles.inputDecoration
                        .copyWith(label: getRequiredLabel('Phone Number'.tr)),
                    controller: phoneNo,
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
                        val = phoneNo.text;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('First Name'.tr),
                    ),
                    initialValue: firstName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be left blank.'.tr;
                      } else if (!nameRE.hasMatch(value)) {
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
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Last Name'.tr),
                      // hintText: 'Nama akhir',
                    ),
                    initialValue: lastName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be left blank.'.tr;
                      } else if (!nameRE.hasMatch(value)) {
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
                      Radio(
                        value: 1,
                        groupValue: citizenship,
                        activeColor: Colors.blue,
                        onChanged: (value) {
                          setState(() {
                            citizenship = value as int;
                            _radioVal = 'Citizen'.tr;
                            // _isMalaysia = true;
                            // _isNotMalaysia = false;
                            // _isPostcodeMalaysia = true;
                            // _isPostcodeNotMalaysia = false;
                            identityTypeID = null;
                            _isForeigner = false;
                            countryID = 458;
                            identityTypeID = null;
                            identityTypeLabel = '';
                            identityNo = '';
                            _isShowIdentityNo = false;
                            _isVisibleEndDate = false;
                          });
                        },
                      ),
                      Text(
                        'Citizen'.tr,
                        style: styles.heading18,
                      ),
                      Radio(
                        value: 0,
                        groupValue: citizenship,
                        activeColor: Colors.pink,
                        onChanged: (value) {
                          setState(() {
                            citizenship = value as int;
                            _radioVal = 'Non Citizen'.tr;
                            // _isMalaysia = false;
                            // _isNotMalaysia = true;
                            // _isPostcodeMalaysia = false;
                            // _isPostcodeNotMalaysia = true;
                            _isForeigner = true;
                            // countryID = null;
                            identityTypeID = null;
                            identityTypeLabel = '';
                            identityNo = '';
                            _isShowIdentityNo = false;
                            _isVisibleEndDate = false;
                          });
                        },
                      ),
                      Text(
                        'Non Citizen'.tr,
                        style: styles.heading18,
                      ),
                    ],
                  ),
                  // Auto complete kewarganegaraan
                  Visibility(
                    visible: _isForeigner,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: LayoutBuilder(
                        builder: (_, BoxConstraints constraints) =>
                            Autocomplete<Country>(
                          optionsBuilder: (textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return _countryModel;
                            } else {
                              return _countryModel.where((country) =>
                                  country.name!.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase()));
                            }
                          },
                          fieldViewBuilder: (context, textEditingController,
                              focusNode, onFieldSubmitted) {
                            return TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: textEditingController,
                              focusNode: focusNode,
                              onEditingComplete: onFieldSubmitted,
                              decoration: styles.inputDecoration.copyWith(
                                  label: getRequiredLabel('Country'.tr),
                                  hintText: 'Please Select'.tr,
                                  suffixIcon:
                                      Icon(LineIcons.chevronCircleDown)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field cannot be left blank.'.tr;
                                } else if (_countryNameList.contains(value) ==
                                    false) {
                                  return 'No record found.'.tr;
                                }
                                return null;
                              },
                            );
                          },
                          optionsViewBuilder:
                              ((context, onSelected, countries) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: constants.secondaryColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: constraints.maxWidth,
                                  height: constraints.maxWidth / 2,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: countries.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final Country data =
                                          countries.elementAt(index);
                                      return ListTile(
                                        title: Text(data.name!),
                                        onTap: () {
                                          onSelected(data);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
                          onSelected: (data) {
                            setState(() {
                              countryNationalityId = data.id;
                              print(data.id);
                            });
                          },
                          displayStringForOption: ((data) => data.name!),
                        ),
                      ),
                    ),
                  ),
                  // Closed auto complete kewarganegaraan
                  SizedBox(height: 20),
                  Visibility(
                    visible: true,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: LayoutBuilder(
                        builder: (_, BoxConstraints constraints) =>
                            Autocomplete<IdentityType>(
                          optionsBuilder: (textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return !_isForeigner
                                  ? _identityTypeCitizenModel
                                  : _identityTypeNonCitizenModel;
                            }

                            // else if (){

                            // }

                            else {
                              return !_isForeigner
                                  ? _identityTypeCitizenModel.where(
                                      (identityType) => identityType.type!
                                          .toLowerCase()
                                          .contains(textEditingValue.text
                                              .toLowerCase()))
                                  : _identityTypeNonCitizenModel.where(
                                      (identityType) => identityType.type!
                                          .toLowerCase()
                                          .contains(textEditingValue.text
                                              .toLowerCase()));
                            }
                          },
                          fieldViewBuilder: (context, textEditingController,
                              focusNode, onFieldSubmitted) {
                            return TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: textEditingController,
                              focusNode: focusNode,
                              onEditingComplete: onFieldSubmitted,
                              decoration: styles.inputDecoration.copyWith(
                                  label: getRequiredLabel('User ID Type'.tr),
                                  hintText: 'Please Select'.tr,
                                  suffixIcon:
                                      Icon(LineIcons.chevronCircleDown)),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field cannot be left blank.'.tr;
                                } else if ((!_isForeigner
                                        ? _identityTypeCitizenModelTypeList
                                            .contains(value)
                                        : _identityTypeNonCitizenModelTypeList
                                            .contains(value)) ==
                                    false) {
                                  print(_identityTypeNonCitizenModel);

                                  return 'No record found.'.tr;
                                }
                                return null;
                              },
                            );
                          },
                          optionsViewBuilder:
                              ((context, onSelected, identityTypes) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: constants.secondaryColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: constraints.maxWidth,
                                  height: constraints.maxWidth / 2,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: identityTypes.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final IdentityType data =
                                          identityTypes.elementAt(index);
                                      return ListTile(
                                        title: Text(data.type!),
                                        onTap: () {
                                          onSelected(data);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
                          onSelected: (data) {
                            setState(() {
                              identityTypeID = data.id;

                              if (data.hasExpiredDate == 1) {
                                _isVisibleEndDate = true;
                              } else {
                                _isVisibleEndDate = false;
                              }
                              _getCharacterCount();
                              _isShowIdentityNo = true;
                              if (identityTypeID == 2) {
                                _isPassport = true;
                              } else if (identityTypeID == 4) {
                                _isPassport = false;
                              } else {
                                _isPassport = false;
                              }
                            });
                          },
                          displayStringForOption: ((data) => data.type!),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isShowIdentityNo,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLength: _isFetching ? characterCount : null,
                        textInputAction: TextInputAction.next,
                        keyboardType: _isPassport
                            ? TextInputType.text
                            : TextInputType.number,
                        inputFormatters: _isPassport
                            ? null
                            : [FilteringTextInputFormatter.digitsOnly],
                        decoration: styles.inputDecoration.copyWith(
                            label: getRequiredLabel(
                                'Number '.tr + identityTypeLabel)),
                        initialValue: identityNo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be left blank.'.tr;
                          } else if (value.length != characterCount) {
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
                  SizedBox(height: _isVisibleEndDate ? 0 : 13),
                  Visibility(
                    visible: _isVisibleEndDate,
                    child: Column(
                      children: [
                        SizedBox(height: 7),
                        TextFormField(
                          controller: dateinput,
                          decoration: styles.inputDecoration.copyWith(
                              suffix: Icon(LineIcons.calendarAlt),
                              label: getRequiredLabel(
                                  'Expiry Date'.tr + ' ' + identityTypeLabel)),
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be left blank.'.tr;
                            }
                            return null;
                          },
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
                                  dateFormatterDisplay.format(pickedDate);
                              setState(() {
                                dateinput.text = formattedDateDisplay;
                                identityEndDate = formattedDate;
                                print(formattedDate);
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Address 1'.tr),
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
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      labelText: 'Address 2'.tr,
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
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      labelText: 'Address 3'.tr,
                    ),
                    initialValue: address3,
                    onChanged: (val) {
                      setState(() {
                        address3 = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  // Auto complete Negara
                  LayoutBuilder(
                    builder: (_, BoxConstraints constraints) =>
                        Autocomplete<Country>(
                      optionsBuilder: (textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return _countryModel;
                        } else {
                          return _countryModel.where((country) => country.name!
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()));
                        }
                      },
                      fieldViewBuilder: (context, textEditingController,
                          focusNode, onFieldSubmitted) {
                        textEditingController.text =
                            textEditingController.text == ""
                                ? initialCountryValue
                                : textEditingController.text;

                        return TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: textEditingController,
                          focusNode: focusNode,
                          onEditingComplete: onFieldSubmitted,
                          decoration: styles.inputDecoration.copyWith(
                            label: getRequiredLabel('Country'.tr),
                            hintText: 'Please Select'.tr,
                            suffixIcon: Icon(LineIcons.chevronCircleDown),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'This field cannot be left blank.'.tr;
                            } else if (_countryNameList.contains(value) ==
                                false) {
                              return 'No record found.'.tr;
                            }
                            return null;
                          },
                        );
                      },
                      optionsViewBuilder: ((context, onSelected, countries) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            child: Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: constants.secondaryColor),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: constraints.maxWidth,
                              height: constraints.maxWidth / 2,
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: countries.length,
                                // separatorBuilder:
                                //     (BuildContext context, int index) {
                                //   return const Divider();
                                // },
                                itemBuilder: (BuildContext context, int index) {
                                  final Country data =
                                      countries.elementAt(index);
                                  return ListTile(
                                    title: Text(data.name!),
                                    onTap: () {
                                      // textEditingController.text = '';
                                      onSelected(data);
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                      onSelected: (data) {
                        setState(() {
                          countryID = data.id;
                          print(data.id);
                          if (countryID == 458 && _isPostCodeNormal == true) {
                            print('Warganegara & Malaysia & true');
                            _isMalaysia = true;
                            _isNotMalaysia = false;
                            _isPostCodeNormal = true;
                            _isPostcodeMalaysia = true;
                          } else if (countryID == 458 &&
                              _isPostCodeNormal == false) {
                            print('Warganegara & Malaysia & false');
                            _isMalaysia = true;
                            _isNotMalaysia = false;
                            _isPostCodeNormal = false;
                            _isPostcodeMalaysia = true;
                          } else {
                            print('Warganegara & Bukan Malaysia');
                            _isMalaysia = false;
                            _isNotMalaysia = true;
                            _isPostCodeNormal = false;
                            _isPostcodeMalaysia = false;
                          }
                        });
                      },
                      displayStringForOption: ((data) => data.name!),
                    ),
                  ),
                  // Closed auto complete negara
                  SizedBox(height: 20),
                  // Postcode is malaysia
                  Visibility(
                    visible: _isPostcodeMalaysia,
                    child: TextFormField(
                      maxLength: 5,
                      textAlign: TextAlign.start,
                      initialValue: postcode,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: styles.inputDecoration.copyWith(
                        label: getRequiredLabel('Postcode'.tr),
                        errorMaxLines: 5,
                        suffixIcon: _isPostCodeValid
                            ? IconTheme(
                                data: IconThemeData(color: Colors.green),
                                child: Icon(
                                  LineIcons.checkCircle,
                                ))
                            : IconTheme(
                                data: IconThemeData(color: Colors.red),
                                child: Icon(
                                  LineIcons.timesCircle,
                                ),
                              ),
                      ),
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
                          initialDistrictValue++;
                          print(initialDistrictValue);
                          postcode = val;
                          onChangedPostcode(postcode.toString());
                          postcode = postcode;
                          if (postcode.length >= 5) {
                            _getDataPostcodeCityState();
                          } else {
                            stateID = null;
                            cityID = null;
                            districtID = null;
                            initialDistrictValue = 0;
                          }
                        });
                      },
                    ),
                  ),
                  // Postcode not malaysia
                  Visibility(
                    visible: !_isPostcodeMalaysia,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        maxLength: 10,
                        initialValue: postcode,
                        decoration: styles.inputDecoration.copyWith(
                          label: getRequiredLabel('Postcode'.tr),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field cannot be left blank.'.tr;
                          } else if (value.length < 2) {
                            return 'The poscode you entered is invalid.'.tr;
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
                  SizedBox(height: 10),
                  // Negeri
                  Visibility(
                    visible: _isPostCodeNormal,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
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
                                  borderRadius: BorderRadius.circular(8)),
                              label: getRequiredLabel('State'.tr),
                              filled: true),
                          items: _postcodeStateModel.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item.name.toString(),
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
                              districtID = null;
                              stateID = newVal as int?;
                              print(stateID);
                              _getDataDistrict();
                            });
                          },
                          value: stateID,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isNotMalaysia,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: TextFormField(
                        decoration: styles.inputDecoration.copyWith(
                          label: getRequiredLabel('State'.tr),
                        ),
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
                  ),
                  // Auto completion daerah
                  Visibility(
                    visible: _isMalaysia,
                    child: IgnorePointer(
                      ignoring: _isPostCodeValid ? false : true,
                      child: LayoutBuilder(
                        builder: (_, BoxConstraints constraints) =>
                            Autocomplete<District>(
                          optionsBuilder: (textEditingValue) {
                            if (textEditingValue.text.isEmpty) {
                              return _districtModel;
                            } else {
                              return _districtModel.where((districts) =>
                                  districts.name!.toLowerCase().contains(
                                      textEditingValue.text.toLowerCase()));
                            }
                          },
                          fieldViewBuilder: (context, textEditingController,
                              focusNode, onFieldSubmitted) {
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              // To clear text controller when select other district
                              textEditingController.text =
                                  initialDistrictValue.toString() == '0'
                                      ? ''
                                      : textEditingController.text;
                            });
                            return TextFormField(
                              controller: textEditingController,
                              focusNode: focusNode,
                              onEditingComplete: onFieldSubmitted,
                              decoration: styles.inputDecoration.copyWith(
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: _isPostCodeValid
                                          ? BorderSide(color: Colors.grey)
                                          : BorderSide(
                                              color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(8)),
                                  label: getRequiredLabel('District'.tr),
                                  filled: _isPostCodeValid ? false : true,
                                  hintText: 'Please Select'.tr,
                                  suffixIcon: _isPostCodeValid
                                      ? Icon(LineIcons.chevronCircleDown)
                                      : null),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field cannot be left blank.'.tr;
                                } else if (_districtNameList.contains(value) ==
                                    false) {
                                  return 'No record found.'.tr;
                                }
                                return null;
                              },
                            );
                          },
                          optionsViewBuilder:
                              ((context, onSelected, districts) {
                            return Align(
                              alignment: Alignment.topLeft,
                              child: Material(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: constants.secondaryColor),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  width: constraints.maxWidth,
                                  height: constraints.maxWidth / 2,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    itemCount: districts.length,
                                    // separatorBuilder:
                                    //     (BuildContext context, int index) {
                                    //   return const Divider();
                                    // },
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final District data =
                                          districts.elementAt(index);
                                      return ListTile(
                                        title: Text(data.name!),
                                        onTap: () {
                                          onSelected(data);
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
                          onSelected: (data) {
                            setState(() {
                              districtID = data.id;
                            });
                          },
                          displayStringForOption: ((data) => data.name!),
                        ),
                      ),
                    ),
                  ),
                  // Closed Auto completion daerah
                  Visibility(
                    visible: _isNotMalaysia,
                    child: TextFormField(
                      decoration: styles.inputDecoration.copyWith(
                        label: getRequiredLabel('District'.tr),
                      ),
                      initialValue: districtName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be left blank.'.tr;
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
                  SizedBox(height: 20),
                  // Bandar
                  Visibility(
                    visible: _isPostCodeNormal,
                    child: IgnorePointer(
                      ignoring: true,
                      child: DropdownButtonFormField(
                        icon: Visibility(
                            visible: false,
                            child: Icon(LineIcons.chevronCircleDown)),
                        value: cityID,
                        isExpanded: true,
                        decoration: styles.inputDecoration.copyWith(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: constants.secondaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: getRequiredLabel('City'.tr),
                            filled: true),
                        items: _postcodeCityModel.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item.name.toString(),
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
                            cityID = newVal as int;
                          });
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isNotMalaysia,
                    child: TextFormField(
                      decoration: styles.inputDecoration.copyWith(
                        label: getRequiredLabel('City'.tr),
                      ),
                      initialValue: cityName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be left blank.'.tr;
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          cityName = val;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // Kata Laluan
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: !_isVisiblePass,
                    textAlign: TextAlign.justify,
                    decoration: styles.inputDecoration.copyWith(
                      errorMaxLines: 5,
                      label: getRequiredLabel('Password '.tr),
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _isPasswordValid
                              ? IconTheme(
                                  data: IconThemeData(color: Colors.green),
                                  child: Icon(
                                    LineIcons.checkCircle,
                                  ))
                              : IconTheme(
                                  data: IconThemeData(color: Colors.red),
                                  child: Icon(
                                    LineIcons.timesCircle,
                                  )),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisiblePass = !_isVisiblePass;
                              });
                            },
                            icon: _isVisiblePass
                                ? Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    initialValue: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be left blank.'.tr;
                      }
                      if (!passwordRE.hasMatch(value)) {
                        return errorMessage;
                      } else if (passwordRE == null) {
                        return 'Pattern is NULL';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        password = val;
                        onChangedPassword(password);
                        password = password;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: !_isVisiblePass,
                    textAlign: TextAlign.justify,
                    decoration: styles.inputDecoration.copyWith(
                      errorMaxLines: 5,
                      label: getRequiredLabel('Password Confirmation'.tr),
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _isConfirmPasswordValid
                              ? IconTheme(
                                  data: IconThemeData(color: Colors.green),
                                  child: Icon(
                                    LineIcons.checkCircle,
                                  ))
                              : IconTheme(
                                  data: IconThemeData(color: Colors.red),
                                  child: Icon(
                                    LineIcons.timesCircle,
                                  )),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisiblePass = !_isVisiblePass;
                              });
                            },
                            icon: _isVisiblePass
                                ? Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    initialValue: passwordConfirmation,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'This field cannot be left blank.'.tr;
                        } else if (value != password) {
                          return 'Password Confirmation must be the same as your Password.'
                              .tr;
                        }
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        passwordConfirmation = val;
                        onChangedConfirmPassword(passwordConfirmation);
                        passwordConfirmation = passwordConfirmation;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: isCheckedTnc,
                        onChanged: (
                          bool? value,
                        ) {
                          setState(() {
                            isCheckedTnc = value!;
                          });
                        },
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: InkWell(
                          onTap: (() => navigate(context, TncScreen())),
                          child: Text.rich(
                            TextSpan(
                              text: 'By registering, you agree to '.tr,
                              style: styles.heading2,
                              children: [
                                TextSpan(
                                  text: 'Terms and Conditions'.tr,
                                  style: styles.heading6bold,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: !_isRecaptcha,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Constants().sevenColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SliderCaptcha(
                            title: 'Match the image for verification'.tr,
                            titleStyle: styles.heading8subWhite,
                            imageToBarPadding: 20,
                            image: Image.asset(
                              'assets/dist/ipayment_logo.png',
                              fit: BoxFit.fitWidth,
                            ),
                            colorBar: Constants().primaryColor,
                            colorCaptChar: Constants().secondaryColor,
                            onConfirm: (value) {
                              if (value) {
                                Future.delayed(const Duration(seconds: 1))
                                    .then((value) {
                                  setState(() {
                                    _isRecaptcha = true;
                                    isCheckedRobot = true;
                                  });

                                  snack(context,
                                      'Captcha verification successful.'.tr,
                                      level: SnackLevel.Success);
                                });
                              } else {
                                Get.snackbar(
                                  snackPosition: SnackPosition.TOP,
                                  "".tr,
                                  'Please try again.'.tr,
                                  messageText: Text(
                                    'Please try again.'.tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16,
                                    ),
                                  ),
                                  padding:
                                      EdgeInsets.only(bottom: 30, left: 16),
                                  backgroundColor: Colors.red,
                                );
                              }
                              return Future.value();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _isRecaptcha,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: isCheckedRobot,
                          onChanged: (
                            bool? value,
                          ) {},
                        ),
                        SizedBox(width: 5),
                        Text("I'm not a robot".tr, style: styles.heading2),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  _isLoading
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: DefaultLoadingBar(),
                        )
                      : PrimaryButton(
                          isLoading: _isLoading,
                          text: 'Register'.tr,
                          onPressed: !isCheckedTnc || !isCheckedRobot
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
                                      var response = await api.register(
                                          email,
                                          isBanned,
                                          firstName,
                                          lastName,
                                          citizenship,
                                          identityNo,
                                          countryID!,
                                          stateID,
                                          address1,
                                          address2,
                                          address3,
                                          postcode,
                                          districtID,
                                          cityID,
                                          phoneNo.text,
                                          isCheckedTnc,
                                          password,
                                          passwordConfirmation,
                                          identityTypeID!,
                                          identityEndDate,
                                          stateName,
                                          districtName,
                                          cityName,
                                          countryNationalityId);
                                      if (response.isSuccessful) {
                                        // var verifyRoute = MaterialPageRoute(
                                        //     builder: (_) => VerifyEmailPage());
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        await store.setItem(
                                            'getEmailWidget', email);

                                        // Navigator.of(context)
                                        //     .pushAndRemoveUntil(
                                        //         verifyRoute, (route) => false);
                                        navigate(context, VerifyEmailPage());
                                        hideSnacks(context);
                                        snack(
                                            context,
                                            'Your registration has been successfully sent. Please refer to the email <'
                                                    .tr +
                                                maskEmail(email) +
                                                '> to activate your account.'
                                                    .tr
                                                    .tr,
                                            level: SnackLevel.Success);
                                        return;
                                      }
                                      hideSnacks(context);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      if (response.statusCode == 503) {
                                        navigate(context, MaintenanceScreen());
                                      }
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
                  SizedBox(height: 23),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ".tr,
                            style: styles.heading2,
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            child: Text("Login".tr, style: styles.heading6bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
