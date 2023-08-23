import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/screens/auth/forgot_user_id.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final myController = TextEditingController();

  bool isLoading = false;
  String _email = '';

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  bool _isFormEmpty() {
    if (_email.isEmpty) {
      return true;
    }

    return false;
  }

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isEmailValid = false;

  // Email validation
  onEmailChanged(String email) {
    final emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    setState(
      () {
        _isEmailValid = false;
        if (emailValid.hasMatch(email)) _isEmailValid = true;
      },
    );
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
              'Forgot Password'.tr,
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
                "Enter the registered user ID (email) associated with iPayment."
                    .tr,
                style: styles.heading2sub,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (email) {
                  onEmailChanged(email);
                  _email = email;
                },
                style: styles.heading5,
                decoration: styles.inputDecoration.copyWith(
                  label: getRequiredLabel('Email'.tr),
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
                initialValue: _email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                validator: MultiValidator(
                  [
                    RequiredValidator(
                        errorText: "This field cannot be left blank.".tr),
                    EmailValidator(errorText: "Enter a valid email".tr),
                  ],
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  navigate(context, ForgotUserIDScreen());
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot user ID?".tr,
                    style: styles.heading6,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Column(children: [
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
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    try {
                                      var response =
                                          await api.forgotPassword(_email);
                                      if (response.isSuccessful) {
                                        var homeRoute = MaterialPageRoute(
                                            builder: (_) => LoginScreen());
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                homeRoute, (route) => false);
                                        hideSnacks(context);
                                        snack(
                                            context,
                                            'A new password setting link has been sent to your email.'
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
                                          'There is a problem connecting to the server. Please try again.'
                                              .tr,
                                          level: SnackLevel.Error);
                                    }
                                  }
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
