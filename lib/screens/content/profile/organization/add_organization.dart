import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/screens/content/profile/organization/home_organization.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/models/users/city.dart';
import 'package:flutterbase/models/organizations/organization_type.dart';
import 'package:flutterbase/models/users/postcode_city.dart';
import 'package:flutterbase/models/users/postcode_state.dart';
import 'package:flutterbase/models/users/states.dart';
import 'package:flutterbase/models/users/district.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

enum SingingCharacter { citizenship, nonCitizenship }

class AddOrganizationScreen extends StatefulWidget {
  AddOrganizationScreen({Key? key}) : super(key: key);

  @override
  _AddOrganizationScreenState createState() => _AddOrganizationScreenState();
}

class _AddOrganizationScreenState extends State<AddOrganizationScreen> {
  TextEditingController dateinput = TextEditingController();

  // var maskFormatter = new MaskTextInputFormatter(
  //     mask: "AAA-###-##-########", type: MaskAutoCompletionType.lazy);

  bool _isPostCodeNormal = true;
  var initialDistrictValue = 0;

  List<String> _stateNameList = [];
  List<String> _cityNameList = [];
  List<String> _districtNameList = [];

  TextEditingController controller = TextEditingController();

  int userId = state.user.id!;
  String orgName = '';
  String orgEmail = '';
  int? orgTypeId;
  String orgRegistrationNo = '';
  String orgRegistrationNoOld = '';
  String dateExtablished = '';
  String address1 = '';
  String address2 = '';
  String address3 = '';
  String postcode = '';
  String phoneNo = '';
  int? countryId = 458;
  int? stateID;
  int? districtID;
  int? cityID;

  String stateName = '';
  String districtName = '';
  String cityName = '';

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool isChecked = false;

  // ignore: unused_field
  List<States> _statesModel = [];
  List<District> _districtModel = [];
  // ignore: unused_field
  List<City> _cityModel = [];
  List<OrganizationType> _orgTypeModel = [];

  bool _isEmailValid = false;
  bool _isPostCodeValid = false;

  List<PostcodeCity> _postcodeCityModel = [];
  List<PostcodeState> _postcodeStateModel = [];
  bool _isShowRegistrationNo = false;

  String orgNoExits = 'empty';

  // bool _customOrganizationErrorMsg = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  bool _isFormEmpty() {
    if (orgEmail.isEmpty ||
        orgName.isEmpty ||
        orgTypeId == null ||
        orgRegistrationNo.isEmpty ||
        dateinput.text.isEmpty ||
        phoneNo.isEmpty ||
        address1.isEmpty ||
        postcode.isEmpty ||
        stateID == null ||
        districtID == null ||
        cityID == null) {
      return true;
    }

    return false;
  }

  // Fix postcode not valid error message
  String getPostcodeStatusLS = 'null';

  List<States> _stateModel = [];

  // List<Organization> _validateOrgNo = [];

