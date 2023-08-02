// import 'dart:convert';

import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
// import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/incomplete/service_incomplete.dart';
// import 'package:flutterbase/models/payments/payments.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:line_icons/line_icons.dart';
import '../../../models/bills/bills.dart' as model;
// import '../home/payment.dart';
import 'package:flutterbase/models/contents/bank.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../models/payments/payments.dart';
import '../home/duitnow_qr.dart';
import '../home/payment.dart';

class PendingDetailsScreen extends StatefulWidget {
  final model.Incomplete incompleteTransaction;
  const PendingDetailsScreen(this.incompleteTransaction, {Key? key})
      : super(key: key);

  @override
  State<PendingDetailsScreen> createState() => _PendingDetailsScreenState();
}

class _PendingDetailsScreenState extends State<PendingDetailsScreen> {
  late model.Incomplete _incompleteTransaction;
  var inputFormat = DateFormat('dd-MM-yyyy');
  bool alreadySaved = false;
  List<model.PaymentGateway> _paymentGateways = [];
  List<Bank> _bankList = [];
  String gateway = "Select Payment Method".tr;
  String bankText = "Select Bank or E-wallet".tr;
  String bank = "";
  String bankLink = "";
  String gatewayMethod = "";
  String bankCode = "";
  String bankType = "";
  String amount = "";
  Map a = {};
  // ignore: unused_field
  List<Bank> _enquiryModel11 = [];

  final TextEditingController _typeAheadController = TextEditingController();
  late String _selectedCity;
  List<Bank> cor = [];
  List<Bank> ret = [];
  List<String> _enquiryModel12 = [];
  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    setState(() {
      _incompleteTransaction = widget.incompleteTransaction;
    });

    _paymentGateways = await api.GetPaymentGateway();
    _bankList = await api.GetPaynetBank();

    print("_enquiryModel3.gatewayId.toString() " +
        _incompleteTransaction.gatewayId.toString());

    print("length " + _incompleteTransaction.items!.length.toString());

    // print(_incompleteTransaction.items![0].items!.toString());

    for (var i = 0; i < _paymentGateways.length; i++) {
      if (_paymentGateways[i].id == _incompleteTransaction.gatewayId) {
        // print(_paymentGateways[i].title.toString());
        setState(() {
          gatewayMethod = _incompleteTransaction.gatewayId.toString();
          gateway = _paymentGateways[i].title.toString();
        });
      }
    }

    setState(() {
      _bankList = _bankList;
    });

    _bankList.removeWhere((item) => item.redirectUrls == null);

    setState(() {
      _bankList = _bankList;
    });

    _bankList.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
    setState(() {
      _bankList = _bankList;
    });

    for (var v = 0; v < _bankList.length; v++) {
      for (var q = 0; q < _bankList[v].redirectUrls!.length - 1; q++) {
        if (_bankList[v].redirectUrls!.length == 2) {
          if (_bankList[v].redirectUrls![q].type ==
                  _bankList[v].redirectUrls![q + 1].type ||
              _bankList[v].redirectUrls![q].type == " " ||
              _bankList[v].redirectUrls![q + 1].type == " ") {
            _bankList[v].redirectUrls!.removeLast();
          }
        }
      }
    }
    setState(() {
      _bankList = _bankList;
    });

    // for (var v = 0; v < _bankList.length; v++) {
    //   for (var q = 0; q < _bankList[v].redirectUrls!.length; q++) {
    // print(_bankList[v].redirectUrls![q].url.toString());
    // print(_bankList[v].redirectUrls![q].type.toString());
    // _enquiryModel11.add(
    //   Bank(
    //     active: true,
    //     code: _bankList[v].code,
    //     name: _bankList[v].name +
    //         " " +
    //         (_bankList[v].redirectUrls![q].type.toString() == "RET"
    //             ? "(Retail)"
    //             : "(Corporate)"),
    //     redirectUrls: [
    //       RedirectUrl(
    //           type: _bankList[v].redirectUrls![q].type,
    //           url: _bankList[v].redirectUrls![q].url)
    //     ],
    //   ),
    // );
    //   }
    // }

    for (var v = 0; v < _bankList.length; v++) {
      for (var q = 0; q < _bankList[v].redirectUrls!.length; q++) {
        _enquiryModel12.add(_bankList[v].name);
      }
    }

    // for (var v = 0; v < _enquiryModel12.length; v++) {
    //   print("_enquiryModel12[v].toString() " + _enquiryModel12[v].toString());
    // }
    Future.delayed(const Duration(seconds: 0)).then(
      (value) => setState(
        () {
          Navigator.pop(context);
        },
      ),
    );
  }

