import 'dart:io';

import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/models/enquiry/file_setting_enquiry.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/helpers.dart';

class RatingScreen extends StatefulWidget {
  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  // ignore: unused_field
  Map<dynamic, dynamic> _rateSetting = {};
  List<FileSettingEnquiry> fileSetting = [];
  bool varAllowMultiple = true;
  // ignore: unused_field
  List _enquiryModel = [
    {
      "id": "1",
      "dateTime": "2022-10-26 22:05:33",
      "noTicket": "P000000002",
      "titleEnquiry": "Resit tidak terima dalam email",
      "catEnquiry": "Tiada",
      "statusEnquiry": "Baharu"
    },
    {
      "id": "2",
      "dateTime": "2022-10-27 22:05:33",
      "noTicket": "P000000003",
      "titleEnquiry": "Resit tidak keluar dalam email",
      "catEnquiry": "Tiada",
      "statusEnquiry": "Baharu"
    },
    {
      "id": "3",
      "dateTime": "2022-10-28 22:05:33",
      "noTicket": "P000000004",
      "titleEnquiry": "Resit tidak ketepi dalam email",
      "catEnquiry": "Tiada",
      "statusEnquiry": "Baharu"
    },
    {
      "id": "4",
      "dateTime": "2022-10-29 22:05:33",
      "noTicket": "P000000005",
      "titleEnquiry": "Resit tidak ketengah dalam email",
      "catEnquiry": "Tiada",
      "statusEnquiry": "Baharu"
    }
  ];
  String enquiryTitle = '';
  String ratingDescription = '';
  String enquiryNumber = '';
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  List<File> files = [];
  late String fileType = "";
  List<String> extensionFile = [];
  double ratingSubmit = 0.0;
  int numStar = 5;
  bool _isRequired = true;
  String platform = Platform.operatingSystem;

  @override
  void initState() {
    super.initState();
    initApp();

    print(platform);
  }

  initApp() async {
    _getData();
  }

  // bool _isFormEmpty() {
  //   if (ratingDescription.isEmpty) {
  //     return true;
  //   }

  //   return false;
  // }

  void _getData() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _rateSetting = await api.getRatingSetting();
    setState(() {
      _rateSetting = _rateSetting;
    });

    setState(() {
      numStar = _rateSetting['number_of_star'];
    });
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            LineIcons.angleLeft,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 55),
          child: Center(
            child: Text(
              'Rating'.tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ), //AppB
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Please rate your experience with this application.'.tr),
                SizedBox(height: 20),
                RatingBar.builder(
                  initialRating: 5,
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
                      } else {
                        _isRequired = false;
                      }
                    });
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.justify,
                  autocorrect: false,
                  maxLines: 5,
                  decoration: styles.inputDecoration.copyWith(
                    contentPadding: EdgeInsets.all(16),
                    alignLabelWithHint: true,
                    errorMaxLines: 5,
                    label: _isRequired
                        ? getRequiredLabel(
                            'Comments/Suggestions for Improvement'.tr)
                        : Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                                "Comments/Suggestions for Improvement".tr)),
                  ),
                  validator: (value) {
                    if (ratingSubmit < numStar && ratingDescription.isEmpty) {
                      return 'This field is mandatory if the rating is below'
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
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: _isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: DefaultLoadingBar(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
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
                          snack(context, "Rating successfully saved.".tr,
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
                          padding: EdgeInsets.only(bottom: 30, left: 16),
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
                  },
                ),
              ),
      ),
    );
  }
}
