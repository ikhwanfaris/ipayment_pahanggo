import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/contents/bulletin/bulletin.dart';
import 'package:flutterbase/screens/profile/my_profile/faq_pdf_viewer.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/utils/phosphor.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// ignore: must_be_immutable
class HebahanDetailScreen extends StatelessWidget {
  RxList<Bulletin> bulletinList;
  final int? bulletinId; // Accept the Bulletin ID
  HebahanDetailScreen(this.bulletinList, {Key? key, required this.bulletinId})
      : super(key: key);

  DateTime starttime = DateTime.now();
  String endpoint = ENDPOINT;

  @override
  Widget build(BuildContext context) {
    Bulletin? targetBulletin;

    var targetId = bulletinId;

    for (var bulletin in bulletinList) {
      if (bulletin.id == targetId) {
        targetBulletin = bulletin;
        break;
      }
    }
    String content = targetBulletin?.translatables?.first.content ?? "";
    String desc = targetBulletin?.translatables?.last.content ?? "";
    starttime = DateTime.parse(targetBulletin!.createdAt.toString()).toLocal();
    String attachmentUrl = targetBulletin.attachmentUrl.toString();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
            icon: const Icon(
              LineIcons.angleLeft,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right:55),
            child: Text(
              "Announcements".tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            content,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          Container(
            child: Row(
              children: [
                Icon(getIcon('calendar'), size: 15, color: constants.sixColor),
                SizedBox(width: 5),
                Text(
                  DateFormat('dd/MM/yyyy').format(starttime),
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: constants.eightColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          MarkdownBody(
            data: desc,
          ),
          attachmentUrl.toString() != 'null' ? 
          Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Attachment:'.tr, style: styles.heading14sub),
                        IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              navigate(
                                context,
                                FaqPdfViewer(
                                  url: attachmentUrl.toString(),
                                  pageName: "Attachment".tr,
                                ),
                              );
                            })
                      ],
                    ),
                    SizedBox(height: 12),
                    SizedBox(
                        height: 150,
                        child: SfPdfViewer.network(
                    attachmentUrl.toString(),
                  )),
            ],
          ) : Container(),
        ],
      ),
    );
  }
}
