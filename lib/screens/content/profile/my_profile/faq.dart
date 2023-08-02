import 'package:flutter/scheduler.dart';

import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/rating/faq.dart';
import 'package:flutterbase/screens/content/profile/my_profile/faq_pdf_viewer.dart';

import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class FaqScreen extends StatefulWidget {
  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<Faq> _enquiryModel2 = [];
  String endpoint = ENDPOINT;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _enquiryModel2 = await api.getFAQ();

    setState(() {
      _enquiryModel2 = _enquiryModel2;
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
              'FAQ'.tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ), //AppB
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                height: 100,
                width: 100,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/dist/ipayment_logo.png'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                  reverse: true,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _enquiryModel2.length,
                  itemBuilder: (context, index) {
                 
                    return ExpansionTile(
                      title: Text(
                          _enquiryModel2[index].faq_category!.title.toString()),
                      children: <Widget>[
                        ListTile(
                          title: Text(
                              _enquiryModel2[index].question!.msMy.toString(),
                              style: styles.heading14sub),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    _enquiryModel2[index]
                                        .answer!
                                        .msMy
                                        .toString(),
                                    style: styles.heading5bold),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        _enquiryModel2[index].attachment.toString() != 'null' 
                                        ?                        
                                        Row(
                                          children: [
                                            Text('Attachment'.tr,
                                                style: styles.heading14sub),
                                            IconButton(
                                                icon: Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () async {
                                                  navigate(
                                                    context,
                                                    FaqPdfViewer(
                                                      url: endpoint +
                                                          '/storage/' +
                                                          _enquiryModel2[index]
                                                              .attachment
                                                              .toString(),
                                                      pageName: "Attachment".tr,
                                                    ),
                                                  );
                                                }),
                                          ],
                                        )
                                        :   Text('Attachment'.tr,
                                                style: styles.heading14sub),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    SizedBox(
                                      height:  _enquiryModel2[index].attachment.toString() != 'null' ? 150 : 5,
                                      child: 
                                        _enquiryModel2[index].attachment.toString() != 'null' ?
                                          SfPdfViewer.network(
                                             endpoint +
                                                          '/storage/' +
                                                          _enquiryModel2[index]
                                                              .attachment
                                                              .toString(),
                                          )
                                      : Container(),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Links'.tr,
                                        style: styles.heading14sub),
                                    SizedBox(height: 5),
                                    InkWell(
                                      onTap: (() => _enquiryModel2[index]
                                                  .link
                                                  .toString() !=
                                              'null'
                                          ? launchUrl(Uri.parse(
                                              _enquiryModel2[index]
                                                  .link
                                                  .toString()))
                                          : null),
                                      child: Text(
                                        _enquiryModel2[index].link.toString() ==
                                                'null'
                                            ? '-'
                                            : 'Links'.tr,
                                        style: styles.heading6boldAdmin,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
