import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterScreen extends StatefulWidget {
  HelpCenterScreen({Key? key}) : super(key: key);

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  bool isChecked = false;

  String phone = '';
  String email = '';
  String webLink = '';
  String fbLink = '';
  String twitterLink = '';
  String youtubeLink = '';
  String enTitle = '';
  String enDesc = '';
  String myTitle = '';
  String myDesc = '';

  void initState() {
    super.initState();
    initApp();
  }

  var myLocaleLang = Get.locale?.languageCode;

  initApp() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    await api.getAboutUs();

    setState(() {
      phone = store.getItem('phoneLS');
      email = store.getItem('emailLS');
      webLink = store.getItem('webLinkLS');
      fbLink = store.getItem('fbLinkLS');
      twitterLink = store.getItem('twitterLinkLS');
      youtubeLink = store.getItem('youtubeLinkLS');
      enTitle= store.getItem('enTitleLS');
      enDesc = store.getItem('enDescLS');
      myTitle = store.getItem('myTitleLS');
      myDesc = store.getItem('myDescLS');
    });

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
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
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 55),
              child: Text(
                "Contact Us".tr,
                style: styles.heading1sub,
              ),
            ),
          ),
        ),
        body: Container(
            child: SafeArea(
                child: ListView(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    children: [
              Text(
                myLocaleLang.toString() == 'en' ? enTitle : myTitle,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 26),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  myLocaleLang.toString() == 'en' ? enDesc : myDesc,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Select one of the channels below and ask your questions:'.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                icon: Image.asset(
                                    'assets/dist/icon_facebook.png'),
                                iconSize:
                                    MediaQuery.of(context).size.height * 0.095,
                                onPressed: () {
                                  launchUrl(Uri.parse(
                                      fbLink));
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, right: 8),
                                child: IconButton(
                                  icon:
                                      Image.asset('assets/dist/icon_twitter.png'),
                                  iconSize:
                                      MediaQuery.of(context).size.height * 0.085,
                                  onPressed: () {
                                    launchUrl(Uri.parse(
                                        twitterLink));
                                  },
                                ),
                              ),
                              IconButton(
                                icon:
                                    Image.asset('assets/dist/icon_youtube.png'),
                                iconSize:
                                    MediaQuery.of(context).size.height * 0.085,
                                onPressed: () {
                                  launchUrl(Uri.parse(
                                      youtubeLink));
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                               IconButton(
                                icon:
                                    Image.asset('assets/dist/ipayment_logo.png'),
                                iconSize:
                                    MediaQuery.of(context).size.height * 0.095,
                                onPressed: () {
                                  launchUrl(Uri.parse(
                                      webLink));
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right:10),
                                child: IconButton(
                                  icon: Image.asset('assets/dist/icon_email.png'),
                                  iconSize:
                                      MediaQuery.of(context).size.height * 0.085,
                                  onPressed: () {
                                    launchUrl(Uri.parse(
                                        'mailto:'+ email + '?subject=News&body=New%20plugin'));
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Image.asset('assets/dist/call_us.png'),
                                iconSize:
                                    MediaQuery.of(context).size.height * 0.075,
                                onPressed: () {
                                  launchUrl(Uri.parse("tel:" + phone));
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                            "4th Floor, Podium Bangunan AICB, No. 10, Jalan Dato' Onn, 50480 Kuala Lumpur"),
                        const SizedBox(height: 20),
                        Image.asset('assets/dist/map.png'),
                      ],
                    ),
                  ),
                ],
              )
            ]))));
  }
}
