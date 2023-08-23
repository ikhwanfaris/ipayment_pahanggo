import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/phosphor.dart';
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
  String lat = '';
  String long = '';
  int numericId = 0;

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
      fbLink = store.getItem('fbLinkLS').toString();
      twitterLink = store.getItem('twitterLinkLS').toString();
      youtubeLink = store.getItem('youtubeLinkLS').toString();
      enTitle = store.getItem('enTitleLS');
      enDesc = store.getItem('enDescLS');
      myTitle = store.getItem('myTitleLS');
      myDesc = store.getItem('myDescLS');
      lat = store.getItem('latLS').toString();
      long = store.getItem('longLS').toString();
    });

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          numericId = extractNumericId(fbLink);
          Navigator.pop(context);
        }));
  }

  int extractNumericId(String facebookUrl) {
    Uri uri = Uri.parse(facebookUrl);
    String query = uri.query;
    Map<String, String> queryParameters = Uri.splitQueryString(query);

    String? idParam = queryParameters['id'];

    if (idParam != null) {
      return int.tryParse(idParam) ?? 0;
    }

    return 0; 
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
              myLocaleLang.toString() == 'en' ? enTitle : myTitle,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: Container(
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: 12),
              Markdown(
                shrinkWrap: true,
                softLineBreak: true,
                data: myLocaleLang.toString() == 'en' ? enDesc : myDesc,
              ),
              SizedBox(height: 12),
              Text(
                'Contact Us'.tr,
                style:const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text('Please contact us using the information below. Locate us using map below.'.tr,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
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
                                icon: Icon(getIcon('device-mobile')),
                                iconSize:
                                    MediaQuery.of(context).size.height * 0.095,
                                onPressed: () {
                                  launchUrl(Uri.parse("tel:" + phone));
                                },
                              ),
                              IconButton(
                                icon: Icon(getIcon('envelope-open')),
                                iconSize:
                                    MediaQuery.of(context).size.height * 0.095,
                                onPressed: () {
                                  launchUrl(Uri.parse('mailto:' +
                                      email +
                                      '?subject=News&body=New%20plugin'));
                                },
                              ),
                              IconButton(
                                icon: Icon(getIcon('browser')),
                                iconSize:
                                    MediaQuery.of(context).size.height * 0.095,
                                onPressed: () {
                                  launchUrl(Uri.parse(webLink));
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              fbLink == 'null'
                                  ? Container()
                                  : IconButton(
                                      icon: Icon(getIcon('facebook-logo')),
                                      iconSize:
                                          MediaQuery.of(context).size.height *
                                              0.095,
                                      onPressed: () {
                                        launchUrl(Uri.parse('fb://profile/$numericId'));
                                      },
                                    ),
                              twitterLink == 'null'
                                  ? Container()
                                  : IconButton(
                                      icon: Icon(getIcon('twitter-logo')),
                                      iconSize:
                                          MediaQuery.of(context).size.height *
                                              0.095,
                                      onPressed: () {
                                        launchUrl(Uri.parse(twitterLink));
                                      },
                                    ),
                              youtubeLink == 'null'
                                  ? Container()
                                  : IconButton(
                                      icon: Icon(getIcon('youtube-logo')),
                                      iconSize:
                                          MediaQuery.of(context).size.height *
                                              0.095,
                                      onPressed: () {
                                        launchUrl(Uri.parse(youtubeLink));
                                      },
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Text(
                            "Kompleks Kementerian Kewangan, Presint 2, 62592 Putrajaya, Wilayah Persekutuan Putrajaya, MY."),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Ink.image(
                                  image: AssetImage('assets/dist/map.png'),
                                  fit: BoxFit.cover,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: InkWell(
                                    onTap: () {
                                      launchUrl(Uri.parse(
                                          'https://www.google.com/maps/search/?api=1&query=$lat,$long'));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
