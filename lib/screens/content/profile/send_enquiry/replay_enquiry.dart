import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/chat/message.dart';
import 'package:flutterbase/models/enquiry/file_setting_enquiry.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ReplayEnquiryScreen extends StatefulWidget {
  const ReplayEnquiryScreen({Key? key});

  @override
  State<ReplayEnquiryScreen> createState() => _ReplayEnquiryScreenState();
}

class _ReplayEnquiryScreenState extends State<ReplayEnquiryScreen> {
  List<ChatMessage> messages = [];
  TextEditingController input = TextEditingController();
  String enquiryChatId = store.getItem('GetEnquiryChatId').toString();
  // ignore: unused_field
  bool _isLoading = false;

  List<FileSettingEnquiry> _fileSettingModel = [];
  bool varAllowMultiple = false;
  bool gotFile = false;
  List<File> files = [];
  late String fileType = "";
  List<String> extensionFile = [];
  List<dynamic> _fileFormatList = [];
  List<dynamic> _imageFormatList = [];

  String endpoint = ENDPOINT;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    _getData();
  }

  void _getData() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));

    messages = await api.getChatEnquiry(enquiryChatId);
    _fileSettingModel = await api.getFileSettingEnquiry();

    setState(() {
      messages = messages;
    });

    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {
          _fileSettingModel.map((item) {
            _fileFormatList.add(item.file_format);
            _imageFormatList.add(item.image_format);
          }).toList();

          var newList = [
            _fileFormatList,
            _imageFormatList,
          ].expand((x) => x).toList();

          var newListFormatter = newList
              .toString()
              .replaceAll(new RegExp(r"\p{P}", unicode: true), "");

          String s = newListFormatter.toString();
          List<String> list = s.split(" ");

          extensionFile = list;

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
            onPressed: () => Navigator.of(context).pop(true)),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              'Reply'.tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final starttime =
                        DateTime.parse(messages[index].created_at.toString())
                            .toLocal();
                    return Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages[index].id == state.user.id
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].user_id == state.user.id
                                ? Color.fromRGBO(227, 239, 232, 1)
                                : Colors.grey.shade200),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Align(
                                  alignment:
                                      messages[index].user_id == state.user.id
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                  child: Text(
                                    DateFormat('dd/MM/yyyy, hh:mm a')
                                        .format(starttime),
                                    style: styles.heading14sub,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Align(
                                  alignment:
                                      messages[index].user_id == state.user.id
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  child: Text(
                                    messages[index].user!.first_name! +
                                        ' ' +
                                        messages[index].user!.last_name!,
                                    style:
                                        messages[index].user_id == state.user.id
                                            ? styles.heading5bold
                                            : styles.heading6boldYellow,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Align(
                                  alignment:
                                      messages[index].user_id == state.user.id
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  child: Text(
                                    messages[index].remark!,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                Align(
                                  alignment:
                                      messages[index].user_id == state.user.id
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                ),
                                SizedBox(height: 5),
                                Align(
                                  alignment:
                                      messages[index].user_id == state.user.id
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: (() => messages[index]
                                                .file
                                                .toString() !=
                                            'null'
                                        ? launchUrl(Uri.parse(endpoint +
                                            '/file/' +
                                            messages[index].file.toString()))
                                        : null),
                                    child: Text(
                                      messages[index].file.toString() == 'null'
                                          ? '-'
                                          : 'Supporting Document'.tr,
                                      style: styles.heading6bold,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment:
                                      messages[index].user_id == state.user.id
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
              child: Container(
                child: Column(
                  children: [
                    files.length > 0
                        ? ListView.builder(
                            itemCount: files.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Card(
                                color: Color(0xFFF5F6F9),
                                child: ListTile(
                                  title: Text(
                                    files[index]
                                        .path
                                        .split('/')
                                        .last
                                        .toString()
                                        .toTitleCase(),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.redAccent),
                                    onPressed: () {
                                      setState(() {
                                        files.removeAt(index);
                                      });
                                    },
                                  ),
                                ),
                              );
                            })
                        : Container(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autocorrect: false,
                              controller: input,
                              decoration: InputDecoration(
                                  hintText: "Add reply".tr,
                                  hintStyle: TextStyle(color: Colors.black54),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          heroTag: "btn1",
                          onPressed: selectFile,
                          child: Icon(
                            Icons.attach_file,
                            color: constants.sixColor,
                            size: 30,
                          ),
                          backgroundColor: Colors.white,
                        ),
                        SizedBox(width: 5),
                        FloatingActionButton(
                          onPressed: () async {
                            if (input.text != "") {
                              var response = await api.submitChat(
                                enquiryChatId,
                                state.user.id.toString(),
                                input.text,
                                files,
                              );
                              if (response.isSuccessful) {
                                setState(() {
                                  _isLoading = false;
                                  snack(
                                      context,
                                      'Your reply has been successfully sent'
                                          .tr,
                                      level: SnackLevel.Success);
                                });
                              }
                              input.clear();
                              initApp();
                            } else {
                              Get.snackbar(
                                snackPosition: SnackPosition.TOP,
                                "".tr,
                                "This field cannot be left blank.".tr,
                                messageText: Text(
                                  "This field cannot be left blank.".tr,
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
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                          backgroundColor: constants.sixColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: varAllowMultiple,
      type: FileType.custom,
      allowedExtensions: extensionFile,
    );
    if (result != null) {
      num totalByte = 0;
      for (var i = 0; i < result.files.length; i++) {
        totalByte += result.files[i].size;
      }
      if (totalByte > 2000000) {
        Get.snackbar(
          snackPosition: SnackPosition.TOP,
          "".tr,
          "File size exceeded sistem setting.".tr,
          messageText: Text(
            "File size exceeded sistem setting.".tr,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
          padding: EdgeInsets.only(bottom: 30, left: 16),
          backgroundColor: Colors.red,
        );
      } else {
        setState(() {
          files = result.paths.map((path) => File(path!)).toList();
          gotFile = true;
        });

        for (var i = 0; i < files.length; i++) {}
      }
    } else {
      // User canceled the picker
    }
  }
}
