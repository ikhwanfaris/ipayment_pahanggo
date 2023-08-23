import 'dart:developer';

import 'package:flutter/scheduler.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/profile/profile_menu.dart';
import 'package:flutterbase/controller/home_controller.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/screens/home/tnc.dart';
import 'package:flutterbase/screens/link_user_manual.dart';
import 'package:flutterbase/screens/profile/my_profile/faq.dart';
import 'package:flutterbase/screens/profile/my_profile/my_account.dart';
import 'package:flutterbase/screens/profile/my_profile/rating.dart';
import 'package:flutterbase/screens/profile/send_enquiry/home_enquiry.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/screens/profile/help_center/help_center.dart';
import 'package:flutterbase/screens/profile/organization/home_organization.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/screens/profile/change_password/change_password.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final _formKey = GlobalKey<FormState>();

bool _isLoading = false;
String _version = '...';
String _buildNumber = '...';

// String _isRated = '';

String ratingDescription = '';
double ratingSubmit = 0.0;
int numStar = 5;
bool _isRequired = true;
String platform = Platform.operatingSystem;

class _ProfileScreenState extends State<ProfileScreen> {
  bool _msMY = true;

  @override
  void initState() {
    super.initState();

    PackageInfo.fromPlatform().then((info) {
      setState(() {
        _version = info.version;
        _buildNumber = info.buildNumber;
      });
    });

    // print(_token);

    // if (_token == 'null') {
    //   Get.snackbar(
    //     "".tr,
    //     "Only one session is allowed per user.".tr,
    //     messageText: Text(
    //       "Only one session is allowed per user.".tr,
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontWeight: FontWeight.w900,
    //         fontSize: 16,
    //       ),
    //     ),
    //     padding: EdgeInsets.only(bottom: 30, left: 16),
    //     backgroundColor: Colors.red,
    //   );

    //   logout(context);
    // }
    _getData();
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

  void _openRatedDialog() async {
    SchedulerBinding.instance.addPostFrameCallback((_) => _getRated());
  }

  void _getData() async {
    await api.getOrganization();
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
  }

  Widget buildTile(Organization organization) => ListTile(
        title: Text(organization.orgName!),
      );

  Widget buildSwitch() => Transform.scale(
        scale: 1.4,
        child: Switch(
          value: _msMY,
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
        child: ValueListenableBuilder(
          valueListenable: state.value.userState,
          builder: (BuildContext context, UserDataState value, Widget? child) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Material(
                        color: constants.primaryColor,
                        shape: MyShapeBorder(-20),
                        child: Container(
                          height: 20,
                        ),
                      ),
                      Positioned(
                        top: 60,
                        left: 0,
                        child: SizedBox(
                          height: AppBar().preferredSize.height,
                          width: MediaQuery.of(context).size.width,
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/dist/user_profile_portal.jpg'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 26, 16, 0),
                    child: Text(
                      value.data.firstName!,
                      style: styles.heading6bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Text(
                      value.data.email!,
                      style: styles.heading2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  buildSwitch(),
                  SizedBox(height: 16),
                  ProfileMenu(
                    text: "Profile".tr,
                    iconName: 'user',
                    press: () async {
                      await navigate(context, MyAccountScreen());
                      setState(() {});
                    },
                  ),
                  ProfileMenu(
                    text: "Change Password".tr,
                    iconName: 'lock-key-open',
                    press: () {
                      navigate(context, ChangePasswordScreen());
                    },
                  ),
                  ProfileMenu(
                    text: "Organization".tr,
                    iconName: 'buildings',
                    press: () {
                      navigate(context, HomeOrganizationScreen());
                    },
                  ),
                  ProfileMenu(
                    text: "Contact Us".tr,
                    iconName: 'headset',
                    press: () {
                      navigate(context, HelpCenterScreen());
                    },
                  ),
                  ProfileMenu(
                    text: "Inquiries".tr,
                    iconName: 'chats',
                    press: () {
                      navigate(context, HomeEnquiryScreen());
                    },
                  ),
                  ProfileMenu(
                    text: "Rating".tr,
                    iconName: 'star',
                    press: () {
                      navigate(context, RatingScreen());
                    },
                  ),
                  ProfileMenu(
                    text: "FAQ".tr,
                    iconName: 'question',
                    press: () {
                      navigate(context, FaqScreen());
                    },
                  ),
                   ProfileMenu(
                    text: "User Manual".tr,
                    iconName: 'book'  ,
                    press: () {
                      navigate(context, LinkUserManualScreen());
                    },
                  ),
                  _isLoading
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: DefaultLoadingBar(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(20),
                          child: PrimaryButton(
                            isLoading: _isLoading,
                            text: "Log Out".tr,
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    await api.enforceLogout(
                                        state.user.id!, platform);
                                    Get.find<HomeController>()
                                        .favoriteServices
                                        .clear();
                                    print('Current rating status: ' +
                                        store
                                            .getItem('getCurrentRatedLS')
                                            .toString());
                                    if (store
                                            .getItem('getCurrentRatedLS')
                                            .toString() ==
                                        'true') {
                                      print(store
                                          .getItem('getCurrentRatedLS')
                                          .toString());
                                      print('ENFORCE RATED');
                                      setState(() {
                                        _openRatedDialog();
                                      });
                                    } else {
                                      print('LogOut');
                                      logout(context);
                                    }

                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                          ),
                        ),
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
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      navigate(context, TncScreen());
                    },
                    child: Text(
                      "Terms and Conditions.".tr,
                      style: styles.heading6boldAdmin,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // isRated Dialog box
  Future _getRated() => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
          return Form(
            key: _formKey,
            child: AlertDialog(
              backgroundColor: constants.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Center(
                child: Column(
                  children: [
                    Text(
                      'Rating System'.tr.toTitleCase(),
                      style: styles.raisedButtonTextWhite,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'How satisfied are you?'.tr,
                      style: styles.heading6boldPaleWhite,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 20),
                    RatingBar.builder(
                      itemSize: 30,
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      // itemCount: numStar,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                        setState(() {
                          ratingSubmit = rating;
                          if (ratingSubmit < numStar) {
                            _isRequired = true;
                            print(_isRequired);
                          } else {
                            _isRequired = false;
                            print(_isRequired);
                          }
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Text(
                      'What would you like for us to improve on?'.tr,
                      style: styles.heading6boldPaleWhite,
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: 40),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          textAlign: TextAlign.justify,
                          autocorrect: false,
                          maxLines: 5,
                          minLines: 2,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(20.0),
                            errorMaxLines: 5,
                            label: _isRequired
                                ? getRequiredLabel(
                                    'Reviews'.tr,
                                  )
                                : Text(
                                    "Reviews".tr,
                                  ),
                          ),
                          validator: (value) {
                            if (ratingSubmit < numStar &&
                                ratingDescription.isEmpty) {
                              return 'This field cannot be left empty if the rating is below'
                                      .tr +
                                  ' ' +
                                  numStar.toString() +
                                  ' ' +
                                  'star'.tr;
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              ratingDescription = val;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                            isLoading: _isLoading,
                            text: 'Send'.tr,
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  _isLoading = true;
                                });

                                try {
                                  var response = await api.submitRating(
                                      state.user.id.toString(),
                                      ratingDescription,
                                      ratingSubmit,
                                      platform);
                                  if (response.isSuccessful) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    Navigator.of(context).pop();
                                    hideSnacks(context);
                                    snack(context,
                                        "Rating successfully saved.".tr,
                                        level: SnackLevel.Success);
                                    logout(context);
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
                                    padding:
                                        EdgeInsets.only(bottom: 30, left: 16),
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
                const SizedBox(height: 10),
              ],
            ),
          );
        }),
      );
}
