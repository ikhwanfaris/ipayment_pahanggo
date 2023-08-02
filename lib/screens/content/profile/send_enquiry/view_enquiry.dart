import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/chat/message.dart';
import 'package:flutterbase/models/enquiry/file_setting_enquiry.dart';
import 'package:flutterbase/models/enquiry/list_enquiry.dart';
import 'package:flutterbase/screens/content/profile/my_profile/faq_pdf_viewer.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:photo_view/photo_view.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;

class ViewEnquiryScreen extends StatefulWidget {
  final enquiry;
  const ViewEnquiryScreen(this.enquiry, {Key? key}) : super(key: key);

  @override
  State<ViewEnquiryScreen> createState() => _ViewEnquiryScreenState();
}

class _ViewEnquiryScreenState extends State<ViewEnquiryScreen> {
  String enquiryChatId = store.getItem('GetEnquiryChatId').toString();

  List<FileSettingEnquiry> _fileSettingModel = [];
  bool varAllowMultiple = false;
  bool gotFile = false;
  List<File> files = [];
  late String fileType = "";
  List<String> extensionFile = [];
  List<dynamic> _fileFormatList = [];
  List<dynamic> _imageFormatList = [];

  String endpoint = ENDPOINT;

  String extension = '';
  late var enquiryMap;
  List<Enquiry> _enquiryModel2 = [];
  List<ChatMessage> messages = [];
  TextEditingController input = TextEditingController();

  int? orgId;
  String? remarks;
  int? userId;
  bool _enquiryStatus = false;
  String enquiryStatusReplace = '';

  bool _doneOrVoid = false;

  // ignore: unused_field
  bool _isLoading = false;

  DateTime starttime = DateTime.now();

  int? fileSize;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    setState(() {
      enquiryMap = widget.enquiry;
      userId = state.user.id;
    });
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

    _enquiryModel2 = await api.getEnquiryDetails(enquiryMap.id.toString());
    await store.setItem('GetEnquiryChatId', enquiryMap.id);
    setState(() {
      _enquiryModel2 = _enquiryModel2;

      starttime = DateTime.parse(enquiryMap.created_at.toString()).toLocal();

      if (enquiryMap.status.toString() == 'Pertanyaan baharu') {
        _enquiryStatus = true;
        enquiryStatusReplace = 'Pertanyaan baharu';
        _doneOrVoid = true;
      } else if (enquiryMap.status.toString() == 'Dalam semakan PTJ' ||
          enquiryMap.status.toString() == 'Dalam semakan JANM') {
        enquiryStatusReplace = 'Dalam proses';
        _doneOrVoid = true;
      } else if (enquiryMap.status.toString() ==
          'Menunggu pengesahan pelanggan') {
        enquiryStatusReplace = 'Menunggu pengesahan pelanggan';
        _doneOrVoid = true;
      } else if (enquiryMap.status.toString() == 'Batal') {
        enquiryStatusReplace = 'Batal';
        _doneOrVoid = false;
      } else if (enquiryMap.status.toString() == 'Selesai tanpa maklum balas' ||
          enquiryMap.status.toString() == 'Selesai dengan pengesahan') {
        enquiryStatusReplace = 'Selesai';
        _doneOrVoid = false;
      }
    });

    String fileName = enquiryMap.file.toString();
    extension = path.extension(fileName);
    print(extension); // Output: ".jpg"

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

