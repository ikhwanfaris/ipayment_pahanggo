import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/screens/content/history/pdf_viewer.dart';
import 'package:flutterbase/screens/content/history/placeholder_history_detail.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:internet_file/storage_io.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:date_format/date_format.dart';
import 'package:get/get.dart';

import '../../../states/app_state.dart';

class PlaceholderHistoryScreen extends StatefulWidget {
  const PlaceholderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PlaceholderHistoryScreen> createState() =>
      PlaceholderHistoryScreenState();
}

class PlaceholderHistoryScreenState extends State<PlaceholderHistoryScreen> {
  String search = "";
  String dateFrom = "";
  String dateTo = "";
  String xls = "";
  String pdf = "";
  String xlsDoc = "";
  String pdfDoc = "";
  bool isSearching = false;
  bool isSearching2 = false;
  TextEditingController textString = TextEditingController();
  TextEditingController textString2 = TextEditingController();
  List<History> _enquiryModel0 = [];
  List<HistoryItem> _enquiryModel1 = [];
  List<HistoryItem> _enquiryModel2 = [];
  List<HistoryItem> _enquiryModel3 = [];
  // ignore: unused_field
  List<History> _enquiryModel4 = [];
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  TextEditingController dateInput = TextEditingController();
  TextEditingController dateInput2 = TextEditingController();
  final storageIO = InternetFileStorageIO();
  int firstDate = 0;
  DateTime set = DateTime.now();
  List<String> list = <String>[
    "By Transaction",
    'Self Payment',
    'Payment by Third Party',
    'Payment for Third Party',
  ];

