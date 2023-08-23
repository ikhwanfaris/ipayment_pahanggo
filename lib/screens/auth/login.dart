// ignore_for_file: unused_field

import 'dart:developer';
import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/controller/home_controller.dart';
import 'package:flutterbase/screens/home/menu.dart';
import 'package:flutterbase/screens/link_user_manual.dart';
import 'package:flutterbase/screens/maintenance/maintenance.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/screens/auth/forgot_password.dart';
import 'package:flutterbase/screens/auth/forgot_user_id.dart';
import 'package:flutterbase/screens/auth/register.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/phosphor.dart';
// import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/loading_blocker.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late FocusNode passwordFocusNode;

  bool _isVisible = false;
  RxBool isLoading = false.obs;
  bool isCheckedForgotUserID = false;

  String _username = '';
  String _password = '';

  bool _msMY = true;

  String _version = '...';
  String _buildNumber = '...';

  void initState() {
    super.initState();
    passwordFocusNode = FocusNode();

    loadingBlocker.bind(isLoading);

    PackageInfo.fromPlatform().then((info) {
      setState(() {
        _version = info.version;
        _buildNumber = info.buildNumber;
      });
    });

    _getSharedPref();
  }

  bool _isFormEmpty() {
    if (_username.isEmpty || _password.isEmpty) {
      return true;
    }

    return false;
  }

  void _getSharedPref() async {
    setState(() {
      _username = credentialStore.getItem('_username') ?? '';
    });
    print(_username);
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    var myLocaleLang = Get.locale?.languageCode;
    print(myLocaleLang);

    if (myLocaleLang.toString() == 'en') {
      setState(() {
        _msMY = false;
      });
    } else {
      setState(() {
        _msMY = true;
      });
    }
  }

  Widget buildSwitch() => Transform.scale(
        scale: 1.4,
        child: Switch(
          value: _msMY,
          inactiveThumbColor: constants.secondaryColor,
          activeColor: constants.secondaryColor,
          activeThumbImage: AssetImage('assets/dist/lang_malay.png'),
          inactiveThumbImage: AssetImage('assets/dist/lang_eng.png'),
          onChanged: (value) => setState(() {
            this._msMY = value;
            _getLang();
          }),
        ),
      );

  void _getLang() async {
    if (_msMY == true) {
      Locale locale = new Locale("ms_MY");
      log("Current: ${Get.locale?.languageCode}");
      Get.updateLocale(locale);
      log("New: ${Get.locale?.languageCode}");
      await api.setLanguage("ms_MY");
      // store.setItem('isLangMalay', true);
    } else if (_msMY == false) {
      Locale locale = new Locale("en");
      log("Current: ${Get.locale?.languageCode}");
      Get.updateLocale(locale);
      log("New: ${Get.locale?.languageCode}");
      await api.setLanguage("en");
      // store.setItem('isLangMalay', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          // Positioned(
          //   child: Container(
          //     height: MediaQuery.of(context).size.width / 1.1,
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage("assets/dist/bg_laucher.png"),
          //         fit: BoxFit.fill,
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SvgPicture.asset('assets/dist/Plus.svg',
                            //     height: MediaQuery.of(context).size.width / 8),
                            Container(
                              height: MediaQuery.of(context).size.width / 7,
                              width: MediaQuery.of(context).size.width / 6,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/dist/ipayment_logo.png'),
                                ),
                              ),
                            ),
                            buildSwitch()
                          ],
                        ),
                        SizedBox(height: 120),
                        Center(
                          child: Text(
                              "(iPayment)"
                                  .tr,
                              style: styles.headingTitlebold),
                        ),
                            SizedBox(height: 10),
                        Text(
                            "Federal Government Electronic Payment System"
                                .tr,
                            style: styles.headingSubTitlebold, textAlign: TextAlign.center),
                        SizedBox(height: 50),
                        TextFormField(
                          initialValue: _username,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: styles.inputDecoration.copyWith(
                            labelText: 'E-mel'.tr,
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'This field cannot be left blank'.tr;
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              _username = val;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            navigate(context, ForgotUserIDScreen());
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot User ID?".tr,
                              style: styles.heading6,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'This field cannot be left blank'.tr;
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          focusNode: passwordFocusNode,
                          obscureText: !_isVisible,
                          style: styles.heading5,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: styles.inputDecoration.copyWith(
                            labelText: 'Password'.tr,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              icon: _isVisible
                                  ? Icon(
                                      getIcon('eye'),
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      getIcon('eye-slash'),
                                      color: Colors.grey,
                                    ),
                            ),
                            enabled: true,
                          ),
                          initialValue: _password,
                          onChanged: (val) {
                            setState(() {
                              _password = val;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            navigate(context, ForgotPasswordScreen());
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Forgot Password?".tr,
                              style: styles.heading6,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        PrimaryButton(
                                text: 'Login'.tr,
                                onPressed: _isFormEmpty()
                                    ? null
                                    : () async {                    
                                            isLoading(true);
                                          
                                        if (_formKey.currentState!.validate()) {                      
                                            isLoading(true);                                          
                                          try {
                                            var response = await api.login(
                                                _username, _password);
                                            if (response.isSuccessful) {
                                             
                                              Get.replace(HomeController());

                                              var homeRoute = MaterialPageRoute(
                                                  builder: (_) => MenuScreen());
                                                  
                                                  isLoading(false);
                                              await credentialStore.setItem(
                                                  '_username', _username);

                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(homeRoute,
                                                      (route) => false);

                                              hideSnacks(context);
                                              snack(
                                                  context,
                                                  'Welcome'.tr +
                                                      ' ' +
                                                      state.user.firstName! +
                                                      '!',
                                                  level: SnackLevel.Success);
                                                  isLoading = false.obs;
                                              return;
 
                                            } else {                     
                                              hideSnacks(context);
                                              isLoading(false);
                                              if (response.statusCode == 503) {
                                                navigate(context,
                                                    MaintenanceScreen());
                                              }
                                              Get.snackbar(
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
                                            print(e);
                                            snack(
                                                context,
                                                "There is a problem connecting to the server. Please try again."
                                                    .tr);
                                          }
                                        }  
                                          isLoading(false);
                                      }),
                        SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account?".tr,
                                    style: styles.heading2,
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      navigate(context, RegisterScreen());
                                    },
                                    child: Text("Register".tr,
                                        style: styles.heading6bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Center(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () => navigate(context, LinkUserManualScreen()),
                                  child: Text(
                                    'User Manual'.tr,
                                    style: styles.heading6boldAdmin,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  child: GestureDetector(
                                    onLongPress: () => launchUrl(Uri.parse(
                                        "https://drive.google.com/drive/u/1/folders/1r55aNLulj4thqDrSyJ_J_8EiLjJZ2E-P")),
                                    child: Text(
                                      "Current Version:".tr +
                                          ' ' +
                                          _version +
                                          ' + ' +
                                          _buildNumber,
                                      style: styles.heading14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