// 1 = DuiNow QR, 2 = Kad, 5 = DuitNow Online Banking/Wallets
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Constants().primaryColor,
          onPressed: () async {
            Navigator.pop(context, true);
          },
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        title: Text(
          "Checkout".tr,
          style: styles.heading5,
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _incompleteTransaction.items!.length,
                //  _organizationModel.length,
                itemBuilder: (context, index) {
                  model.ItemsIncomplete item =
                      _incompleteTransaction.items![index];
                  model.Bills? bill = item.bill;
                  // ignore: unused_local_variable
                  ServiceIncompletes? service = item.service;
                  log(item.service!.billTypeId.toString());
                  return ExpansionTile(
                    title: Text(
                      _incompleteTransaction.items!.length > 1
                          ? "Item ".tr + (index + 1).toString()
                          : "Transaction Details".tr,
                      style: styles.heading12bold,
                    ),
                    initiallyExpanded: index == 0,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          // elevation: 10,r
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                            side: BorderSide(width: 1, color: Colors.green),
                          ),
                          color: Colors.white70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                title: Text(
                                  "Reference Number".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 8.0, 8.0, 8.0),
                                  child: Text(
                                    _incompleteTransaction.referenceNumber!,
                                    style: styles.heading12sub,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Service Categories".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 8.0, 8.0, 8.0),
                                  child: Text(
                                    item.service!.serviceCategory == null
                                        ? " - "
                                        : item.service!.serviceCategory
                                            .toString(),
                                    style: styles.heading12sub,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Service Name".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 8.0, 8.0, 8.0),
                                  child: Text(
                                    item.service!.name!,
                                    style: styles.heading12sub,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Agency Name".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 8.0, 8.0, 8.0),
                                  child: Text(
                                    item.service!.agency!.name == null
                                        ? " - "
                                        : item.service!.agency!.name.toString(),
                                    style: styles.heading12sub,
                                  ),
                                ),
                              ),
                              if (bill != null)
                                ListTile(
                                  title: Text(
                                    "iPayment Ref. No.".tr,
                                    style: styles.heading12bold,
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 8.0, 8.0, 8.0),
                                    child: Text(
                                      bill.billNumber!.toString(),
                                      style: styles.heading12sub,
                                    ),
                                  ),
                                ),
                              if (bill != null)
                                ListTile(
                                  title: Text(
                                    bill.service!.refNoLabel.toString(),
                                    style: styles.heading12bold,
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 8.0, 8.0, 8.0),
                                    child: Text(
                                      bill.referenceNumber.toString(),
                                      style: styles.heading12sub,
                                    ),
                                  ),
                                ),
                              if (bill != null)
                                ListTile(
                                  title: Text(
                                    "Payment Details".tr,
                                    style: styles.heading12bold,
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 8.0, 8.0, 8.0),
                                    child: Text(
                                      bill.detail.toString(),
                                      style: styles.heading12sub,
                                    ),
                                  ),
                                ),
                              if (bill != null)
                                ListTile(
                                  title: Text(
                                    "Bill Reference Date".tr,
                                    style: styles.heading12bold,
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 8.0, 8.0, 8.0),
                                    child: bill.billDate.toString() == "" ||
                                            bill.billDate.toString() == "null"
                                        ? Text(
                                            "No date".tr,
                                            style: styles.heading12sub,
                                          )
                                        : Text(
                                            formatDate(
                                              DateTime.parse(
                                                  bill.billDate.toString()),
                                              [dd, '/', mm, '/', yyyy],
                                            ),
                                            style: styles.heading12sub,
                                          ),
                                  ),
                                ),
                              (bill != null && bill.endAt.toString() != "null")
                                  ? ListTile(
                                      title: Text(
                                        "Due On".tr,
                                        style: styles.heading12bold,
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8.0, 8.0, 8.0),
                                        child: Text(
                                          formatDate(
                                            DateTime.parse(
                                                item.bill!.endAt.toString()),
                                            [dd, '/', mm, '/', yyyy],
                                          ),
                                          style: styles.heading12sub,
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                              ListTile(
                                title: Text(
                                  "User Category".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 8.0, 8.0, 8.0),
                                  child: Text(
                                    item.service!.chargedTo == 'Pelanggan'
                                        ? 'Customer'.tr
                                        : 'Government'.tr,
                                    style: styles.heading12sub,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Status".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 8.0, 8.0, 8.0),
                                  child: Text(
                                    fixStatus(_incompleteTransaction.status
                                        .toString()),
                                    style: styles.heading12sub,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Note to payer".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 8.0, 8.0, 8.0),
                                  child: Text(
                                    fixStatus(_incompleteTransaction.status
                                        .toString()),
                                    style: styles.heading12sub,
                                  ),
                                ),
                              ),
                              (item.service!.billTypeId == 3 ||
                                      item.service!.billTypeId == 5)
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 0, 0, 10),
                                      child: Text(
                                        "Additional Detail".tr,
                                        style: styles.heading12bold,
                                      ),
                                    )
                                  : Container(),
                              // (service != null &&
                              //         (item.service!.billTypeId == 3 ||
                              //             item.service!.billTypeId == 5))
                              //     ? Container(
                              //         padding:
                              //             EdgeInsets.symmetric(horizontal: 15),
                              //         child: (item.service!.billTypeId == 3 ||
                              //                 item.service!.billTypeId == 5)
                              //             ? Padding(
                              //                 padding: const EdgeInsets.only(
                              //                     bottom: 10),
                              //                 child: SingleChildScrollView(
                              //                   scrollDirection:
                              //                       Axis.horizontal,
                              //                   child: marshalItems(
                              //                       item.items ?? []),
                              //                 ),
                              //               )
                              //             : Container(),
                              //       )
                              //     : Container()
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Constants().fourColor,
                          border: Border.all(
                            color: Constants().fourColor,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  "Payment Summary".tr,
                                  style: styles.heading5bold,
                                ),
                              ),
                              ExpansionTile(
                                title: Text(
                                  "Payment Total".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Text(
                                  "RM " +
                                      moneyFormat(double.parse(
                                          _incompleteTransaction.amount
                                              .toString())),
                                  style: styles.heading12bold,
                                ),
                                children: [
                                  ExpansionTile(
                                    title: Text(
                                      "Subtotal Amount".tr,
                                      style: styles.heading12bold,
                                    ),
                                    subtitle: Text(
                                      "RM " +
                                          moneyFormat(double.parse(
                                              _incompleteTransaction.amount
                                                  .toString())),
                                      style: styles.heading12bold,
                                    ),
                                    children: [
                                      // Padding(
                                      //   padding:
                                      //       const EdgeInsets.only(left: 8.0),
                                      //   child: Align(
                                      //     alignment: Alignment.centerLeft,
                                      //     child: Text(_incompleteTransaction
                                      //         .items![0]
                                      //         .bill!
                                      //         .chargelines![0]
                                      //         .classificationCode!
                                      //         .description
                                      //         .toString()),
                                      //   ),
                                      // )
                                      _incompleteTransaction.items!.length != 0
                                          ? ListView.builder(
                                              reverse: true,
                                              physics: BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: _incompleteTransaction
                                                  .items!.length,
                                              itemBuilder: (context, index) {
                                                return ListView.builder(
                                                  reverse: true,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      _incompleteTransaction
                                                          .items![index]
                                                          .bill!
                                                          .chargelines!
                                                          .length,
                                                  itemBuilder:
                                                      (context, indexA) {
                                                    return Text(
                                                      _incompleteTransaction
                                                          .items![index]
                                                          .bill!
                                                          .chargelines![indexA]
                                                          .classificationCode!
                                                          .description
                                                          .toString(),
                                                    );
                                                  },
                                                );
                                              },
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  //Payments
                                  _incompleteTransaction.items![0].bill!
                                              .payments!.length !=
                                          0
                                      ? Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "List of bil payments".tr,
                                            style: styles.heading12bold,
                                          ),
                                        )
                                      : Container(),
                                  _incompleteTransaction.items![0].bill!
                                              .payments!.length !=
                                          0
                                      ? ListView.builder(
                                          reverse: true,
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: _incompleteTransaction
                                              .items![0].bill!.payments!.length,
                                          itemBuilder: (context, indexA) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Date".tr,
                                                    style: styles.heading11bold,
                                                  ),
                                                  Text(
                                                      formatDate(
                                                        DateTime.parse(
                                                            _incompleteTransaction
                                                                .items![0]
                                                                .bill!
                                                                .payments![
                                                                    indexA]
                                                                .receiptDocumentDate
                                                                .toString()),
                                                        [
                                                          dd,
                                                          '/',
                                                          mm,
                                                          '/',
                                                          yyyy
                                                        ],
                                                      ),
                                                      style: styles.heading11),
                                                  Text(
                                                    "Receipt Number".tr,
                                                    style: styles.heading11bold,
                                                  ),
                                                  Text(
                                                      _incompleteTransaction
                                                          .items![0]
                                                          .bill!
                                                          .payments![indexA]
                                                          .referenceNumber
                                                          .toString(),
                                                      style: styles.heading11),
                                                  Text(
                                                    "Amount".tr,
                                                    style: styles.heading11bold,
                                                  ),
                                                  Text(
                                                      "RM " +
                                                          moneyFormat(
                                                              double.parse(
                                                            _incompleteTransaction
                                                                .items![0]
                                                                .bill!
                                                                .payments![
                                                                    indexA]
                                                                .amount
                                                                .toString(),
                                                          )),
                                                      style: styles.heading11),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : Container(),
                                  _incompleteTransaction.items![0].bill!
                                              .nettCalculations!.roundingData
                                              .toString() !=
                                          "null"
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Rounding Value".tr,
                                              style: styles.heading12bold,
                                            ),
                                            Text(
                                              "RM " +
                                                  moneyFormat(double.parse(
                                                    _incompleteTransaction
                                                        .items![0]
                                                        .bill!
                                                        .nettCalculations!
                                                        .roundingData!
                                                        .amount
                                                        .toString(),
                                                  )),
                                              style: styles.heading12bold,
                                            ),
                                          ],
                                        )
                                      : Container(),
                                  // Amount Changes
                                  _incompleteTransaction.items![0].bill!
                                              .amountChanges!.length !=
                                          0
                                      ? Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "List of amount changes".tr,
                                            style: styles.heading12bold,
                                          ),
                                        )
                                      : Container(),
                                  _incompleteTransaction.items![0].bill!
                                              .amountChanges!.length !=
                                          0
                                      ? ListView.builder(
                                          reverse: true,
                                          physics: BouncingScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: _incompleteTransaction
                                              .items![0]
                                              .bill!
                                              .amountChanges!
                                              .length,
                                          itemBuilder: (context, indexA) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "Date".tr,
                                                    style: styles.heading11bold,
                                                  ),
                                                  Text(
                                                      formatDate(
                                                        DateTime.parse(
                                                            _incompleteTransaction
                                                                .items![0]
                                                                .bill!
                                                                .amountChanges![
                                                                    indexA]
                                                                .agencyApprovalDate
                                                                .toString()),
                                                        [
                                                          dd,
                                                          '/',
                                                          mm,
                                                          '/',
                                                          yyyy
                                                        ],
                                                      ),
                                                      style: styles.heading11),
                                                  Text(
                                                    "Reference Number".tr,
                                                    style: styles.heading11bold,
                                                  ),
                                                  Text(
                                                      _incompleteTransaction
                                                          .items![0]
                                                          .bill!
                                                          .amountChanges![
                                                              indexA]
                                                          .referenceNumber
                                                          .toString(),
                                                      style: styles.heading11),
                                                  Text(
                                                    "Amount".tr,
                                                    style: styles.heading11bold,
                                                  ),
                                                  Text(
                                                      "RM " +
                                                          moneyFormat(
                                                              double.parse(
                                                            _incompleteTransaction
                                                                .items![0]
                                                                .bill!
                                                                .amountChanges![
                                                                    indexA]
                                                                .amount
                                                                .toString(),
                                                          )),
                                                      style: styles.heading11),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : Container(),
                                ],
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "Amaun Diskaun",
                              //       style: styles.heading12bold,
                              //     ),
                              //     Text(
                              //       "RM " +
                              //           _enquiryModel3.discountAmount!
                              //               .toString(),
                              //       style: styles.heading12bold,
                              //     )
                              //   ],
                              // ),
                              // _enquiryModel3.taxAmount != "0.00"
                              //     ? Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(
                              //             "Amaun Cukai",
                              //             style: styles.heading12bold,
                              //           ),
                              //           Text(
                              //             "RM " +
                              //                 _enquiryModel3.taxAmount!
                              //                     .toString(),
                              //             style: styles.heading12bold,
                              //           )
                              //         ],
                              //       )
                              //     : Container(),
                              // _enquiryModel3.taxAmount != "0.00"
                              //     ? Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(
                              //             "Amaun Sebelum Cukai",
                              //             style: styles.heading12bold,
                              //           ),
                              //           Text(
                              //             "RM " +
                              //                 _enquiryModel3
                              //                     .amountWithoutTax!
                              //                     .toString(),
                              //             style: styles.heading12bold,
                              //           )
                              //         ],
                              //       )
                              //     : Container(),

                              //WIP

                              // _enquiryModel3.roundingAdjustment!
                              //             .toString() !=
                              //         "0.00"
                              //     ? Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(
                              //             "Amaun Sebelum Pengenapan",
                              //             style: styles.heading12bold,
                              //           ),
                              //           Text(
                              //             "RM " +
                              //                 _enquiryModel3.actualAmount!
                              //                     .toString(),
                              //             style: styles.heading12bold,
                              //           )
                              //         ],
                              //       )
                              //     : Container(),
                              // _enquiryModel3.roundingAdjustment!
                              //             .toString() !=
                              //         "0.00"
                              //     ? Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(
                              //             "Amaun Pelaras Pengenapan",
                              //             style: styles.heading12bold,
                              //           ),
                              //           Text(
                              //             "RM " +
                              //                 _enquiryModel3
                              //                     .roundingAdjustment!
                              //                     .toString(),
                              //             style: styles.heading12bold,
                              //           )
                              //         ],
                              //       )
                              //     : Container(),
                              // _enquiryModel3.roundingAdjustment!
                              //             .toString() !=
                              //         "0.00"
                              //     ? Row(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.spaceBetween,
                              //         children: [
                              //           Text(
                              //             "Amaun Selepas Pengenapan",
                              //             style: styles.heading12bold,
                              //           ),
                              //           Text(
                              //             "RM " +
                              //                 _enquiryModel3.nettAmount!
                              //                     .toString(),
                              //             style: styles.heading12bold,
                              //           )
                              //         ],
                              //       )
                              //     : Container(),
                              // Divider(),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Text(
                              //       "Jumlah Bayaran",
                              //       style: styles.heading12bold,
                              //     ),
                              //     Text(
                              //       "RM "
                              //       //  +
                              //       //     _enquiryModel3
                              //       //         .nettCalculations!.total
                              //       //         .toString()
                              //       ,
                              //       style: styles.heading12bold,
                              //     )
                              //   ],
                              // ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 8.0, bottom: 8.0),
                                child: Text(
                                  "Payment Method".tr,
                                  style: styles.heading5bold,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Constants().secondaryColor,
                                  border: Border.all(
                                    color: Constants().secondaryColor,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Flex(
                                  direction: Axis.horizontal,
                                  children: [
                                    // Flexible(
                                    //   flex: 1,
                                    //   fit: FlexFit.tight,
                                    //   child: Icon(Icons.money),
                                    // ),
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 5,
                                      child: Text(
                                        gateway,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black38),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: IconButton(
                                        onPressed: () {
                                          Get.bottomSheet(
                                            ListView(
                                              children: [
                                                // Padding(
                                                //   padding: const EdgeInsets.symmetric(
                                                //       vertical: 15.0),
                                                //   child: Text(
                                                //     "Payment Options",
                                                //     style: TextStyle(
                                                //       fontSize: 18,
                                                //       fontWeight: FontWeight.w600,
                                                //     ),
                                                //   ),
                                                // ),
                                                AppBar(
                                                  backgroundColor:
                                                      constants.secondaryColor,
                                                  centerTitle: true,
                                                  leading: Container(),
                                                  title: Text(
                                                    "Payment Method".tr,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  actions: [
                                                    IconButton(
                                                      onPressed: () =>
                                                          Get.back(),
                                                      icon: Icon(
                                                          Icons.close_rounded),
                                                    )
                                                  ],
                                                ),
                                                ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      _paymentGateways.length,
                                                  //  _organizationModel.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      leading: _paymentGateways[
                                                                      index]
                                                                  .logo !=
                                                              null
                                                          ? Image.network(
                                                              "https://internal-ipayment.anm.gov.my/storage/" +
                                                                  _paymentGateways[
                                                                          index]
                                                                      .logo!,
                                                              // width: 60,
                                                              // height: 50,
                                                              errorBuilder: (BuildContext
                                                                      context,
                                                                  Object
                                                                      exception,
                                                                  StackTrace?
                                                                      stackTrace) {
                                                                return Icon(
                                                                  Icons.money,
                                                                  size: 30,
                                                                );
                                                              },
                                                            )
                                                          : Container(
                                                              width: 1,
                                                              height: 1,
                                                            ),
                                                      title: Text(
                                                          _paymentGateways[
                                                                      index]
                                                                  .title ??
                                                              'N/A'),
                                                      onTap: () {
                                                        print(_paymentGateways[
                                                                index]
                                                            .title!);
                                                        setState(() {
                                                          gateway =
                                                              _paymentGateways[
                                                                      index]
                                                                  .title!
                                                                  .toString();
                                                          gatewayMethod =
                                                              _paymentGateways[
                                                                      index]
                                                                  .id
                                                                  .toString();
                                                        });
                                                        Get.back();
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            backgroundColor: Colors.white,
                                          );
                                        },
                                        icon: Icon(Icons.edit_outlined),
                                        color: constants.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      gatewayMethod == "11" ||
                              gatewayMethod == "2" ||
                              gateway == "DuitNow OBW"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "List of Banks/E-wallet".tr,
                                    style: styles.heading5bold,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Constants().secondaryColor,
                                      border: Border.all(
                                        color: Constants().secondaryColor,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      children: [
                                        Flexible(
                                          flex: 6,
                                          fit: FlexFit.tight,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 1.0),
                                            child: SizedBox(
                                              height: 250,
                                              child: ListView(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(1.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        TypeAheadFormField(
                                                            textFieldConfiguration:
                                                                TextFieldConfiguration(
                                                              controller: this
                                                                  ._typeAheadController,
                                                              decoration:
                                                                  InputDecoration(
                                                                      labelText:
                                                                          bankText),
                                                            ),
                                                            suggestionsCallback:
                                                                (pattern) {
                                                              return getSuggestions(
                                                                  pattern,
                                                                  _enquiryModel12);
                                                            },
                                                            itemBuilder: (context,
                                                                suggestion) {
                                                              return ListTile(
                                                                title: Text(
                                                                  suggestion
                                                                      .toString(),
                                                                ),
                                                              );
                                                            },
                                                            transitionBuilder:
                                                                (context,
                                                                    suggestionsBox,
                                                                    controller) {
                                                              return suggestionsBox;
                                                            },
                                                            onSuggestionSelected:
                                                                (suggestion) {
                                                              this
                                                                      ._typeAheadController
                                                                      .text =
                                                                  suggestion
                                                                      .toString();
                                                              setState(() {
                                                                bank = suggestion
                                                                    .toString();
                                                              });
                                                              print(" ad " +
                                                                  suggestion
                                                                      .toString());
                                                              setState(() {
                                                                cor = [];
                                                                ret = [];
                                                              });

                                                              for (var v = 0;
                                                                  v <
                                                                      _bankList
                                                                          .length;
                                                                  v++) {
                                                                for (var q = 0;
                                                                    q <
                                                                        _bankList[v]
                                                                            .redirectUrls!
                                                                            .length;
                                                                    q++) {
                                                                  if (_bankList[
                                                                              v]
                                                                          .name ==
                                                                      suggestion
                                                                          .toString()) {
                                                                    print(
                                                                        "yes");
                                                                    print(_bankList[
                                                                            v]
                                                                        .name);
                                                                    if (_bankList[v]
                                                                            .redirectUrls![q]
                                                                            .type
                                                                            .toString() ==
                                                                        "RET") {
                                                                      ret.add(
                                                                        Bank(
                                                                          active:
                                                                              true,
                                                                          code:
                                                                              _bankList[v].code,
                                                                          name:
                                                                              _bankList[v].name,
                                                                          redirectUrls: [
                                                                            RedirectUrl(
                                                                                type: _bankList[v].redirectUrls![q].type,
                                                                                url: _bankList[v].redirectUrls![q].url)
                                                                          ],
                                                                        ),
                                                                      );
                                                                    }
                                                                    if (_bankList[v]
                                                                            .redirectUrls![q]
                                                                            .type
                                                                            .toString() ==
                                                                        "COR") {
                                                                      cor.add(
                                                                        Bank(
                                                                          active:
                                                                              true,
                                                                          code:
                                                                              _bankList[v].code,
                                                                          name:
                                                                              _bankList[v].name,
                                                                          redirectUrls: [
                                                                            RedirectUrl(
                                                                                type: _bankList[v].redirectUrls![q].type,
                                                                                url: _bankList[v].redirectUrls![q].url)
                                                                          ],
                                                                        ),
                                                                      );
                                                                    }
                                                                    setState(
                                                                        () {
                                                                      ret = ret;
                                                                      cor = cor;
                                                                    });
                                                                  }
                                                                }
                                                              }
                                                              print("ret.length.toString()" +
                                                                  ret.length
                                                                      .toString());
                                                              print("cor.length.toString()" +
                                                                  cor.length
                                                                      .toString());
                                                            },
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return 'Please select a bank';
                                                              }
                                                              return 'Please select a bank';
                                                            },
                                                            onSaved: (value) {
                                                              print(value
                                                                  .toString());
                                                              setState(() {
                                                                this._selectedCity =
                                                                    value!;
                                                              });

                                                              print(this
                                                                  ._selectedCity
                                                                  .toString());
                                                            }),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        // RaisedButton(
                                                        //   child:
                                                        //       Text('Submit'),
                                                        //   onPressed: () {
                                                        //     if (this
                                                        //         ._formKey
                                                        //         .currentState
                                                        //         .validate()) {
                                                        //       this
                                                        //           ._formKey
                                                        //           .currentState
                                                        //           .save();
                                                        //       Scaffold.of(
                                                        //               context)
                                                        //           .showSnackBar(SnackBar(
                                                        //               content:
                                                        //                   Text('Your Favorite City is ${this._selectedCity}')));
                                                        //     }
                                                        //   },
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                  bank != ""
                                                      ? Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text("Retail"),
                                                                ret.length > 0
                                                                    ? Container(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            150,
                                                                        child: ListView
                                                                            .builder(
                                                                          physics:
                                                                              BouncingScrollPhysics(),
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount:
                                                                              ret.length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            return ListTile(
                                                                              title: Text(ret[index].name),
                                                                              onTap: () {
                                                                                print(ret[index].name);
                                                                                setState(() {
                                                                                  bank = ret[index].name.toString();
                                                                                  bankCode = ret[index].code.toString();
                                                                                  bankLink = ret[index].redirectUrls!.last.url.toString();
                                                                                  bankType = ret[index].redirectUrls!.first.type.toString();
                                                                                });
                                                                              },
                                                                            );
                                                                          },
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        width:
                                                                            150,
                                                                        child:
                                                                            ListTile(
                                                                          title:
                                                                              Text(""),
                                                                        ),
                                                                      ),
                                                              ],
                                                            ),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                    "Corporate"),
                                                                cor.length > 0
                                                                    ? Container(
                                                                        color: Colors
                                                                            .white,
                                                                        width:
                                                                            150,
                                                                        child: ListView
                                                                            .builder(
                                                                          physics:
                                                                              NeverScrollableScrollPhysics(),
                                                                          shrinkWrap:
                                                                              true,
                                                                          itemCount:
                                                                              cor.length,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            return ListTile(
                                                                              title: Text(cor[index].name),
                                                                              onTap: () {
                                                                                print(cor[index].name);
                                                                                setState(() {
                                                                                  bank = cor[index].name.toString();
                                                                                  bankCode = cor[index].code.toString();
                                                                                  bankLink = cor[index].redirectUrls!.last.url.toString();
                                                                                  bankType = cor[index].redirectUrls!.first.type.toString();
                                                                                });
                                                                              },
                                                                            );
                                                                          },
                                                                        ),
                                                                      )
                                                                    : Container(
                                                                        width:
                                                                            150,
                                                                        child:
                                                                            ListTile(
                                                                          title:
                                                                              Text(""),
                                                                        ),
                                                                      ),
                                                              ],
                                                            ),
                                                          ],
                                                        )
                                                      : Container(),
                                                  bank != ""
                                                      ? Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                      "Anda memilih : "),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(bank +
                                                                      " "),
                                                                  Text(bankType
                                                                              .toString() ==
                                                                          "RET"
                                                                      ? "Retail"
                                                                      : bankType.toString() ==
                                                                              "COR"
                                                                          ? "Corporate"
                                                                          : ""),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      Row(
                        children: [
                          // Expanded(
                          //   flex: 3,
                          //   child: AddToCartButton(
                          //     onPressed: () async {
                          //       print("cart");
                          //       await cart("");
                          //       // checkCartable();
                          //       // print(cartable);
                          //       // for (var i = 0; i < _enquiryModel2.length; i++) {
                          //       //   if (_enquiryModel2[i].checked == true) {
                          //       //     print(_enquiryModel2[i].toString());
                          //       //   }
                          //       // }
                          //       // if (cartable == false) {
                          //       //   snack(context,
                          //       //       "Pembayaran serentak dibenarkan bagi bil-bil dibawah kategori yang sama sahaja.");
                          //       // }
                          //     },
                          //     icon: LineIcons.addToShoppingCart,
                          //   ),
                          // ),
                          // SizedBox(width: 10),
                          Expanded(
                            flex: 8,
                            child: PrimaryButton(
                              onPressed: () async => {await pay()},
                              text: 'Proceed Payment'.tr,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget marshalItems(List<dynamic> items) {
    log("Hello");
    print(items);
    List<Widget> childrens = [];
    for (var item in items.first.entries) {
      List<ServiceItem> serviceItems =
          (item.value as List).map((e) => ServiceItem.fromJson(e)).toList();
      // for (var serviceItem in serviceItems) {
      // if (serviceItem.totalPrice != 0 && serviceItem.quantity != 0)
      childrens.add(Text(item.key, style: styles.heading12title));
      // }
      for (var serviceItem in serviceItems) {
        if (serviceItem.totalPrice != 0 && serviceItem.quantity != 0)
          childrens.add(
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  serviceItem.unit ?? "",
                  style: styles.heading12,
                ),
                Text(
                  " RM " + serviceItem.price.toString(),
                  style: styles.heading12,
                ),
                Text(
                  " X " + serviceItem.quantity.toString(),
                  style: styles.heading12,
                ),
                Text(
                  " = RM " + serviceItem.totalPrice.toString(),
                  style: styles.heading12,
                ),
              ],
            ),
          );
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: childrens,
    );
  }

  pay() async {
    bool? value = await Get.defaultDialog<bool>(
      radius: 14,
      title: "",
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Icon(
            Icons.info,
            color: constants.eightColor,
            size: 50,
          ),
          SizedBox(height: 10),
          Text(
            "Teruskan Pembayaran ? ",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 10),
          Text(
            "Anda akan dibawa ke halaman gerbang pembayaran kami.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
      // middleText: "Teruskan Pembayaran?",
      textConfirm: "Ya",
      confirmTextColor: Colors.white,
      textCancel: "Tidak",
      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 20),
      onConfirm: () => Get.back(result: true),
    );

    if (value != null) {
      if (gateway == "DuitNow OBW") {
        gatewayMethod = "2";
      }
      print(_incompleteTransaction.id.toString());
      print(gatewayMethod.toString());
      print(bankCode.toString());
      print(bankLink.toString());
      print(bankType.toString());
      ErrorResponse response = await api.retryPayment(
          _incompleteTransaction.id.toString(),
          gatewayMethod,
          bankCode,
          bankLink,
          bankType);
      print("response.data");
      print(response.data);
      print("response.message");
      print(response.message);
      print("response.data[redirect]");
      print(response.data["redirect"]);

      if (response.data != null) {
        Payments payments = Payments.fromJson(response.data);
        print(gatewayMethod.toString());
        if (gatewayMethod.toString() == "3") {
          Uint8List bytes = Base64Decoder().convert(response.data["qr_image"]);

          Get.to(() => DuitnowQR(), arguments: {
            "payments": payments,
            "image": bytes,
          });
        } else {
          log("Reference Number: ${payments.redirect}");
          payments.referenceNumber =
              response.data["redirect"].toString().split("/").last;
          payments.amount = _incompleteTransaction.amount.toString();
          payments.paymentType = int.parse(gatewayMethod);
          Get.to(() => Payment(), arguments: payments);
        }
      }
    }
  }

  // Widget setupService(ServiceIncompletes service) {
  //   return Column(
  //     children: [
  //       for (var matrix in service.matrix!)
  //         Container(
  //           child: Text(matrix.name ?? ""),
  //         )
  //     ],
  //   );
  // }

  cart(String amount) async {
    //   print(_enquiryModel3.serviceId.toString());
    //   print(_enquiryModel3.referenceNumber.toString());
    //   print(_enquiryModel3.nettCalculations!.total.toString());
    //   print(_enquiryModel3.serviceId.toString());
    //   ErrorResponse response = await api.addToCartIkhwan(
    //       _enquiryModel3.serviceId.toString(),
    //       "",
    //       _enquiryModel3.referenceNumber!,
    //       amount == ""
    //           ? _enquiryModel3.nettCalculations!.total.toString()
    //           : amount,
    //       //
    //       "");
    //   print("response.data");
    //   print(response.message);
    //   print(response.data);
    //   print(response.isSuccessful);
    //   if (response.isSuccessful) {
    //     await snack(context, "Berjaya dimasukkan ke dalam troli");
    //   }
    //   Navigator.pop(context, true);
    // }
  }
}

List<String> getSuggestions(String query, List<String> _enquiryModel12) {
  _enquiryModel12 = _enquiryModel12.toSet().toList();
  List<String> matches = <String>[];
  matches.addAll(_enquiryModel12);

  matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  return matches;
}