// RegexExp
  final nameRE = RegExp(r"^(?=.{3})[a-zA-Z0-9_\-=@/',\.;\s]+$");
  final emailRE = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final postcodeRE = RegExp(r"^\b\d{5}\b$");
  final phoneRE = RegExp(r"^[+.]?\d+\b$|^[+.]$");
  final organizationRE =
      RegExp(r"^(?=[a-zA-Z1-9]{6,15}$)[a-zA-Z]{3}[1-9]{3,15}[a-zA-Z]*$");

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

  void _getData() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _orgTypeModel = await api.getOrganizationType();

    _orgTypeModel.sort((a, b) {
      return a.type!.toLowerCase().compareTo(b.type!.toLowerCase());
    });
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
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

  void _getDataPostcodeState() async {
    _postcodeStateModel = await api.getPostcodeState(postcode);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _postcodeStateModel.map((item) {
            stateID = item.id;
            _getDataDistrict();
          }).toList();
        }));
  }

  // State
  void _getDataStateCity() async {
    _stateModel = await api.getStates();
    _cityModel = await api.getCity();
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
            _isPostCodeNormal = true;

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

// onChange validation Organization no
  void _validateOrganizationNo() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    await api.validateOrganizationNo(orgRegistrationNo);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          orgNoExits = store.getItem('hasValueLS');
          print(orgNoExits);
          Navigator.pop(context);
        }));
  }

  int characterCount = 20;
  bool _isFetching = false;
  String identityTypeLabel = '';
  bool _isSSM = true; // Can validation regex

  // onChange validation character count
  void _getCharacterCount() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    await api.getCharacterCount(orgTypeId!);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _isFetching = true;
          characterCount = store.getItem('characterCountLS');
          // identityTypeLabel = store.getItem('typeLS');

          if (orgTypeId == 6) {
            identityTypeLabel = 'SSM';
            _isSSM = true;
          } else if (orgTypeId == 7) {
            identityTypeLabel = 'ROS';
            _isSSM = false;
          }

          print(characterCount);
          Navigator.pop(context);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 55),
          child: Center(
            child: Text(
              'Register Organization'.tr,
              style: styles.heading4,
            ),
          ),
        ),
      ), //AppBar
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    autofocus: true,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Organization Email'.tr),
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
                    initialValue: orgEmail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be left blank.'.tr;
                      }
                      if (!emailRE.hasMatch(value)) {
                        return 'Your organization email is invalid'.tr;
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        orgEmail = val;
                        onChangedEmail(orgEmail);
                        orgEmail = orgEmail;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Organization Name'.tr),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field cannot be left blank.'.tr;
                      } else if (!nameRE.hasMatch(value)) {
                        return 'Organization name is invalid';
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
                  DropdownButtonFormField(
                    icon: Visibility(
                        visible: false,
                        child: Icon(LineIcons.chevronCircleDown)),
                    isExpanded: true,
                    decoration: styles.inputDecoration.copyWith(
                      suffixIcon: Icon(LineIcons.chevronCircleDown),
                      label: getRequiredLabel('Organization Type'.tr),
                      hintText: 'Please Select'.tr,
                    ),
                    items: _orgTypeModel.map((item) {
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
                    //! NEED INTEGRATE WITH MSP
                    onChanged: (newVal) {
                      setState(() {
                        orgTypeId = newVal as int;
                        _getCharacterCount();
                        print(orgTypeId);
                        _isShowRegistrationNo = true;
                      });
                    },
                    value: orgTypeId,
                  ),
                  SizedBox(height: 20),
                  // SSM
                  Visibility(
                    visible: _isShowRegistrationNo,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      maxLength: _isFetching ? characterCount : null,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      inputFormatters: _isSSM
                          ? [FilteringTextInputFormatter.digitsOnly]
                          : [
                              UpperCaseTextFormatter(),
                              // maskFormatter,
                              FilteringTextInputFormatter(RegExp(r"[A-Z0-9]+"),
                                  allow: true)
                            ],
                      decoration: styles.inputDecoration.copyWith(
                        label: getRequiredLabel(
                          'Organization Registration'.tr +
                              ' ' +
                              identityTypeLabel,
                        ),
                      ),
                      initialValue: orgRegistrationNo,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be left blank.'.tr;
                        } else if (value.length != characterCount) {
                          return 'Organization Registration'.tr +
                              ' ' +
                              identityTypeLabel +
                              ' ' +
                              'is invalid';
                        } else if (orgNoExits == 'data') {
                          return 'The organization already exists!'.tr;
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          orgRegistrationNo = val;
                          if (val.length >= characterCount) {
                            _validateOrganizationNo();

                            // just get unmasked function instead of this
                            // var filterOrgRegistrationNo = orgRegistrationNo
                            //     .toString()
                            //     .replaceAll(
                            //         new RegExp(r"\p{P}", unicode: true), "");
                            // orgRegistrationNo = filterOrgRegistrationNo;

                            // print(orgRegistrationNo);
                          }
                        });
                      },
                    ),
                  ),
                  // TextField(inputFormatters: [maskFormatter]),
                  SizedBox(height: 7),
                  TextFormField(
                      controller: dateinput,
                      decoration: styles.inputDecoration.copyWith(
                          suffix: Icon(LineIcons.calendarAlt),
                          label: getRequiredLabel('Establishment Date'.tr)),
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
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now());

                        if (pickedDate != null) {
                          String formattedDate =
                              dateFormatter.format(pickedDate);
                          String formattedDateDisplay =
                              dateFormatterDisplay.format(pickedDate);
                          setState(() {
                            dateinput.text = formattedDateDisplay;
                            print(dateinput.text);
                            print(formattedDate);
                            dateExtablished = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field cannot be left blank.'.tr;
                        }
                        return null;
                      }),
                  SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r"^[+.]?\d+\b$|^[+.]$"),
                      ),
                    ],
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Phone Number'.tr),
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
                  TextFormField(
                    maxLength: 5,
                    textAlign: TextAlign.start,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
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
                        initialDistrictValue++;
                        postcode = val;
                        onChangedPostcode(postcode);
                        postcode = postcode;
                        // districtID = null;
                        // cityID = null;
                        // stateID = null;
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
                  // Custom validation error message
                  SizedBox(height: 10),
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
                          value: stateID,
                          isExpanded: true,
                          decoration: styles.inputDecoration.copyWith(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: getRequiredLabel('State'.tr),
                            filled: true,
                          ),
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
                              cityID = null;
                              stateID = newVal as int?;
                              print(stateID);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Auto completion daerah
                  Visibility(
                    visible: true,
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
                                  height: constraints.maxWidth * 0.45,
                                  child: ListView.separated(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    itemCount: districts.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const Divider();
                                    },
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
                  SizedBox(height: 20),
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
                              borderSide: BorderSide(color: Colors.transparent),
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
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Column(
                        children: [
                          _isLoading
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: DefaultLoadingBar(),
                                )
                              : PrimaryButton(
                                  isLoading: _isLoading,
                                  text: 'Save'.tr,
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
                                            try {
                                              var response =
                                                  await api.organizationDetail(
                                                userId,
                                                orgName,
                                                orgEmail,
                                                orgTypeId!,
                                                orgRegistrationNo,
                                                dateExtablished,
                                                address1,
                                                address2,
                                                address3,
                                                postcode,
                                                stateID!,
                                                districtID!,
                                                cityID!,
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
                                                    .pushAndRemoveUntil(
                                                        homeRoute,
                                                        (route) => false);
                                                hideSnacks(context);
                                                snack(
                                                    context,
                                                    "Your organization information has been successfully saved."
                                                        .tr,
                                                    level: SnackLevel.Success);
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