          fileSize = _fileSettingModel[0].file_size;

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
              'Enquiry Detail'.tr,
              style: styles.heading1sub,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: _doneOrVoid,
                child: Column(
                  children: [
                    Visibility(
                      visible: _enquiryStatus,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Divider(
                                  color: constants.primaryColor,
                                  thickness: 5,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(LineIcons.timesCircleAlt),
                                      SizedBox(width: 2),
                                      Text("Cancel".tr)
                                    ],
                                  ),
                                  onPressed: () async {
                                    var a = await cancelConfirmation(
                                      context,
                                      [
                                        Column(
                                          children: [
                                            RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: 'Cancel enquiry'.tr +
                                                        ' ' +
                                                        enquiryMap.ticket_number
                                                            .toString() +
                                                        '?',
                                                    style: TextStyle(
                                                      color: constants
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                      ],
                                      hasActions: true,
                                      hasClose: false,
                                    );
                                    if (a == 'yes') {
                                      try {
                                        var response = await api.voidEnquiry(
                                            enquiryMap.id, userId!);
                                        if (response.isSuccessful) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          Navigator.of(context).pop(true);
                                          hideSnacks(context);
                                          snack(context,
                                              "Query canceled successfully".tr,
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
                                          padding: EdgeInsets.only(
                                              bottom: 30, left: 16),
                                          backgroundColor: Colors.red,
                                        );
                                      } catch (e) {
                                        snack(
                                            context,
                                            "There is a problem connecting to the server. Please try again."
                                                .tr);
                                      }
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_enquiryStatus,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                child: Divider(
                                  color: constants.primaryColor,
                                  thickness: 5,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: constants.thirdColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(LineIcons.timesCircleAlt),
                                      SizedBox(width: 2),
                                      Text("Complete".tr)
                                    ],
                                  ),
                                  onPressed: () async {
                                    var a = await confirmation(
                                      context,
                                      [
                                        Column(
                                          children: [
                                            RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                style: const TextStyle(
                                                  fontSize: 16.0,
                                                  color: Colors.black,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        'Do you really want to close this inquiry?'
                                                            .tr,
                                                    style: TextStyle(
                                                      color: constants
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          textInputAction: TextInputAction.next,
                                          autofocus: true,
                                          decoration:
                                              styles.inputDecoration.copyWith(
                                            label: Text('Notes'.tr),
                                            hintText: 'Notes'.tr,
                                          ),
                                          onChanged: (val) {
                                            setState(() {
                                              remarks = val;
                                            });
                                          },
                                        ),
                                      ],
                                      title: 'Ticket Complete'.tr,
                                      hasActions: true,
                                      hasClose: true,
                                    );
                                    if (a == 'yes') {
                                      try {
                                        var response =
                                            await api.completeEnquiry(
                                                enquiryMap.id, remarks);
                                        if (response.isSuccessful) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          Navigator.of(context).pop(true);
                                          hideSnacks(context);
                                          snack(
                                              context,
                                              "The enquiry has been completed."
                                                  .tr,
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
                                          padding: EdgeInsets.only(
                                              bottom: 30, left: 16),
                                          backgroundColor: Colors.red,
                                        );
                                      } catch (e) {
                                        snack(
                                            context,
                                            "There is a problem connecting to the server. Please try again."
                                                .tr);
                                      }
                                    }
                                  },
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
              Card(
                color: Color(0xffF1F3F6),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Date & Time".tr, style: styles.heading14sub),
                          Text(
                            DateFormat('dd/MM/yyyy, hh:mm a').format(starttime),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Receipt Reference No.'.tr,
                              style: styles.heading14sub),
                          Text(
                            enquiryMap.reference_number.toString() == 'null'
                                ? '-'
                                : enquiryMap.reference_number.toString(),
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Ticket No.'.tr, style: styles.heading14sub),
                          Text(
                            enquiryMap.ticket_number.toString(),
                            textAlign: TextAlign.right,
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              flex: 1,
                              child:
                                  Text("Status", style: styles.heading14sub)),
                          Expanded(
                            flex: 2,
                            child: Text(
                              enquiryStatusReplace,
                              style: styles.heading5bold,
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  color: Color(0xffF1F3F6),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Enquiry Title'.tr, style: styles.heading14sub),
                        SizedBox(height: 5),
                        Text(enquiryMap.title.toString()),
                        SizedBox(height: 16),
                        Text('Enquiry Description'.tr,
                            style: styles.heading14sub),
                        SizedBox(height: 5),
                        Markdown(
                          padding: EdgeInsets.only(top: 5),
                          shrinkWrap: true,
                          data: enquiryMap.description.toString(),
                        ),
                        SizedBox(
                            height: enquiryMap.file.toString() != 'null' &&
                                    extension == '.pdf'
                                ? 0
                                : 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Supporting Document'.tr,
                                style: styles.heading14sub),
                            Visibility(
                              visible: enquiryMap.file.toString() != 'null' &&
                                      extension == '.pdf'
                                  ? true
                                  : false,
                              child: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.black,
                                  ),
                                  onPressed: () async {
                                    navigate(
                                      context,
                                      FaqPdfViewer(
                                        url: endpoint +
                                            '/file/' +
                                            enquiryMap.file.toString(),
                                        pageName: "Attachment".tr,
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: (() => enquiryMap.file.toString() != 'null'
                              ? launchUrl(Uri.parse(endpoint +
                                  '/file/' +
                                  enquiryMap.file.toString()))
                              : null),
                          child: enquiryMap.file.toString() != 'null' &&
                                      extension == '.gif' ||
                                  extension == '.jpg' ||
                                  extension == '.jpeg' ||
                                  extension == '.png'
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: PhotoView(
                                      imageProvider: NetworkImage(endpoint +
                                          '/file/' +
                                          enquiryMap.file.toString()),
                                    ),
                                  ),
                                )
                              : enquiryMap.file.toString() != 'null' &&
                                      extension == '.pdf'
                                  ? Container(
                                      child: Column(
                                        children: [
                                          SizedBox(height: 5),
                                          SizedBox(
                                            height:
                                                enquiryMap.file.toString() !=
                                                        'null'
                                                    ? 150
                                                    : 5,
                                            child: enquiryMap.file.toString() !=
                                                    'null'
                                                ? SfPdfViewer.network(
                                                    endpoint +
                                                        '/file/' +
                                                        enquiryMap.file
                                                            .toString(),
                                                  )
                                                : Container(),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      child: Text('-'),
                                    ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                        'Reply'.tr + ' (' + messages.length.toString() + ') :',
                        style: styles.headingTitlebold)),
              ),
              // Submit replay
              Visibility(
                visible: _doneOrVoid,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
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
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: TextFormField(
                                  autocorrect: false,
                                  controller: input,
                                  decoration: styles.inputDecoration.copyWith(
                                    hintText: "Add reply".tr,
                                    hintStyle: TextStyle(color: Colors.black54),
                                  ),
                                ),
                              ),
                            ),
                            FloatingActionButton(
                              heroTag: "btn1",
                              onPressed: selectFile,
                              child: Icon(
                                Icons.attach_file,
                                color: constants.sixColor,
                                size: 25,
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
                                    padding:
                                        EdgeInsets.only(bottom: 30, left: 16),
                                    backgroundColor: Colors.red,
                                  );
                                }
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 25,
                              ),
                              backgroundColor: constants.sixColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // List reply messages
              Container(
                color: Constants().sevenColor,
                child: ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final starttime =
                        DateTime.parse(messages[index].created_at.toString())
                            .toLocal();
                    return Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 20, bottom: 20),
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
            ],
          ),
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

    var extensionFileFormatter = extensionFile
        .toString()
        .replaceAll("{", "")
        .replaceAll("[", "")
        .replaceAll("]", "")
        .replaceAll("}", "");

    if (result != null) {
      num totalByte = 0;
      for (var i = 0; i < result.files.length; i++) {
        totalByte += result.files[i].size;
      }
      if (totalByte > fileSize! * 1000000) {

        Get.snackbar(
          snackPosition: SnackPosition.TOP,
          "".tr,
          'Please select a file format '.tr +
              extensionFileFormatter.toString() +
              ' and the size does not exceed '.tr +
              fileSize.toString() +
              ' MB.',
          messageText: Text(
            'Please select a file format '.tr +
                extensionFileFormatter.toString() +
                ' and the size does not exceed '.tr +
                fileSize.toString() +
                ' MB.',
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
