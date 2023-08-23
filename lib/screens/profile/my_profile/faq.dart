import 'package:flutter/scheduler.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/field/search_input.dart';
import 'package:flutterbase/models/rating/faq.dart';
import 'package:flutterbase/screens/profile/my_profile/faq_pdf_viewer.dart';

import 'package:flutterbase/utils/constants.dart';
// import 'package:flutterbase/utils/phosphor.dart';
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

  bool _isLangEn = false;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  var myLocaleLang = Get.locale?.languageCode;

  initApp() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    _enquiryModel2 = await api.getFAQ();

    setState(() {
      _enquiryModel2 = _enquiryModel2;

      if (myLocaleLang.toString() == 'en') {
        _isLangEn = true;
      }
    });

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  // Handel invalid url
  Future<void> _launchUrl(Uri _url) async {
    if (await canLaunchUrl(_url)) {
      await launchUrl(_url);
    } else {
      Get.snackbar(
        "".tr,
        "Please enter a valid links.".tr,
        messageText: Text(
          "Please enter a valid links.".tr,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
        ),
        padding: EdgeInsets.only(bottom: 30, left: 16),
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Set<int?> _displayedCategories = Set<int?>();

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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SearchInput(
              backgroundColor: Colors.transparent,
              onTap: () {},
              onChanged: (value) {
                setState(() {
                            if (value.isEmpty) {
                              initApp();
                            } else {
                              _enquiryModel2 = _enquiryModel2.where((item) {
                                return _isLangEn
                                    // English
                                    ? item.faq_category!.translatables!.last
                                            .content!
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        item.question!.en
                                            .toString()
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        item.answer!.en
                                            .toString()
                                            .toLowerCase()
                                            .contains(value.toLowerCase())
                                    // Malay
                                    : item.faq_category!.translatables!.first
                                            .content!
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        item.question!.msMy
                                            .toString()
                                            .toLowerCase()
                                            .contains(value.toLowerCase()) ||
                                        item.answer!.msMy
                                            .toString()
                                            .toLowerCase()
                                            .contains(value.toLowerCase());
                              }).toList();
                            }
                          });
              },
            ),
            _enquiryModel2.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          SvgPicture.asset('assets/dist/aduan.svg',
                              height: MediaQuery.of(context).size.width / 3),
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: Text(
                              'No record found.'.tr,
                              style: styles.heading5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _enquiryModel2.length,
                    itemBuilder: (context, index) {
                      int? currentCategoryId =
                          _enquiryModel2[index].faq_category_id;

                      // Check if this faq_category_id has already been displayed
                      if (_displayedCategories.contains(currentCategoryId)) {
                        // Return an empty Container if it has been displayed
                        return Container();
                      } else {
                        // Add the faq_category_id to the Set to mark it as displayed
                        _displayedCategories.add(currentCategoryId);
                      }

                      // Group the items based on faq_category_id
                      var groupedItems = _enquiryModel2.where(
                          (item) => item.faq_category_id == currentCategoryId);

                      List<Widget> listTiles = groupedItems.map((item) {
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: ExpansionTile(
                            textColor: constants.sevenColor,
                            collapsedBackgroundColor:
                                constants.reverseWhiteColor,
                            backgroundColor: constants.reverseWhiteColor,
                            title: ListTile(
                              title: Text(
                                  _isLangEn
                                      ? item.question!.en.toString()
                                      : item.question!.msMy.toString(),
                                  style: styles.heading10boldPrimary),
                            ),
                            children: [
                              Container(
                                color: Colors.white,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Markdown(
                                      padding:
                                          EdgeInsets.only(left: 33, top: 20),
                                      shrinkWrap: true,
                                      data: _isLangEn
                                          ? item.answer!.en.toString()
                                          : item.answer!.msMy.toString(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 33, top: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          _enquiryModel2[index]
                                                      .attachment
                                                      .toString() !=
                                                  'null'
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text('Attachment:'.tr,
                                                        style: styles
                                                            .heading14sub),
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
                                                                  _enquiryModel2[
                                                                          index]
                                                                      .attachment
                                                                      .toString(),
                                                              pageName:
                                                                  "Attachment"
                                                                      .tr,
                                                            ),
                                                          );
                                                        })
                                                  ],
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: Text('Attachment:'.tr,
                                                      style:
                                                          styles.heading14sub),
                                                ),
                                          SizedBox(
                                              height: _enquiryModel2[index]
                                                          .attachment
                                                          .toString() !=
                                                      'null'
                                                  ? 150
                                                  : 15,
                                              child: _enquiryModel2[index]
                                                          .attachment
                                                          .toString() !=
                                                      'null'
                                                  ? SfPdfViewer.network(
                                                      endpoint +
                                                          '/storage/' +
                                                          _enquiryModel2[index]
                                                              .attachment
                                                              .toString(),
                                                    )
                                                  : Text('-',
                                                      style: styles
                                                          .heading6boldunderline)),
                                          SizedBox(height: 20),
                                          Text('Links:'.tr,
                                              style: styles.heading14sub),
                                          SizedBox(height: 5),
                                          InkWell(
                                            onTap: (() => _enquiryModel2[index]
                                                        .link
                                                        .toString() !=
                                                    'null'
                                                ? _launchUrl(Uri.parse(
                                                    _enquiryModel2[index]
                                                        .link
                                                        .toString()))
                                                : null),
                                            child: Text(
                                              _enquiryModel2[index].link.toString() == 'null'
                                                  ? '-'
                                                  : 'Links'.tr,
                                              style: _enquiryModel2[index].link.toString() == 'null'
                                                  ? styles.heading6bold
                                                  : styles.heading6boldunderline,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList();
                      // Return the ExpansionTile widget with the grouped ListTiles

                      return Padding(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                          child: Container(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {},
                                child: Theme(
                                  data: ThemeData(
                                    dividerColor: Colors.transparent,
                                  ),
                                  child: ExpansionTile(
                                    textColor: constants.sevenColor,
                                    collapsedBackgroundColor:
                                        constants.reverseWhiteColor,
                                    backgroundColor:
                                        constants.filterTicketColor,
                                    title: _isLangEn
                                        ? Text(
                                            _enquiryModel2[index]
                                                    .faq_category
                                                    ?.translatables
                                                    ?.first
                                                    .content ??
                                                '',
                                          )
                                        : Text(
                                            _enquiryModel2[index]
                                                    .faq_category
                                                    ?.translatables
                                                    ?.last
                                                    .content ??
                                                '',
                                          ),
                                    children: listTiles,
                                  ),
                                ),
                              ),
                            ),
                          ));
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