  String dropdownValue = "";
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    if (search == "") {
      SchedulerBinding.instance
          .addPostFrameCallback((_) => showLoadingBar(context));
    }
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));

    setState(() {
      dropdownValue = list.first;
    });
    if (dateTo == "") {
      String formattedDate2 = dateFormatter2.format(DateTime.now());
      setState(() {
        dateTo = formattedDate2;
      });
    }
    _enquiryModel0 = await api.GetPaymetHistory2(
      search,
      xls,
      pdf,
      dateFrom,
      dateTo,
    );
    print(_enquiryModel0.length.toString());
    _enquiryModel1 =
        await api.GetPaymetHistory(search, xls, pdf, dateFrom, dateTo, "1");
    print(_enquiryModel1.length.toString());
    _enquiryModel2 =
        await api.GetPaymetHistory(search, xls, pdf, dateFrom, dateTo, "2");
    print(_enquiryModel2.length.toString());
    _enquiryModel3 =
        await api.GetPaymetHistory(search, xls, pdf, dateFrom, dateTo, "3");
    print(_enquiryModel3.length.toString());
    setState(() {
      _enquiryModel1 = _enquiryModel1;
      _enquiryModel2 = _enquiryModel2;
      _enquiryModel3 = _enquiryModel3;
    });
    if (pdf == "" || xls == "") {}

    if (search != "") {
      setState(() {
        isSearching = true;
      });
    }
    if (search == "") {
      Future.delayed(const Duration(seconds: 0)).then(
        (value) => setState(
          () {
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: NeverScrollableScrollPhysics(),
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Searchbar
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () async {
                  setState(() {
                    textString2.clear();
                    textString.clear();
                    search = "";
                    dateInput.clear();
                    dateInput2.clear();
                    dateFrom = "";
                    dateTo = "";
                    xls = "";
                    pdf = "";
                    xlsDoc = "";
                    pdfDoc = "";
                  });
                  await _getData();
                },
              ),
              IconButton(
                icon: Icon(Icons.picture_as_pdf),
                onPressed: () async {
                  pdfDoc = await api.GetPaymetHistory(
                      search, xls, "1", dateFrom, dateTo, "");
                  print(pdfDoc);

                  // print(pdfDoc.toString().split("/").last);
                  // Directory tempDir = await getTemporaryDirectory();
                  // String tempPath = tempDir.path;
                  // print(tempPath);
                  // await InternetFile.get(
                  //   pdfDoc,
                  //   progress: (receivedLength, contentLength) {
                  //     final percentage = receivedLength / contentLength * 100;
                  //     print(
                  //         'download progress: $receivedLength of $contentLength ($percentage%)');
                  //   },
                  //   storage: storageIO,
                  //   storageAdditional: storageIO.additional(
                  //     filename: pdfDoc.toString().split("/").last,
                  //     location: tempPath,
                  //   ),
                  // );

                  // String filess =
                  //     tempPath + '/' + pdfDoc.toString().split("/").last;
                  // print(filess);
                  // Future.delayed(const Duration(seconds: 3)).then(
                  //   (value) => setState(
                  //     () {
                  //       Share.shareXFiles([XFile(filess)]);
                  //     },
                  //   ),
                  // );

                  navigate(
                    context,
                    PdfViewer(
                      url: pdfDoc,
                      pageName: "Sejarah Pembayaran",
                    ),
                  );
                },
              ),
              // IconButton(
              //   icon: Icon(Icons.table_view),
              //   onPressed: () async {
              //     Future.delayed(const Duration(seconds: 0))
              //         .then((value) => setState(() {}));
              //     SchedulerBinding.instance
              //         .addPostFrameCallback((_) => showLoadingBar(context));
              //     xlsDoc = await api.GetPaymetHistory(
              //         search, "1", pdf, dateFrom, dateTo, "");
              //     print(xlsDoc);
              //     print(xlsDoc);
              //     print(xlsDoc.toString().split("/").last);
              //     Directory tempDir = await getTemporaryDirectory();
              //     String tempPath = tempDir.path;
              //     print(tempPath);
              //     await InternetFile.get(
              //       xlsDoc,
              //       progress: (receivedLength, contentLength) {
              //         final percentage = receivedLength / contentLength * 100;
              //         print(
              //             'download progress: $receivedLength of $contentLength ($percentage%)');
              //       },
              //       storage: storageIO,
              //       storageAdditional: storageIO.additional(
              //         filename: xlsDoc.toString().split("/").last,
              //         location: tempPath,
              //       ),
              //     );

              //     String filess =
              //         tempPath + '/' + xlsDoc.toString().split("/").last;
              //     print(filess);
              //     Future.delayed(const Duration(seconds: 3)).then(
              //       (value) => setState(
              //         () {
              //           Share.shareXFiles([XFile(filess)]);
              //         },
              //       ),
              //     );
              //     Future.delayed(const Duration(seconds: 2)).then(
              //       (value) => setState(
              //         () {
              //           Navigator.pop(context);
              //         },
              //       ),
              //     );
              //     // navigate(
              //     //   context,
              //     //   XlsViewer(
              //     //     url: xlsDoc,
              //     //     pageName: "Sejarah Pembayaran",
              //     //   ),
              //     // );
              //   },
              // )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
            child: TextFormField(
              controller: textString,
              autocorrect: false,
              decoration: styles.inputDecoration.copyWith(
                labelText: 'Search'.tr,
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              onChanged: (val) async {
                if (textString.text != "") {
                  setState(() {
                    search = textString.text.toString();
                  });
                  await _getData();
                }
                // setState(() {
                //   _isSearching = true;
                // });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width / 2.2,
                // width: 200,
                child: TextFormField(
                  autocorrect: false,
                  controller: dateInput,
                  decoration: styles.inputDecoration.copyWith(
                      suffix: Icon(LineIcons.calendarAlt),
                      label: Text('Start Date2'.tr)),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        locale: Get.locale?.languageCode == 'en'
                            ? Locale("en")
                            : Locale("ms"),
                        fieldHintText: 'DD/MM/YYYY',
                        fieldLabelText: 'Enter Date'.tr,
                        helpText: 'Select Date'.tr,
                        cancelText: 'Cancel'.tr,
                        confirmText: 'Yes'.tr,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());
                    if (pickedDate != null) {
                      String formattedDate =
                          dateFormatterDisplay.format(pickedDate);
                      String formattedDate2 = dateFormatter2.format(pickedDate);

                      print(pickedDate);
                      print(formattedDate);
                      print(formattedDate2);
                      setState(() {
                        set = pickedDate;
                        dateInput.text = formattedDate;
                        dateFrom = formattedDate2;
                      });
                      await _getData();
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              SizedBox(
                width: 5,
              ),
              SizedBox(
                height: 70,
                width: MediaQuery.of(context).size.width / 2.2,
                child: TextFormField(
                  autocorrect: false,
                  controller: dateInput2,
                  decoration: styles.inputDecoration.copyWith(
                      suffix: Icon(LineIcons.calendarAlt),
                      label: Text('End Date2'.tr)),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        locale: Get.locale?.languageCode == 'en'
                            ? Locale("en")
                            : Locale("ms"),
                        fieldHintText: 'DD/MM/YYYY',
                        fieldLabelText: 'Enter Date'.tr,
                        helpText: 'Select Date'.tr,
                        cancelText: 'Cancel'.tr,
                        confirmText: 'Yes'.tr,
                        initialDate: DateTime.now(),
                        // firstDate: DateTime(1900),
                        // lastDate: DateTime(2025));
                        firstDate: DateTime(set.year, set.month, set.day),
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      String formattedDate =
                          dateFormatterDisplay.format(pickedDate);
                      String formattedDate2 = dateFormatter2.format(pickedDate);
                      setState(() {
                        dateInput2.text = formattedDate;
                        dateTo = formattedDate2;
                      });
                      await _getData();
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Container(
              height: 70,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black38,
                      width: 1), //border of dropdown button
                  borderRadius: BorderRadius.circular(
                      10), //border raiuds of dropdown button
                ),
                child: Center(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 0,
                    style: const TextStyle(color: Colors.black54, fontSize: 16),
                    underline: Container(
                      height: 0,
                      color: Colors.black54,
                    ),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(value.tr),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //       backgroundColor: Constants().sixColor,
          //       minimumSize: const Size(300, 60),
          //       elevation: 0,
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(12.0),
          //       ),
          //     ),
          //     onPressed: () async {
          //       print("yess");
          //       print(textString.text);
          //       // if (textString.text == "") {
          //       //   snack(context, "Please fill in the Search".tr,
          //       //       level: SnackLevel.Error);
          //       // } else {
          //       setState(() {
          //         search = textString.text;
          //       });
          //       await _getData();
          //       // }
          //     },
          //     child: SizedBox(
          //       width: double.infinity,
          //       child: Text(
          //         "Search".tr,
          //         style: styles.raisedButtonTextWhite,
          //         textAlign: TextAlign.center,
          //       ),
          //     ),
          //   ),
          // ),

          // Transaction Bayaran mengikut transaksi
          dropdownValue == "By Transaction"
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 22, 0),
                        child: Column(
                          children: [
                            _enquiryModel0.isEmpty
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/dist/aduan.svg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              'You have no payment history for this category.'
                                                  .tr,
                                              style: styles.heading5,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _enquiryModel0.length,
                              //  _organizationModel.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Column(
                                    children: [
                                      Row(
                                        children: [
                                          _enquiryModel0[index]
                                                      .referenceNumber
                                                      .toString() !=
                                                  "null"
                                              ? Expanded(
                                                  child: Text(
                                                      _enquiryModel0[index]
                                                          .referenceNumber
                                                          // .id
                                                          .toString(),
                                                      style: _enquiryModel0[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  "Successful" ||
                                                              _enquiryModel0[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  "Telah Hantar Arahan Pindahan"
                                                          ? styles
                                                              .heading6boldunderline
                                                          : styles.heading6bold,
                                                      overflow:
                                                          TextOverflow.clip),
                                                )
                                              : Text(
                                                  "No Reference number".tr,
                                                  style: styles.heading6bold,
                                                ),
                                          _enquiryModel0[index]
                                                          .status
                                                          .toString() ==
                                                      "Successful" ||
                                                  _enquiryModel0[index]
                                                          .status
                                                          .toString() ==
                                                      "Telah Hantar Arahan Pindahan"
                                              //     ||
                                              // _enquiryModel1[index]
                                              //         .status
                                              //         .toString() ==
                                              //     "Telah Hantar Arahan Pindahan"
                                              ? IconButton(
                                                  icon: Icon(
                                                      Icons.picture_as_pdf),
                                                  color:
                                                      Constants().primaryColor,
                                                  onPressed: () async {
                                                    // billDetails(
                                                    //     _enquiryModel2[
                                                    //         index]);
                                                    String a = "";
                                                    a = await api
                                                        .GetDownloadReceipt(
                                                            _enquiryModel0[
                                                                    index]
                                                                .id
                                                                .toString());
                                                    print(a);
                                                    navigate(
                                                      context,
                                                      PdfViewer(
                                                        url: a.toString(),
                                                        pageName:
                                                            "View receipt".tr,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(),
                                          // IconButton(
                                          //   icon: Icon(Icons.visibility),
                                          //   color: Constants().primaryColor,
                                          //   onPressed: () async {
                                          //     // billDetails(
                                          //     //     _enquiryModel2[
                                          //     //         index]);
                                          //     String a = "";
                                          //     a = await api.GetDownloadReceipt(
                                          //         _enquiryModel0[index]
                                          //             .id
                                          //             .toString());
                                          //     print(a);
                                          //     navigate(
                                          //       context,
                                          //       PdfViewer(
                                          //         url: a.toString(),
                                          //         pageName: "View receipt".tr,
                                          //       ),
                                          //     );
                                          //   },
                                          // )
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatDate(
                                          DateTime.parse(_enquiryModel0[index]
                                              .createdAt
                                              .toString()),
                                          [dd, '/', mm, '/', yyyy],
                                        ),
                                      ),
                                      // Text(
                                      //   fixStatus(
                                      //     _enquiryModel1[index]
                                      //         .status
                                      //         .toString(),
                                      //   ),
                                      // ),
                                      Text("RM " +
                                          _enquiryModel0[index]
                                              .amount
                                              .toString()),
                                      // _enquiryModel0[index]
                                      //             .items![0]
                                      //             .bill
                                      //             ?.detail
                                      //             .toString() !=
                                      //         "null"
                                      //     ? Text(
                                      //         moneyFormat(double.parse(
                                      //             _enquiryModel0[index]
                                      //                     .items![0]
                                      //                     .bill
                                      //                     ?.detail
                                      //                     ?.toString() ??
                                      //                 'N/A')),
                                      //         maxLines: 2,
                                      //         overflow: TextOverflow.ellipsis,
                                      //       )
                                      //     : Text("No payment detail".tr),
                                      // _enquiryModel1[index]
                                      //             .billReferenceNumber
                                      //             .toString() !=
                                      //         "null"
                                      //     ? Text(
                                      //         _enquiryModel1[index]
                                      //             .billReferenceNumber
                                      //             .toString(),
                                      //       )
                                      //     : Text("No Bill"),
                                    ],
                                  ),
                                  // children: <Widget>[
                                  //   Padding(
                                  //     padding: const EdgeInsets.all(10.0),
                                  //     child: Column(
                                  //       mainAxisSize: MainAxisSize.min,
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.stretch,
                                  //       children: [
                                  //         state.user.firstName!
                                  //                         .toUpperCase()
                                  //                         .toString() +
                                  //                     " " +
                                  //                     state.user.lastName!
                                  //                         .toUpperCase()
                                  //                         .toString() !=
                                  //                 _enquiryModel0[index]
                                  //                         .user!
                                  //                         .firstName!
                                  //                         .toUpperCase()
                                  //                         .toString() +
                                  //                     " " +
                                  //                     _enquiryModel0[index]
                                  //                         .user!
                                  //                         .lastName!
                                  //                         .toUpperCase()
                                  //                         .toString()
                                  //             ? Text('Customer Name:'.tr,
                                  //                 style: styles
                                  //                     .heading6boldunderline)
                                  //             : Container(),
                                  //         state.user.firstName!
                                  //                         .toUpperCase()
                                  //                         .toString() +
                                  //                     " " +
                                  //                     state.user.lastName!
                                  //                         .toUpperCase()
                                  //                         .toString() !=
                                  //                 _enquiryModel0[index]
                                  //                         .user!
                                  //                         .firstName!
                                  //                         .toUpperCase()
                                  //                         .toString() +
                                  //                     " " +
                                  //                     _enquiryModel0[index]
                                  //                         .user!
                                  //                         .lastName!
                                  //                         .toUpperCase()
                                  //                         .toString()
                                  //             ? Text(_enquiryModel0[index]
                                  //                     .user!
                                  //                     .firstName!
                                  //                     .toUpperCase()
                                  //                     .toString() +
                                  //                 " " +
                                  //                 _enquiryModel0[index]
                                  //                     .user!
                                  //                     .lastName!
                                  //                     .toUpperCase()
                                  //                     .toString())
                                  //             : Container(),
                                  //         Text("iPayment Ref. No.".tr + ":",
                                  //             style:
                                  //                 styles.heading6boldunderline),
                                  //         Text(_enquiryModel1[index]
                                  //                     .transactionReference
                                  //                     .toString() ==
                                  //                 "null"
                                  //             ? "No data".tr
                                  //             : _enquiryModel1[index]
                                  //                 .transactionReference
                                  //                 .toString()),
                                  //         // Text('Tarikh:'),
                                  //         // Text("Total Payment:".tr),
                                  //         // Text("Payment Detail:".tr,
                                  //         //     style:
                                  //         //         styles.heading6boldunderline),
                                  //         // _enquiryModel0[index]
                                  //         //             .items![0]
                                  //         //             .bill
                                  //         //             ?.detail
                                  //         //             .toString() !=
                                  //         //         "null"
                                  //         //     ? Text(
                                  //         //         _enquiryModel0[index]
                                  //         //                 .items![0]
                                  //         //                 .bill
                                  //         //                 ?.detail
                                  //         //                 .toString() ??
                                  //         //             'N/A',
                                  //         //         maxLines: 10,
                                  //         //       )
                                  //         //     : Text("No payment detail".tr),
                                  //         // Text("No Rujukan:".tr,
                                  //         //     style:
                                  //         //         styles.heading6boldunderline),
                                  //         // Row(
                                  //         //   children: [
                                  //         //     Text(_enquiryModel0[index]
                                  //         //             .items![0]
                                  //         //             .bill
                                  //         //             ?.referenceNumber ??
                                  //         //         'N/A'.toString() + " / "),
                                  //         //     Text(_enquiryModel0[index]
                                  //         //             .items![0]
                                  //         //             .bill
                                  //         //             ?.billNumber
                                  //         //             ?.toString() ??
                                  //         //         'N/A'),
                                  //         //   ],
                                  //         // ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  //   // _enquiryModel1[index].status.toString() ==
                                  //   //         "Successful" || _enquiryModel1[index].status.toString() ==
                                  //   //         "Telah Hantar Arahan Pindahan"
                                  //   //     ? ListView.builder(
                                  //   //         reverse: true,
                                  //   //         physics:
                                  //   //             NeverScrollableScrollPhysics(),
                                  //   //         shrinkWrap: true,
                                  //   //         itemCount: _enquiryModel1[index]
                                  //   //             .items!
                                  //   //             .length,
                                  //   //         itemBuilder: (context, indexi) {
                                  //   //           return Padding(
                                  //   //             padding:
                                  //   //                 const EdgeInsets.fromLTRB(
                                  //   //                     10.0, 1.0, 5.0, 1.0),
                                  //   //             child: InkWell(
                                  //   //               onTap: () async {
                                  //   //                 if (_enquiryModel1[index]
                                  //   //                         .items![indexi]
                                  //   //                         .copyReceiptUrl
                                  //   //                         .toString() !=
                                  //   //                     "null") {

                                  //   //                   navigate(
                                  //   //                     context,
                                  //   //                     PdfViewer(
                                  //   //                       url: _enquiryModel1[
                                  //   //                               index]
                                  //   //                           .items![indexi]
                                  //   //                           .copyReceiptUrl
                                  //   //                           .toString(),
                                  //   //                       pageName:
                                  //   //                           "View receipt".tr,
                                  //   //                     ),
                                  //   //                   );
                                  //   //                 }
                                  //   //               },
                                  //   //               child: Row(
                                  //   //                 mainAxisAlignment:
                                  //   //                     MainAxisAlignment
                                  //   //                         .spaceBetween,
                                  //   //                 children: [
                                  //   //                   Text(
                                  //   //                     _enquiryModel1[index]
                                  //   //                         .items![indexi]
                                  //   //                         .receiptNumber
                                  //   //                         .toString(),
                                  //   //                     style:
                                  //   //                         styles.heading6bold,
                                  //   //                   ),
                                  //   //                   IconButton(
                                  //   //                     onPressed: () {
                                  //   //                       if (_enquiryModel1[
                                  //   //                                   index]
                                  //   //                               .items![
                                  //   //                                   indexi]
                                  //   //                               .copyReceiptUrl
                                  //   //                               .toString() !=
                                  //   //                           "null") {

                                  //   //                         navigate(
                                  //   //                           context,
                                  //   //                           PdfViewer(
                                  //   //                             url: _enquiryModel1[
                                  //   //                                     index]
                                  //   //                                 .items![
                                  //   //                                     indexi]
                                  //   //                                 .copyReceiptUrl
                                  //   //                                 .toString(),
                                  //   //                             pageName:
                                  //   //                                 "View receipt"
                                  //   //                                     .tr,
                                  //   //                           ),
                                  //   //                         );
                                  //   //                       }
                                  //   //                     },
                                  //   //                     icon: Icon(
                                  //   //                       Icons.visibility,
                                  //   //                       color: constants
                                  //   //                           .primaryColor,
                                  //   //                     ),
                                  //   //                   )
                                  //   //                 ],
                                  //   //               ),
                                  //   //             ),
                                  //   //           );
                                  //   //         },
                                  //   //       )
                                  //   //     : Container()
                                  // ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),

          // Others
          dropdownValue == 'Self Payment'
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 22, 0),
                        child: Column(
                          children: [
                            _enquiryModel1.isEmpty
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/dist/aduan.svg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              'You have no payment history for this category.'
                                                  .tr,
                                              style: styles.heading5,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _enquiryModel1.length,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                  title: Column(
                                    children: [
                                      Row(
                                        children: [
                                          _enquiryModel1[index]
                                                      .receiptNumber
                                                      .toString() !=
                                                  "null"
                                              ? Expanded(
                                                  child: Text(
                                                      _enquiryModel1[index]
                                                          .receiptNumber
                                                          // .id
                                                          .toString(),
                                                      style: _enquiryModel1[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  "Successful" ||
                                                              _enquiryModel1[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  "Telah Hantar Arahan Pindahan"
                                                          ? styles
                                                              .heading6boldunderline
                                                          : styles.heading6bold,
                                                      overflow:
                                                          TextOverflow.clip),
                                                )
                                              : Text(
                                                  "No Bill Number".tr,
                                                  style: styles.heading6bold,
                                                ),
                                          _enquiryModel1[index]
                                                          .status
                                                          .toString() ==
                                                      "Successful" ||
                                                  _enquiryModel1[index]
                                                          .status
                                                          .toString() ==
                                                      "Telah Hantar Arahan Pindahan"
                                              ? IconButton(
                                                  icon: Icon(
                                                      Icons.picture_as_pdf),
                                                  color:
                                                      Constants().primaryColor,
                                                  onPressed: () async {
                                                    String a = "";
                                                    a = await api
                                                        .GetDownloadReceipt(
                                                            _enquiryModel1[
                                                                    index]
                                                                .id
                                                                .toString());
                                                    print(a);
                                                    navigate(
                                                      context,
                                                      PdfViewer(
                                                        url: a.toString(),
                                                        pageName:
                                                            "View receipt".tr,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(),
                                          _enquiryModel1[index].billTypeId != 3
                                              ? IconButton(
                                                  icon: Icon(Icons.visibility),
                                                  color:
                                                      Constants().primaryColor,
                                                  onPressed: () async {
                                                    await navigate(
                                                      context,
                                                      PlaceholderHistoryDetailScreen(
                                                          _enquiryModel1[
                                                              index]),
                                                    );
                                                    // String a = "";
                                                    // a = await api.GetDownloadReceipt(
                                                    //     _enquiryModel2[index]
                                                    //         .id
                                                    //         .toString());
                                                    // print(a);
                                                    // navigate(
                                                    //   context,
                                                    //   PdfViewer(
                                                    //     url: a.toString(),
                                                    //     pageName: "View receipt".tr,
                                                    //   ),
                                                    // );
                                                  },
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatDate(
                                          DateTime.parse(_enquiryModel1[index]
                                              .createdAt
                                              .toString()),
                                          [dd, '/', mm, '/', yyyy],
                                        ),
                                      ),
                                      Text("RM " +
                                          _enquiryModel1[index]
                                              .amount
                                              .toString()),
                                      _enquiryModel1[index].detail.toString() !=
                                              "null"
                                          ? Text(
                                              _enquiryModel1[index]
                                                  .detail
                                                  .toString(),
                                              // moneyFormat(double.parse(
                                              //     _enquiryModel2[index]
                                              //         .detail
                                              //         .toString())),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text("No payment detail".tr),
                                    ],
                                  ),
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            state.user.firstName!
                                                            .toUpperCase()
                                                            .toString() +
                                                        " " +
                                                        state.user.lastName!
                                                            .toUpperCase()
                                                            .toString() !=
                                                    _enquiryModel1[index]
                                                        .userName!
                                                        .toUpperCase()
                                                        .toString()
                                                ? Text('Customer Name:'.tr,
                                                    style: styles
                                                        .heading6boldunderline)
                                                : Container(),
                                            state.user.firstName!
                                                            .toUpperCase()
                                                            .toString() +
                                                        " " +
                                                        state.user.lastName!
                                                            .toUpperCase()
                                                            .toString() !=
                                                    _enquiryModel1[index]
                                                        .userName!
                                                        .toUpperCase()
                                                        .toString()
                                                ? Text(_enquiryModel1[index]
                                                    .userName
                                                    .toString())
                                                : Container(),
                                            Text("Payment Detail:".tr,
                                                style: styles
                                                    .heading6boldunderline),
                                            _enquiryModel1[index]
                                                        .detail
                                                        .toString() !=
                                                    "null"
                                                ? Text(
                                                    _enquiryModel1[index]
                                                        .detail
                                                        .toString(),
                                                    maxLines: 10,
                                                  )
                                                : Text("No payment detail".tr),
                                            Text("iPayment Ref. No.".tr + ":",
                                                style: styles
                                                    .heading6boldunderline),
                                            Text(_enquiryModel1[index]
                                                .referenceNumber
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),

          dropdownValue == 'Payment for Third Party'
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 22, 0),
                        child: Column(
                          children: [
                            _enquiryModel2.isEmpty
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/dist/aduan.svg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              'You have no payment history for this category.'
                                                  .tr,
                                              style: styles.heading5,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _enquiryModel2.length,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                  title: Column(
                                    children: [
                                      Row(
                                        children: [
                                          _enquiryModel2[index]
                                                      .receiptNumber
                                                      .toString() !=
                                                  "null"
                                              ? Expanded(
                                                  child: Text(
                                                      _enquiryModel2[index]
                                                          .receiptNumber
                                                          // .id
                                                          .toString(),
                                                      style: _enquiryModel2[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  "Successful" ||
                                                              _enquiryModel2[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  "Telah Hantar Arahan Pindahan"
                                                          ? styles
                                                              .heading6boldunderline
                                                          : styles.heading6bold,
                                                      overflow:
                                                          TextOverflow.clip),
                                                )
                                              : Text(
                                                  "No Bill Number".tr,
                                                  style: styles.heading6bold,
                                                ),
                                          _enquiryModel2[index]
                                                          .status
                                                          .toString() ==
                                                      "Successful" ||
                                                  _enquiryModel2[index]
                                                          .status
                                                          .toString() ==
                                                      "Telah Hantar Arahan Pindahan"
                                              ? IconButton(
                                                  icon: Icon(
                                                      Icons.picture_as_pdf),
                                                  color:
                                                      Constants().primaryColor,
                                                  onPressed: () async {
                                                    String a = "";
                                                    a = await api
                                                        .GetDownloadReceipt(
                                                            _enquiryModel2[
                                                                    index]
                                                                .id
                                                                .toString());
                                                    print(a);
                                                    navigate(
                                                      context,
                                                      PdfViewer(
                                                        url: a.toString(),
                                                        pageName:
                                                            "View receipt".tr,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(),
                                          _enquiryModel2[index].billTypeId != 3
                                              ? IconButton(
                                                  icon: Icon(Icons.visibility),
                                                  color:
                                                      Constants().primaryColor,
                                                  onPressed: () async {
                                                    await navigate(
                                                      context,
                                                      PlaceholderHistoryDetailScreen(
                                                          _enquiryModel2[
                                                              index]),
                                                    );
                                                  },
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatDate(
                                          DateTime.parse(_enquiryModel2[index]
                                              .createdAt
                                              .toString()),
                                          [dd, '/', mm, '/', yyyy],
                                        ),
                                      ),
                                      Text("RM " +
                                          _enquiryModel2[index]
                                              .amount
                                              .toString()),
                                      _enquiryModel2[index].detail.toString() !=
                                              "null"
                                          ? Text(
                                              _enquiryModel2[index]
                                                  .detail
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text("No payment detail".tr),
                                    ],
                                  ),
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            state.user.firstName!
                                                            .toUpperCase()
                                                            .toString() +
                                                        " " +
                                                        state.user.lastName!
                                                            .toUpperCase()
                                                            .toString() !=
                                                    _enquiryModel2[index]
                                                        .userName!
                                                        .toUpperCase()
                                                        .toString()
                                                ? Text('Customer Name:'.tr,
                                                    style: styles
                                                        .heading6boldunderline)
                                                : Container(),
                                            state.user.firstName!
                                                            .toUpperCase()
                                                            .toString() +
                                                        " " +
                                                        state.user.lastName!
                                                            .toUpperCase()
                                                            .toString() !=
                                                    _enquiryModel2[index]
                                                        .userName!
                                                        .toUpperCase()
                                                        .toString()
                                                ? Text(_enquiryModel2[index]
                                                    .userName
                                                    .toString())
                                                : Container(),
                                            Text("Payment Detail:".tr,
                                                style: styles
                                                    .heading6boldunderline),
                                            _enquiryModel2[index]
                                                        .detail
                                                        .toString() !=
                                                    "null"
                                                ? Text(
                                                    _enquiryModel2[index]
                                                        .detail
                                                        .toString(),
                                                    maxLines: 10,
                                                  )
                                                : Text("No payment detail".tr),
                                            Text("iPayment Ref. No.".tr + ":",
                                                style: styles
                                                    .heading6boldunderline),
                                            Text(_enquiryModel2[index]
                                                .referenceNumber
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),

          dropdownValue == 'Payment by Third Party'
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 22, 0),
                        child: Column(
                          children: [
                            _enquiryModel3.isEmpty
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(50),
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                              'assets/dist/aduan.svg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text(
                                              'You have no payment history for this category.'
                                                  .tr,
                                              style: styles.heading5,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _enquiryModel3.length,
                              itemBuilder: (context, index) {
                                return ExpansionTile(
                                  title: Column(
                                    children: [
                                      Row(
                                        children: [
                                          _enquiryModel3[index]
                                                      .receiptNumber
                                                      .toString() !=
                                                  "null"
                                              ? Expanded(
                                                  child: Text(
                                                      _enquiryModel3[index]
                                                          .receiptNumber
                                                          // .id
                                                          .toString(),
                                                      style: _enquiryModel3[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  "Successful" ||
                                                              _enquiryModel3[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  "Telah Hantar Arahan Pindahan"
                                                          ? styles
                                                              .heading6boldunderline
                                                          : styles.heading6bold,
                                                      overflow:
                                                          TextOverflow.clip),
                                                )
                                              : Text(
                                                  "No Bill Number".tr,
                                                  style: styles.heading6bold,
                                                ),
                                          _enquiryModel3[index]
                                                          .status
                                                          .toString() ==
                                                      "Successful" ||
                                                  _enquiryModel3[index]
                                                          .status
                                                          .toString() ==
                                                      "Telah Hantar Arahan Pindahan"
                                              ? IconButton(
                                                  icon: Icon(
                                                      Icons.picture_as_pdf),
                                                  color:
                                                      Constants().primaryColor,
                                                  onPressed: () async {
                                                    String a = "";
                                                    a = await api
                                                        .GetDownloadReceipt(
                                                            _enquiryModel3[
                                                                    index]
                                                                .id
                                                                .toString());
                                                    print(a);
                                                    navigate(
                                                      context,
                                                      PdfViewer(
                                                        url: a.toString(),
                                                        pageName:
                                                            "View receipt".tr,
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(),
                                          _enquiryModel3[index].billTypeId != 3
                                              ? IconButton(
                                                  icon: Icon(Icons.visibility),
                                                  color:
                                                      Constants().primaryColor,
                                                  onPressed: () async {
                                                    await navigate(
                                                      context,
                                                      PlaceholderHistoryDetailScreen(
                                                          _enquiryModel3[
                                                              index]),
                                                    );
                                                  },
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        formatDate(
                                          DateTime.parse(_enquiryModel3[index]
                                              .createdAt
                                              .toString()),
                                          [dd, '/', mm, '/', yyyy],
                                        ),
                                      ),
                                      Text("RM " +
                                          _enquiryModel3[index]
                                              .amount
                                              .toString()),
                                      _enquiryModel3[index].detail.toString() !=
                                              "null"
                                          ? Text(
                                              _enquiryModel3[index]
                                                  .detail
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            )
                                          : Text("No payment detail".tr),
                                    ],
                                  ),
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            state.user.firstName!
                                                            .toUpperCase()
                                                            .toString() +
                                                        " " +
                                                        state.user.lastName!
                                                            .toUpperCase()
                                                            .toString() !=
                                                    _enquiryModel3[index]
                                                        .userName!
                                                        .toUpperCase()
                                                        .toString()
                                                ? Text('Customer Name:'.tr,
                                                    style: styles
                                                        .heading6boldunderline)
                                                : Container(),
                                            state.user.firstName!
                                                            .toUpperCase()
                                                            .toString() +
                                                        " " +
                                                        state.user.lastName!
                                                            .toUpperCase()
                                                            .toString() !=
                                                    _enquiryModel3[index]
                                                        .userName!
                                                        .toUpperCase()
                                                        .toString()
                                                ? Text(_enquiryModel3[index]
                                                    .userName
                                                    .toString())
                                                : Container(),
                                            Text("Payment Detail:".tr,
                                                style: styles
                                                    .heading6boldunderline),
                                            _enquiryModel3[index]
                                                        .detail
                                                        .toString() !=
                                                    "null"
                                                ? Text(
                                                    _enquiryModel3[index]
                                                        .detail
                                                        .toString(),
                                                    maxLines: 10,
                                                  )
                                                : Text("No payment detail".tr),
                                            Text("iPayment Ref. No.".tr + ":",
                                                style: styles
                                                    .heading6boldunderline),
                                            Text(_enquiryModel3[index]
                                                .referenceNumber
                                                .toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
