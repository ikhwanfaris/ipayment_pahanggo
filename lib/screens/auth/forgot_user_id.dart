import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/models/users/identity_type.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';

class ForgotUserIDScreen extends StatefulWidget {
  ForgotUserIDScreen({Key? key}) : super(key: key);

  @override
  _ForgotUserIDScreenState createState() => _ForgotUserIDScreenState();
}

class _ForgotUserIDScreenState extends State<ForgotUserIDScreen> {
  final myController = TextEditingController();
  TextEditingController verifiedIcNo = TextEditingController();

  bool isLoading = false;
  String identityNo = '';
  int userIdentityTypeId = 1;

  int characterCount = 12;
  String identityTypeLabel = 'Kad Pengenalan';

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _identityType();
    _getCharacterCount();
  }

  bool _isFormEmpty() {
    if (verifiedIcNo.text.isEmpty) {
      return true;
    }

    return false;
  }

  // onChange validation chracter count
  void _getCharacterCount() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    await api.getCharacterCount(userIdentityTypeId);
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          characterCount = store.getItem('characterCountLS');
          identityTypeLabel = store.getItem('typeLS');

          // print(characterCount);
          // print(identityTypeLabel);
          Navigator.pop(context);
        }));
  }

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isFound = false;
  bool _isNumber = true;

  List<String> citizenshipModel = ['Warganegara', 'Bukan Warganegara'];
  List<IdentityType> _identityTypeAllModel = [];

  void _identityType() async {
    _identityTypeAllModel = await api.getIndentityTypeAll();
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

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
              'Forgot User ID'.tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
            children: [
              Text(
                "Enter the User ID Number registered with iPayment".tr,
                style: styles.heading2sub,
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
                      print(newVal);
                      verifiedIcNo.clear();
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
              TextFormField(
                controller: verifiedIcNo,
                maxLength: characterCount,
                // style: styles.heading2,
                keyboardType:
                    _isNumber ? TextInputType.number : TextInputType.text,
                inputFormatters:
                    _isNumber ? [FilteringTextInputFormatter.digitsOnly] : null,
                decoration: styles.inputDecoration.copyWith(
                  labelText: 'Number '.tr + identityTypeLabel,
                  hintStyle: styles.heading2,
                  // suffixIcon: Icon(LineIcons.identificationBadge),
                ),
                // initialValue: identityNo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be left blank.'.tr;
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    val = verifiedIcNo.text;
                  });
                },
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Column(
                  children: [
                    _isLoading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: DefaultLoadingBar(),
                          )
                        : PrimaryButton(
                            isLoading: _isLoading,
                            text: 'Send'.tr,
                            onPressed: _isFormEmpty()
                                ? null
                                : () async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      try {
                                        var response = await api.forgotUserID(
                                            verifiedIcNo.text,
                                            userIdentityTypeId);
                                        if (response.isSuccessful) {
                                          setState(() {
                                            _isLoading = false;
                                          });

                                          _isFound = true;

                                          snack(
                                              context,
                                              'User ID is: ' +
                                                  store
                                                      .getItem('getUserID')
                                                      .toString(),
                                              level: SnackLevel.Success);

                                          return;
                                        }
                                        hideSnacks(context);
                                        setState(() {
                                          _isLoading = false;
                                          _isFound = false;
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
                                            'There is a problem connecting to the server. Please try again.'
                                                .tr,
                                            level: SnackLevel.Error);
                                      }
                                    }
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }),
                    SizedBox(height: 100),
                    Visibility(
                      visible: _isFound,
                      child: Column(
                        children: [
                          Text('User ID is: '.tr),
                          SizedBox(height: 10),
                          Text(
                            store.getItem('getUserID').toString(),
                            textAlign: TextAlign.center,
                            style: styles.heading6bold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
