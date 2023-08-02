import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/models/users/auth_config.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/screens/auth/forgot_password.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String currentPassword = '';
  String password = '';
  String passwordConfirmation = '';

  @override
  void initState() {
    super.initState();
    _getAuthConfig();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isFormEmpty() {
    if (currentPassword.isEmpty ||
        password.isEmpty ||
        passwordConfirmation.isEmpty) {
      return true;
    }

    return false;
  }

  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;
  bool isLoading = false;
  bool _isVisiblePass = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;

  // final passwordRE = RegExp(
  //     r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!#^,()%*?&.\/])[A-Za-z\d@$!#^(),%*?&.\/]{8,20}$");

// Password
  onChangedPassword(String passwordPattern) {
    setState(
      () {
        _isPasswordValid = false;
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
      error = true;
      print('hasUpperCase');
      uppercasePattern = '(?=.*?[A-Z])';
      errorPlus.add("sekurang-kurangnya satu huruf besar");
    }

    if (getPasswordLowerCase == 1) {
      error = true;
      print('hasLowerCase');
      lowercasePattern = '(?=.*?[a-z])';
      errorPlus.add("satu huruf kecil");
    }
    if (getPasswordNumber == 1) {
      error = true;
      print('hasNumber');
      numberPattern = '(?=.*?[0-9])';
      errorPlus.add("satu nombor");
    }
    if (getPasswordSymbol == 1) {
      error = true;
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
              'Change Password'.tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                SizedBox(height: 30),
                TextFormField(
                  obscureText: !_isVisiblePass,
                  textAlign: TextAlign.justify,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: styles.inputDecoration.copyWith(
                    errorMaxLines: 5,
                    labelText: 'Current Password'.tr,
                    suffixIcon: IconButton(
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
                  ),
                  initialValue: currentPassword,
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'This field cannot be left blank.'.tr;
                      }
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      currentPassword = val;
                    });
                  },
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    navigate(context, ForgotPasswordScreen());
                  },
                  child: Text(
                    "Forgot Password?".tr,
                    style: styles.heading6,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  initialValue: password,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlign: TextAlign.justify,
                  decoration: styles.inputDecoration.copyWith(
                    errorMaxLines: 5,
                    labelText: 'New Password'.tr,
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
                  validator: (value) {
                    print(_isPasswordValid);
                    if (value == null || value.isEmpty) {
                      return 'This field cannot be left blank.'.tr;
                    } else if (!passwordRE.hasMatch(value)) {
                      return errorMessage;
                    } else if (value == currentPassword) {
                      Future.delayed(const Duration(seconds: 0))
                          .then((value) => setState(() {
                                _isPasswordValid = false;
                              }));

                      return 'The new password cannot be the same as the old password.'
                          .tr;
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
                  obscureText: !_isVisiblePass,
                ),
                SizedBox(height: 16),
                TextFormField(
                  initialValue: passwordConfirmation,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textAlign: TextAlign.justify,
                  decoration: styles.inputDecoration.copyWith(
                    errorMaxLines: 5,
                    labelText: 'Password Verification'.tr,
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
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'This field cannot be left blank.'.tr;
                      } else if (value != password) {
                        return 'The password confirmation must be the same as your new password.'
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
                  obscureText: !_isVisiblePass,
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    isLoading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: DefaultLoadingBar(),
                          )
                        : PrimaryButton(
                            isLoading: isLoading,
                            text: 'Update'.tr,
                            onPressed: _isFormEmpty()
                                ? null
                                : () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        var response = await api.changePassword(
                                            currentPassword,
                                            password,
                                            passwordConfirmation);
                                        if (response.isSuccessful) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          snack(
                                              context,
                                              'Your password has been successfully changed.'
                                                  .tr,
                                              level: SnackLevel.Success);
                                          logout(context);
                                          return;
                                        }
                                        hideSnacks(context);
                                        setState(() {
                                          isLoading = false;
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
                                                .tr,
                                            level: SnackLevel.Warning);
                                      }
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
