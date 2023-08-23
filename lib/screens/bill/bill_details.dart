import 'dart:convert';
import 'dart:developer';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/models/bills/bills.dart' as model;
import 'package:flutterbase/models/payments/payments.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../models/bills/bills.dart';
import '../home/duitnow_qr.dart';

import 'dart:math' as math;
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import '../../../helpers.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../home/payment.dart';

class BillDetailsScreen extends StatefulWidget {
  final enquiryModel2;
  final String amount;
  const BillDetailsScreen(this.enquiryModel2, this.amount, {Key? key})
      : super(key: key);

  @override
  State<BillDetailsScreen> createState() => _BillDetailsScreenState();
}

// List of Amoun changes "description": "GAJI BIASA KAKITANGAN KERAJAAN(HOSPITAL)",
class _BillDetailsScreenState extends State<BillDetailsScreen> {
  late model.Bill _enquiryModel3;
  var inputFormat = DateFormat('dd-MM-yyyy');
  bool alreadySaved = false;
  // ignore: unused_field
  List<model.Bill> _enquiryModel4 = [];
  // ignore: unused_field
  List<model.Bill> _enquiryModel5 = [];
  // ignore: unused_field
  List<model.Bill> _enquiryModel8 = [];
  // ignore: unused_field
  List<model.Bill> _enquiryModel9 = [];
  // ignore: unused_field
  List<model.Bill> _enquiryModel10 = [];
  List<model.PaymentGateway> _enquiryModel6 = [];
  List<model.Bank2> _enquiryModel7 = [];
  List<model.Bank2> _enquiryModel11 = [];
  String gateway = "Select Payment Method".tr;
  String bankText = "Select Bank or E-wallet".tr;
  String bank = "";
  String bankCode = "";
  String bankLink = "";
  String bankType = "";
  String gatewayMethod = "";
  final _formKey = GlobalKey<FormState>();
  String amount = "";
  Map a = {};
  final double initialValue = 0;
  final TextEditingController amount1 = TextEditingController(text: "0.00");
  late String amount2 = "";
  num roundingAmount = 0;
  final TextEditingController _typeAheadController = TextEditingController();
  late String _selectedCity;
  List<model.Bank2> cor = [];
  List<model.Bank2> ret = [];
  List<String> _enquiryModel12 = [];

  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    setState(() {
      _enquiryModel3 = widget.enquiryModel2;
      amount2 = widget.amount;
    });
    print(amount2.toString());
    if (amount2 != "") {
      a = {};
      a = await api.GetRounding(amount2);
      setState(() {
        a = a;
      });
      double test = 0.00;
      test = double.parse(amount2) + a['value'];
      print(test.toString());
      setState(() {
        amount2 = test.toStringAsFixed(2).toString();

        amount = amount2.toString();
      });
      print(a.isNotEmpty);
      print(a['value']);
      setState(() {
        roundingAmount = a['value'];
      });
      print(amount);
    }

    // _enquiryModel4 = await api.GetBills("", "1");
    // _enquiryModel5 = await api.GetBills("", "2");
    // _enquiryModel8 = await api.GetBills("", "3");
    // _enquiryModel9 = await api.GetBills("", "4");
    // _enquiryModel10 = await api.GetBills("", "5");

    _enquiryModel6 = await api.GetPaymentGateway();
    _enquiryModel7 = await api.GetPaynetBank();
    print(_enquiryModel3.id);

    // for (var i = 0; i < _enquiryModel4.length; i++) {
    //   if (_enquiryModel4[i].id == _enquiryModel3.id) {
    //     setState(() {
    //       _enquiryModel3 = _enquiryModel4[i];
    //     });
    //   }
    // }
    // for (var o = 0; o < _enquiryModel5.length; o++) {
    //   if (_enquiryModel5[o].id == _enquiryModel3.id) {
    //     setState(() {
    //       _enquiryModel3 = _enquiryModel5[o];
    //     });
    //   }
    // }
    // for (var o = 0; o < _enquiryModel8.length; o++) {
    //   if (_enquiryModel8[o].id == _enquiryModel3.id) {
    //     setState(() {
    //       _enquiryModel3 = _enquiryModel8[o];
    //     });
    //   }
    // }
    // for (var o = 0; o < _enquiryModel9.length; o++) {
    //   if (_enquiryModel9[o].id == _enquiryModel3.id) {
    //     setState(() {
    //       _enquiryModel3 = _enquiryModel9[o];
    //     });
    //   }
    // }
    // for (var o = 0; o < _enquiryModel10.length; o++) {
    //   if (_enquiryModel10[o].id == _enquiryModel3.id) {
    //     setState(() {
    //       _enquiryModel3 = _enquiryModel10[o];
    //     });
    //   }
    // }

    setState(() {
      _enquiryModel7 = _enquiryModel7;
    });

    _enquiryModel7.removeWhere((item) => item.url == "");

    setState(() {
      _enquiryModel7 = _enquiryModel7;
    });

    // for (var v = 0; v < _enquiryModel7.length; v++) {
    //   for (var q = 0; q < _enquiryModel7[v].url!.length - 1; q++) {
    //     if (_enquiryModel7[v].redirectUrls!.length == 2) {
    //       if (_enquiryModel7[v].redirectUrls![q].type ==
    //               _enquiryModel7[v].redirectUrls![q + 1].type ||
    //           _enquiryModel7[v].redirectUrls![q].type == " " ||
    //           _enquiryModel7[v].redirectUrls![q + 1].type == " ") {
    //         _enquiryModel7[v].redirectUrls!.removeLast();
    //       }
    //     }
    //   }
    // }
    setState(() {
      _enquiryModel7 = _enquiryModel7;
    });

    _enquiryModel7.sort((a, b) {
      return a.name!.toLowerCase().compareTo(b.name!.toLowerCase());
    });

    for (var v = 0; v < _enquiryModel7.length; v++) {
      _enquiryModel11.add(
        Bank2(),
      );
    }

    for (var v = 0; v < _enquiryModel7.length; v++) {
      _enquiryModel12.add(_enquiryModel7[v].name!);
    }

    // Future.delayed(const Duration(seconds: 0)).then(
    //   (value) => setState(
    //     () {
    Navigator.pop(context);
    //     },
    //   ),
    // );
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
          "Bill Details".tr,
          style: styles.heading5,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(_enquiryModel3.isFavorite == RxBool(true) ||
                      // ignore: unrelated_type_equality_checks
                      _enquiryModel3.isFavorite.value == true
                  ? Icons.favorite
                  : Icons.favorite_border),
              color: Constants().primaryColor,
              onPressed: () async {
                await api.favABill(_enquiryModel3.id.toString());
                _enquiryModel3.isFavorite == RxBool(true)
                    ? snack(
                        context, "Removed to favourite list successfully.".tr,
                        level: SnackLevel.Error)
                    : snack(context, "Added to favourite list successfully.".tr,
                        level: SnackLevel.Success);
                initApp();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  // elevation: 10,
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
                      // ListTile(
                      //   title: Text(
                      //     "No",
                      //     style: styles.heading12bold,
                      //   ),
                      //   subtitle: Padding(
                      //     padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                      //     child: Text(
                      //       _enquiryModel3.id!.toString(),
                      //       style: styles.heading12sub,
                      //     ),
                      //   ),
                      // ),
                      ListTile(
                        title: Text(
                          _enquiryModel3.service.refNoLabel.toString(),
                          style: styles.heading12bold,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            _enquiryModel3.referenceNumber!.toString(),
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "iPayment Ref. No.".tr,
                          style: styles.heading12bold,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            _enquiryModel3.billNumber!.toString(),
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Bill Reference Date".tr,
                          style: styles.heading12bold,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            _enquiryModel3.startAt.toString() != "null"
                                ? formatDate(
                                    DateTime.parse(
                                        _enquiryModel3.startAt.toString()),
                                    [dd, '/', mm, '/', yyyy],
                                  )
                                : "No date".tr,
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Due On".tr,
                          style: styles.heading12bold,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            _enquiryModel3.endAt.toString() != "null"
                                ? formatDate(
                                    DateTime.parse(
                                        _enquiryModel3.endAt.toString()),
                                    [dd, '/', mm, '/', yyyy],
                                  )
                                : "No date".tr,
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      _enquiryModel3.identityCodeCategory == "Organisasi"
                          ? ListTile(
                              title: Text(
                                "Customer Name".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                                child: Text(
                                  _enquiryModel3.customerName.toString(),
                                  style: styles.heading12sub,
                                ),
                              ),
                            )
                          : Container(),
                      ListTile(
                        title: Text(
                          "Payment Details".tr,
                          style: styles.heading12bold,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            _enquiryModel3.detail.toString(),
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Agency".tr,
                          style: styles.heading12bold,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            _enquiryModel3.agency.name,
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Department".tr,
                          style: styles.heading12bold,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            _enquiryModel3.agency.department.departmentName,
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text(
                          "Ministry".tr,
                          style: styles.heading12bold,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            _enquiryModel3.agency.ministry.ministryName!,
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      // ListTile(
                      //   title: Text(
                      //     "Service Category".tr,
                      //     style: styles.heading12bold,
                      //   ),
                      //   subtitle: Padding(
                      //     padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                      //     child: Text(
                      //       _enquiryModel3.service!.serviceCategory!,
                      //       style: styles.heading12sub,
                      //     ),
                      //   ),
                      // ),
                      // ListTile(
                      //   title: Text(
                      //     "User Category".tr,
                      //     style: styles.heading12bold,
                      //   ),
                      //   subtitle: Padding(
                      //     padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                      //     child: Text(
                      //       _enquiryModel3.customer == null
                      //           ? "Customer".tr
                      //           // ignore: dead_code
                      //           : "Goverment".tr,
                      //       style: styles.heading12sub,
                      //     ),
                      //   ),
                      // ),
                      ListTile(
                        title: Text(
                          "Transaction Charged To".tr,
                          style: styles.heading12bold,
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            _enquiryModel3.service.chargedTo!.toString() ==
                                    "Kerajaan"
                                ? "Goverment".tr
                                : "Customer".tr,
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                      // _enquiryModel3.service!.chargedTo!.toString() ==
                      //         "Pelanggan"
                      //     ? ListTile(
                      //         leading: Icon(Icons.info),
                      //         title: Text(
                      //           "Transaction Charged To Customer".tr,
                      //           style: styles.heading12bold,
                      //         ),
                      //       )
                      //     : Container(),

                      _enquiryModel3.customerNote.toString() == "null" ||
                              _enquiryModel3.customerNote.toString() == ""
                          ? Container()
                          : ListTile(
                              title: Text(
                                "Note to payer".tr,
                                style: styles.heading12bold,
                              ),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                                child: Text(
                                  _enquiryModel3.customerNote.toString(),
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
                          padding: const EdgeInsets.fromLTRB(0, 8.0, 8.0, 8.0),
                          child: Text(
                            _enquiryModel3.status!.toString() == "Aktif"
                                ? "Active".tr
                                : "Inactive".tr,
                            style: styles.heading12sub,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //  _enquiryModel3.status == "Aktif" && _enquiryModel3.billTypeId == 1
              _enquiryModel3.status == "Aktif" && _enquiryModel3.billTypeId == 1
                  ? Padding(
                      padding: const EdgeInsets.all(10),
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
                                    padding: const EdgeInsets.only(bottom: 1.0),
                                    child: Text(
                                      "Payment Summary".tr,
                                      style: styles.heading5bold,
                                    ),
                                  ),
                                  // Row(
                                  //   mainAxisAlignment:
                                  //       MainAxisAlignment.spaceBetween,
                                  //   children: [
                                  //     Text(
                                  //       "Subtotal Amount".tr,
                                  //       style: styles.heading12bold,
                                  //     ),
                                  //     Text(
                                  //       "RM " +
                                  //           _enquiryModel3
                                  //               .nettCalculations!.original!
                                  //               .toString(),
                                  //       style: styles.heading12bold,
                                  //     )
                                  //   ],
                                  // ),

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

                                  // _enquiryModel3.nettCalculations?.rounding!
                                  //             !=
                                  //        0
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
                                  //       "Payment Total".tr,
                                  //       style: styles.heading12bold,
                                  //     ),
                                  //     Text(
                                  //       "RM " +
                                  //           _enquiryModel3
                                  //               .nettCalculations!.total
                                  //               .toString(),
                                  //       style: styles.heading12bold,
                                  //     )
                                  //   ],
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: ExpansionTile(
                                      title: Text(
                                        'Payment Total'.tr,
                                        style: styles.heading12bold,
                                      ),
                                      subtitle: Text(
                                        'RM ' +
                                            _enquiryModel3
                                                .nettCalculations.total
                                                .toStringAsFixed(2)
                                                .toString(),
                                        style: styles.heading12bold,
                                      ),
                                      children: [
                                        ExpansionTile(
                                          title: Text(
                                            "Subtotal Amount".tr,
                                            style: styles.heading12bold,
                                          ),
                                          subtitle: Text(
                                            _enquiryModel3.nettCalculations
                                                        .original
                                                        .toString() ==
                                                    "0"
                                                ? "RM " +
                                                    _enquiryModel3
                                                        .nettCalculations
                                                        .original
                                                        .toStringAsFixed(2)
                                                        .toString()
                                                : "RM " +
                                                    _enquiryModel3
                                                        .nettCalculations
                                                        .original
                                                        .toStringAsFixed(2)
                                                        .toString(),
                                            style: styles.heading12bold,
                                          ),
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: ListView.builder(
                                                  reverse: true,
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  shrinkWrap: true,
                                                  itemCount: _enquiryModel3
                                                      .chargelines.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Text(
                                                      _enquiryModel3
                                                          .chargelines[index]
                                                          .classificationCode
                                                          .description
                                                          .toString(),
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        //Payments
                                        _enquiryModel3.payments.length != 0
                                            ? Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "List of bil payments".tr,
                                                  style: styles.heading12bold,
                                                ),
                                              )
                                            : Container(),
                                        _enquiryModel3.payments.length != 0
                                            ? ListView.builder(
                                                reverse: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: _enquiryModel3
                                                    .payments.length,
                                                itemBuilder: (context, indexA) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "Date".tr,
                                                          style: styles
                                                              .heading11bold,
                                                        ),
                                                        Text(
                                                          _enquiryModel3
                                                                      .payments[
                                                                          indexA]
                                                                      .receiptDocumentDate
                                                                      .toString() !=
                                                                  'null'
                                                              ? formatDate(
                                                                  DateTime.parse(_enquiryModel3
                                                                      .payments[
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
                                                                )
                                                              : '-',
                                                        ),
                                                        Text(
                                                          "Receipt Number".tr,
                                                          style: styles
                                                              .heading11bold,
                                                        ),
                                                        Text(
                                                            _enquiryModel3
                                                                .payments[
                                                                    indexA]
                                                                .referenceNumber
                                                                .toString(),
                                                            style: styles
                                                                .heading11),
                                                        Text(
                                                          "Amount".tr,
                                                          style: styles
                                                              .heading11bold,
                                                        ),
                                                        Text(
                                                            "RM " +
                                                                moneyFormat(double.parse(
                                                                    _enquiryModel3
                                                                        .payments[
                                                                            indexA]
                                                                        .amount
                                                                        .toString())),
                                                            style: styles
                                                                .heading11),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              )
                                            : Container(),
                                        _enquiryModel3.nettCalculations
                                                    .roundingData
                                                    .toString() !=
                                                "null"
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Rounding Value".tr,
                                                    style: styles.heading12bold,
                                                  ),
                                                  Text(
                                                    "RM " +
                                                        moneyFormat(
                                                            double.parse(
                                                          _enquiryModel3
                                                              .nettCalculations
                                                              .roundingData
                                                              .amount
                                                              .toString(),
                                                        )),
                                                    style: styles.heading12bold,
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        // Amount Changes
                                        _enquiryModel3.amountChanges.length != 0
                                            ? Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "List of amount changes".tr,
                                                  style: styles.heading12bold,
                                                ),
                                              )
                                            : Container(),
                                        _enquiryModel3.amountChanges.length != 0
                                            ? ListView.builder(
                                                reverse: true,
                                                physics:
                                                    BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: _enquiryModel3
                                                    .amountChanges.length,
                                                itemBuilder: (context, indexA) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "Date".tr,
                                                          style: styles
                                                              .heading11bold,
                                                        ),
                                                        Text(
                                                            formatDate(
                                                              DateTime.parse(_enquiryModel3
                                                                  .amountChanges[
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
                                                            style: styles
                                                                .heading11),
                                                        Text(
                                                          "Reference Number".tr,
                                                          style: styles
                                                              .heading11bold,
                                                        ),
                                                        Text(
                                                            _enquiryModel3
                                                                .amountChanges[
                                                                    indexA]
                                                                .referenceNumber
                                                                .toString(),
                                                            style: styles
                                                                .heading11),
                                                        Text(
                                                          "Amount".tr,
                                                          style: styles
                                                              .heading11bold,
                                                        ),
                                                        Text(
                                                            "RM " +
                                                                moneyFormat(
                                                                    double
                                                                        .parse(
                                                                  _enquiryModel3
                                                                      .amountChanges[
                                                                          indexA]
                                                                      .amount
                                                                      .toString(),
                                                                )),
                                                            style: styles
                                                                .heading11),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
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
                                                      backgroundColor: constants
                                                          .secondaryColor,
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
                                                          icon: Icon(Icons
                                                              .close_rounded),
                                                        )
                                                      ],
                                                    ),
                                                    ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            _enquiryModel6
                                                                .length,
                                                        //  _organizationModel.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ListTile(
                                                            leading: _enquiryModel6[
                                                                            index]
                                                                        .logo !=
                                                                    null
                                                                ? Image.network(
                                                                    "https://internal-ipayment.anm.gov.my/storage/" +
                                                                        _enquiryModel6[index]
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
                                                                        Icons
                                                                            .money,
                                                                        size:
                                                                            30,
                                                                      );
                                                                    },
                                                                  )
                                                                : Container(
                                                                    width: 1,
                                                                    height: 1,
                                                                  ),
                                                            title: Text(
                                                                _enquiryModel6[
                                                                        index]
                                                                    .title!),
                                                            onTap: () {
                                                              print(
                                                                  _enquiryModel6[
                                                                          index]
                                                                      .title!);
                                                              print(
                                                                  _enquiryModel6[
                                                                          index]
                                                                      .id!);
                                                              setState(() {
                                                                gateway = _enquiryModel6[
                                                                        index]
                                                                    .title!
                                                                    .toString();
                                                                gatewayMethod =
                                                                    _enquiryModel6[
                                                                            index]
                                                                        .id
                                                                        .toString();
                                                              });
                                                              Get.back();
                                                            },
                                                          );
                                                        })
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
                          gatewayMethod == "11" || gatewayMethod == "2"
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Text(
                                        "List of banks".tr,
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
                                          //   child: Icon(
                                          //       Icons.location_city_rounded),
                                          // ),
                                          Flexible(
                                            fit: FlexFit.tight,
                                            flex: 5,
                                            child: Text(
                                              bank,
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
                                                            constants
                                                                .secondaryColor,
                                                        centerTitle: true,
                                                        leading: Container(),
                                                        title: Text(
                                                          "Selection of Banks"
                                                              .tr,
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
                                                            icon: Icon(Icons
                                                                .close_rounded),
                                                          )
                                                        ],
                                                      ),
                                                      ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            _enquiryModel11
                                                                .length,
                                                        //  _organizationModel.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return _enquiryModel11[
                                                                          index]
                                                                      .url !=
                                                                  ""
                                                              ? ListTile(
                                                                  // leading:
                                                                  //  _enquiryModel6[
                                                                  //                 index]
                                                                  //             .logo !=
                                                                  //         ""
                                                                  //     ? _enquiryModel6[
                                                                  //             index]
                                                                  //         .logo
                                                                  //     :
                                                                  // Icon(Icons
                                                                  //     .money),
                                                                  title: Text(
                                                                      _enquiryModel11[
                                                                              index]
                                                                          .name!),
                                                                  onTap: () {
                                                                    print(_enquiryModel11[
                                                                            index]
                                                                        .name);
                                                                    setState(
                                                                        () {
                                                                      bank = _enquiryModel11[
                                                                              index]
                                                                          .name
                                                                          .toString();
                                                                      bankCode = _enquiryModel11[
                                                                              index]
                                                                          .code
                                                                          .toString();
                                                                      bankLink = _enquiryModel11[
                                                                              index]
                                                                          .url
                                                                          .toString();
                                                                      bankType = _enquiryModel11[
                                                                              index]
                                                                          .type
                                                                          .toString();
                                                                    });
                                                                    print(bank
                                                                        .toString());
                                                                    print(bankCode
                                                                        .toString());
                                                                    print(bankLink
                                                                        .toString());
                                                                    print(bankType
                                                                        .toString());
                                                                    Get.back();
                                                                  },
                                                                )
                                                              : Container();
                                                        },
                                                      )
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
                                    ),
                                  ],
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: AddToCartButton(
                                  onPressed: () async {
                                    print("cart");

                                    if (_enquiryModel3.status == "Aktif" &&
                                        _enquiryModel3.billTypeId == 1) {
                                      await cart("");
                                    } else {
                                      await cart(amount);
                                    }

                                    // checkCartable();
                                    // print(cartable);
                                    // for (var i = 0; i < _enquiryModel2.length; i++) {
                                    //   if (_enquiryModel2[i].checked == true) {
                                    //     print(_enquiryModel2[i].toString());
                                    //   }
                                    // }
                                    // if (cartable == false) {
                                    //   snack(context,
                                    //       "Pembayaran serentak dibenarkan bagi bil-bil dibawah kategori yang sama sahaja.");
                                    // }
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                flex: 8,
                                child: PrimaryButton(
                                  onPressed: () async => {await pay()},
                                  text: 'Pay'.tr,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : _enquiryModel3.status == "Aktif" &&
                          _enquiryModel3.billTypeId == 2
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    // controller: amount1,
                                    initialValue: amount2,
                                    autocorrect: false,
                                    inputFormatters: <TextInputFormatter>[
                                      CurrencyTextInputFormatter(
                                        decimalDigits: 2,
                                        symbol: '',
                                      ),
                                    ],
                                    // inputFormatters: [
                                    // DecimalTextInputFormatter(decimalRange: 2)
                                    // WhitelistingTextInputFormatter(
                                    //     RegExp(r'^\d+\.?\d{0,2}')),
                                    // FilteringTextInputFormatter.allow(
                                    //     RegExp(r'^\d+\.?\d{0,2}')),
                                    // ],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: styles.inputDecoration.copyWith(
                                      label: getRequiredLabel('Amount (RM)'.tr),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter amount.'.tr;
                                      }
                                      return null;
                                    },
                                    onChanged: (val) async {
                                      print("val " + val.toString());
                                      if (val != "" && val.length > 1) {
                                        val = val.replaceAll(",", "");
                                        a = {};
                                        a = await api.GetRounding(val);
                                        setState(() {
                                          a = a;
                                        });
                                        double test = 0.00;
                                        test = double.parse(val) + a['value'];
                                        print(test.toString());
                                        setState(() {
                                          val = test
                                              .toStringAsFixed(2)
                                              .toString();

                                          amount = val.toString();
                                        });
                                        print(a.isNotEmpty);
                                        print("a['value']");
                                        print(a['value']);
                                        setState(() {
                                          roundingAmount = a['value'];
                                        });
                                        print('amount');
                                        print(amount);
                                        if (val == "") {
                                          print("empty 1");
                                          amount = "";
                                        }
                                      } else if (val.length == 0) {
                                        print("empty 2");
                                        Future.delayed(
                                                const Duration(seconds: 1))
                                            .then((value) => setState(() {
                                                  amount = "";
                                                }));
                                      } else if (val == "") {
                                        amount = "";
                                      } else {
                                        setState(() {
                                          amount = "";
                                        });
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  roundingAmount != 0
                                      ? ListTile(
                                          leading: Icon(Icons.info),
                                          title: Text(
                                            "The amount is adjusted based on the Malaysia Treasury Circular."
                                                .tr,
                                            style: styles.heading12sub2,
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Payment Total'.tr + ":",
                                        style: styles.heading12bold,
                                      ),
                                      amount != ""
                                          ? Text(
                                              'RM ' +
                                                  moneyFormat(
                                                      double.parse(amount)),
                                              style: styles.heading12bold,
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  amount != ""
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ExpansionTile(
                                            title: Text(
                                              'Payment Total'.tr,
                                              style: styles.heading12bold,
                                            ),
                                            subtitle: amount != ""
                                                ? Text(
                                                    'RM ' +
                                                        moneyFormat(
                                                            double.parse(
                                                                amount)),
                                                    style: styles.heading12bold,
                                                  )
                                                : Container(),
                                            children: [
                                              ExpansionTile(
                                                title: Text(
                                                  "Subtotal Amount".tr,
                                                  style: styles.heading12bold,
                                                ),
                                                subtitle: Text(
                                                  _enquiryModel3
                                                              .nettCalculations
                                                              .original
                                                              .toString() ==
                                                          "0"
                                                      ? "RM " +
                                                          _enquiryModel3
                                                              .nettCalculations
                                                              .original
                                                              .toStringAsFixed(
                                                                  2)
                                                              .toString()
                                                      : "RM " +
                                                          moneyFormat(double.parse(
                                                              _enquiryModel3
                                                                  .nettCalculations
                                                                  .original
                                                                  .toString())),
                                                  style: styles.heading12bold,
                                                ),
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: ListView.builder(
                                                        reverse: true,
                                                        physics:
                                                            BouncingScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            _enquiryModel3
                                                                .chargelines
                                                                .length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Text(
                                                            _enquiryModel3
                                                                .chargelines[
                                                                    index]
                                                                .classificationCode
                                                                .description
                                                                .toString(),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              //Payments
                                              _enquiryModel3.payments.length !=
                                                      0
                                                  ? Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        "List of bil payments"
                                                            .tr,
                                                        style: styles
                                                            .heading12bold,
                                                      ),
                                                    )
                                                  : Container(),
                                              _enquiryModel3.payments.length !=
                                                      0
                                                  ? ListView.builder(
                                                      reverse: true,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: _enquiryModel3
                                                          .payments.length,
                                                      itemBuilder:
                                                          (context, indexA) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                "Date".tr,
                                                                style: styles
                                                                    .heading11bold,
                                                              ),
                                                              Text(
                                                                  formatDate(
                                                                    DateTime.parse(_enquiryModel3
                                                                        .payments[
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
                                                                  style: styles
                                                                      .heading11),
                                                              // "id": 104,
                                                              // "payment_id": 85,
                                                              // "user_id": 111,
                                                              // "reference_number": "B2306S00005000005 - BP01",
                                                              // "agency_reference_number": "T2306AFP030000000079",
                                                              // "receipt_number": "RN230642070401000031",
                                                              // "receipt_number_sap": null,
                                                              // "receipt_year": "2023",
                                                              // "receipt_document_date": "2023-06-26",
                                                              // "receipt_note": null,
                                                              // "receipt_amount_igfmas": null,
                                                              // "payment_date": "2023-06-26",
                                                              // "source": "portal",
                                                              // "status": "Aktif",
                                                              // "cashier_name": "",
                                                              // "first_approver_id": null,
                                                              // "second_approver_id": null,
                                                              // "first_approval_at": null,
                                                              // "second_approval_at": null,
                                                              // "task_at": null,
                                                              // "amount": "100.00",
                                                              // "created_at": "2023-06-26T00:17:04.000000Z",
                                                              // "updated_at": "2023-06-26T00:17:04.000000Z"

                                                              //  "id": 55,
                                                              // "payment_id": 485,
                                                              // "payment_chargeline_id": 562,
                                                              // "user_id": 181,
                                                              // "reference_number": "PAB2306S00005000046 - PA01",
                                                              // "agency_reference_number": "MOH1222344",
                                                              // "agency_approval_date": "2023-06-26",
                                                              // "change_amount_reason": "Cukai",
                                                              // "source": "Kunci Masuk",
                                                              // "status": "Aktif",
                                                              // "first_approver_id": 55,
                                                              // "second_approver_id": null,
                                                              // "first_approval_at": "2023-06-26 08:13:24",
                                                              // "second_approval_at": null,
                                                              // "task_at": "2023-06-26 08:13:24",
                                                              // "amount": "3.00",
                                                              // "created_at": "2023-06-26T00:11:10.000000Z",
                                                              // "updated_at": "2023-06-26T00:13:24.000000Z"
                                                              Text(
                                                                "Receipt Number"
                                                                    .tr,
                                                                style: styles
                                                                    .heading11bold,
                                                              ),
                                                              Text(
                                                                  _enquiryModel3
                                                                      .payments[
                                                                          indexA]
                                                                      .referenceNumber
                                                                      .toString(),
                                                                  style: styles
                                                                      .heading11),
                                                              Text(
                                                                "Amount".tr,
                                                                style: styles
                                                                    .heading11bold,
                                                              ),
                                                              Text(
                                                                  "RM " +
                                                                      moneyFormat(double.parse(_enquiryModel3
                                                                          .payments[
                                                                              indexA]
                                                                          .amount
                                                                          .toString())),
                                                                  style: styles
                                                                      .heading11),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Container(),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                    "Rounding Value".tr,
                                                    style: styles.heading12bold,
                                                  ),
                                                  Text(
                                                    roundingAmount.toString() ==
                                                            "0"
                                                        ? "RM " +
                                                            roundingAmount
                                                                .toStringAsFixed(
                                                                    2)
                                                                .toString()
                                                        : "RM " +
                                                            roundingAmount
                                                                .toStringAsFixed(
                                                                    2)
                                                                .toString(),
                                                    style: styles.heading12bold,
                                                  ),
                                                ],
                                              ),
                                              // Amount Changes
                                              _enquiryModel3.amountChanges
                                                          .length !=
                                                      0
                                                  ? Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        "List of amount changes"
                                                            .tr,
                                                        style: styles
                                                            .heading12bold,
                                                      ),
                                                    )
                                                  : Container(),
                                              _enquiryModel3.amountChanges
                                                          .length !=
                                                      0
                                                  ? ListView.builder(
                                                      reverse: true,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: _enquiryModel3
                                                          .amountChanges.length,
                                                      itemBuilder:
                                                          (context, indexA) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                "Date".tr,
                                                                style: styles
                                                                    .heading11bold,
                                                              ),
                                                              Text(
                                                                  formatDate(
                                                                    DateTime.parse(_enquiryModel3
                                                                        .amountChanges[
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
                                                                  style: styles
                                                                      .heading11),
                                                              Text(
                                                                "Reference Number"
                                                                    .tr,
                                                                style: styles
                                                                    .heading11bold,
                                                              ),
                                                              Text(
                                                                  _enquiryModel3
                                                                      .amountChanges[
                                                                          indexA]
                                                                      .referenceNumber
                                                                      .toString(),
                                                                  style: styles
                                                                      .heading11),
                                                              Text(
                                                                "Amount".tr,
                                                                style: styles
                                                                    .heading11bold,
                                                              ),
                                                              Text(
                                                                  "RM " +
                                                                      moneyFormat(double.parse(_enquiryModel3
                                                                          .amountChanges[
                                                                              indexA]
                                                                          .amount
                                                                          .toString())),
                                                                  style: styles
                                                                      .heading11),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Divider(),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Text(
                                        "Payment Method".tr,
                                        style: styles.heading5bold,
                                      ),
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
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5.0),
                                            child: Text(
                                              gateway,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black38),
                                            ),
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
                                                      backgroundColor: constants
                                                          .secondaryColor,
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
                                                          icon: Icon(Icons
                                                              .close_rounded),
                                                        )
                                                      ],
                                                    ),
                                                    ListView.builder(
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            _enquiryModel6
                                                                .length,
                                                        //  _organizationModel.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ListTile(
                                                            leading: _enquiryModel6[
                                                                            index]
                                                                        .logo !=
                                                                    null
                                                                ? Image.network(
                                                                    "https://internal-ipayment.anm.gov.my/storage/" +
                                                                        _enquiryModel6[index]
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
                                                                        Icons
                                                                            .money,
                                                                        size:
                                                                            30,
                                                                      );
                                                                    },
                                                                  )
                                                                : Container(
                                                                    width: 1,
                                                                    height: 1,
                                                                  ),
                                                            title: _enquiryModel6[
                                                                            index]
                                                                        .title !=
                                                                    ""
                                                                ? Text(
                                                                    _enquiryModel6[
                                                                            index]
                                                                        .title!)
                                                                : Text(
                                                                    "No title"),
                                                            onTap: () {
                                                              print(
                                                                  _enquiryModel6[
                                                                          index]
                                                                      .title!);
                                                              setState(() {
                                                                gateway = _enquiryModel6[
                                                                        index]
                                                                    .title!
                                                                    .toString();
                                                                gatewayMethod =
                                                                    _enquiryModel6[
                                                                            index]
                                                                        .id
                                                                        .toString();
                                                              });
                                                              Get.back();
                                                            },
                                                          );
                                                        })
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
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  gatewayMethod == "11" || gatewayMethod == "2"
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 8.0),
                                              child: Text(
                                                "List of Banks/E-wallet".tr,
                                                style: styles.heading5bold,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    Constants().secondaryColor,
                                                border: Border.all(
                                                  color: Constants()
                                                      .secondaryColor,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              child: Flex(
                                                direction: Axis.horizontal,
                                                children: [
                                                  Flexible(
                                                    fit: FlexFit.tight,
                                                    flex: 6,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 1.0),
                                                      child: SizedBox(
                                                        height: 250,
                                                        child: ListView(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(1.0),
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  TypeAheadFormField(
                                                                      textFieldConfiguration:
                                                                          TextFieldConfiguration(
                                                                        controller:
                                                                            this._typeAheadController,
                                                                        decoration:
                                                                            InputDecoration(labelText: bankText),
                                                                      ),
                                                                      suggestionsCallback:
                                                                          (pattern) {
                                                                        return getSuggestions(
                                                                            pattern,
                                                                            _enquiryModel12);
                                                                      },
                                                                      itemBuilder:
                                                                          (context,
                                                                              suggestion) {
                                                                        return ListTile(
                                                                          title:
                                                                              Text(
                                                                            suggestion.toString(),
                                                                          ),
                                                                        );
                                                                      },
                                                                      transitionBuilder: (context,
                                                                          suggestionsBox,
                                                                          controller) {
                                                                        return suggestionsBox;
                                                                      },
                                                                      onSuggestionSelected:
                                                                          (suggestion) {
                                                                        this._typeAheadController.text =
                                                                            suggestion.toString();
                                                                        setState(
                                                                            () {
                                                                          bank =
                                                                              suggestion.toString();
                                                                        });
                                                                        print(" ad " +
                                                                            suggestion.toString());
                                                                        setState(
                                                                            () {
                                                                          cor =
                                                                              [];
                                                                          ret =
                                                                              [];
                                                                        });

                                                                        for (var v =
                                                                                0;
                                                                            v < _enquiryModel7.length;
                                                                            v++) {
                                                                          if (_enquiryModel7[v].name ==
                                                                              suggestion.toString()) {
                                                                            print("yes");
                                                                            print(_enquiryModel7[v].name);
                                                                            if (_enquiryModel7[v].type.toString() ==
                                                                                "RET") {
                                                                              ret.add(
                                                                                Bank2(
                                                                                  code: _enquiryModel7[v].code,
                                                                                  name: _enquiryModel7[v].name,
                                                                                  redirectUrls: [
                                                                                    RedirectUrl(type: _enquiryModel7[v].type, url: _enquiryModel7[v].url)
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }
                                                                            if (_enquiryModel7[v].type.toString() ==
                                                                                "COR") {
                                                                              cor.add(
                                                                                Bank2(
                                                                                  code: _enquiryModel7[v].code,
                                                                                  name: _enquiryModel7[v].name,
                                                                                  redirectUrls: [
                                                                                    RedirectUrl(type: _enquiryModel7[v].type, url: _enquiryModel7[v].url)
                                                                                  ],
                                                                                ),
                                                                              );
                                                                            }
                                                                            setState(() {
                                                                              ret = ret;
                                                                              cor = cor;
                                                                            });
                                                                          }
                                                                        }
                                                                        print("ret.length.toString()" +
                                                                            ret.length.toString());
                                                                        print("cor.length.toString()" +
                                                                            cor.length.toString());
                                                                      },
                                                                      validator:
                                                                          (value) {
                                                                        if (value!
                                                                            .isEmpty) {
                                                                          return 'Please select a bank';
                                                                        }
                                                                        return 'Please select a bank';
                                                                      },
                                                                      onSaved:
                                                                          (value) {
                                                                        print(value
                                                                            .toString());
                                                                        setState(
                                                                            () {
                                                                          this._selectedCity =
                                                                              value!;
                                                                        });

                                                                        print(this
                                                                            ._selectedCity
                                                                            .toString());
                                                                      }),
                                                                  SizedBox(
                                                                    height:
                                                                        10.0,
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
                                                                          Text(
                                                                              "Retail"),
                                                                          ret.length > 0
                                                                              ? Container(
                                                                                  color: Colors.white,
                                                                                  width: 150,
                                                                                  child: ListView.builder(
                                                                                    physics: BouncingScrollPhysics(),
                                                                                    shrinkWrap: true,
                                                                                    itemCount: ret.length,
                                                                                    itemBuilder: (context, index) {
                                                                                      return ListTile(
                                                                                        title: Text(ret[index].name!),
                                                                                        onTap: () {
                                                                                          print(ret[index].name);
                                                                                          setState(() {
                                                                                            bank = ret[index].name.toString();
                                                                                            bankCode = ret[index].code.toString();
                                                                                            bankLink = ret[index].url.toString();
                                                                                            bankType = ret[index].type.toString();
                                                                                          });
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                )
                                                                              : Container(
                                                                                  width: 150,
                                                                                  child: ListTile(
                                                                                    title: Text(""),
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
                                                                                  color: Colors.white,
                                                                                  width: 150,
                                                                                  child: ListView.builder(
                                                                                    physics: NeverScrollableScrollPhysics(),
                                                                                    shrinkWrap: true,
                                                                                    itemCount: cor.length,
                                                                                    itemBuilder: (context, index) {
                                                                                      return ListTile(
                                                                                        title: Text(cor[index].name!),
                                                                                        onTap: () {
                                                                                          print(cor[index].name);
                                                                                          setState(() {
                                                                                            bank = cor[index].name.toString();
                                                                                            bankCode = cor[index].code.toString();
                                                                                            bankLink = cor[index].url.toString();
                                                                                            bankType = cor[index].type.toString();
                                                                                          });
                                                                                        },
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                )
                                                                              : Container(
                                                                                  width: 150,
                                                                                  child: ListTile(
                                                                                    title: Text(""),
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
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Text("Anda memilih : "),
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(bank +
                                                                                " "),
                                                                            Text(bankType.toString() == "RET"
                                                                                ? "Retail"
                                                                                : bankType.toString() == "COR"
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
                                          ],
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: AddToCartButton(
                                          onPressed: () async {
                                            print("cart");
                                            if (_formKey.currentState!
                                                .validate()) {
                                              print(amount);
                                              await cart(amount);
                                            }

                                            // checkCartable();
                                            // print(cartable);
                                            // for (var i = 0; i < _enquiryModel2.length; i++) {
                                            //   if (_enquiryModel2[i].checked == true) {
                                            //     print(_enquiryModel2[i].toString());
                                            //   }
                                            // }
                                            // if (cartable == false) {
                                            //   snack(context,
                                            //       "Pembayaran serentak dibenarkan bagi bil-bil dibawah kategori yang sama sahaja.");
                                            // }
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        flex: 8,
                                        child: PrimaryButton(
                                          onPressed: () async =>
                                              {await pay(), print("here")},
                                          text: 'Pay'.tr,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
            ],
          ),
        ),
      ),
    );
  }

  pay() async {
    double test1 = 0.00;
    print("pay");
    if (_enquiryModel3.billTypeId == 2) {
      if (amount == "") {
        snack(context, "Please enter amount.".tr);
        if (amount != "") {
          test1 = double.parse(amount);
          print("test1");
          print(test1);
          if (test1 < 0.99) {
            snack(context, "Please enter amount more than RM1.00.".tr);
          }
        }
      } else if (gatewayMethod == "") {
        snack(context, "Select payment method.".tr);
      } else if (amount != "" && test1 < 0.99 && gatewayMethod != "") {
        // ignore: unused_local_variable
        var isConfirm = await appDialogDelete("Continue Payment ? ".tr, " ");
        // bool? value = await Get.defaultDialog<bool>(
        //   radius: 14,
        //   title: "",
        //   titlePadding: EdgeInsets.zero,
        //   content: Column(
        //     children: [
        //       Icon(
        //         Icons.info,
        //         color: constants.eightColor,
        //         size: 50,
        //       ),
        //       SizedBox(height: 10),
        //       Text(
        //         "Continue Payment ? ".tr,
        //         style: TextStyle(fontWeight: FontWeight.w500),
        //       ),
        //       SizedBox(height: 10),
        //       Text(
        //         "Proceed to payment gateway".tr,
        //         textAlign: TextAlign.center,
        //       ),
        //     ],
        //   ),
        //   // middleText: "Teruskan Pembayaran?",
        //   textConfirm: "Yes".tr,
        //   confirmTextColor: Colors.white,
        //   textCancel: "Back".tr,
        //   contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 20),
        //   onConfirm: () => Get.back(result: true),
        // );
        // print("value.toString()");
        // print(value.toString());
        if (isConfirm == true) {
          // Map transactionItems = {
          //   "items": {
          //     _enquiryModel3.referenceNumber.toString(): [
          //       {
          //         "unit": "1",
          //         "price": _enquiryModel3.nettCalculations!.total.toString(),
          //         "title": "Kadar (RM)",
          //         "quantity": 1,
          //         "total_price": _enquiryModel3.nettCalculations!.total
          //           ..toString()
          //       }
          //     ]
          //   },
          //   "bill_id": _enquiryModel3.id,
          //   "service_id": _enquiryModel3.serviceId,
          //   "payment_description": _enquiryModel3.referenceNumber,
          //   "extra_fields": {"type": "date", "value": null},
          //   "amount": _enquiryModel3.nettCalculations!.total.toString()
          // };
          List a = [
            {
              "bill_id": _enquiryModel3.id,
              "amount": amount == ""
                  ? _enquiryModel3.nettCalculations.total
                      .toStringAsFixed(2)
                      .toString()
                  : amount,
            },
          ];
          print("gatewayMethod");
          print(gatewayMethod);
          print(jsonEncode(a));
          List<int> cartIds = [];
          log("Items: ${jsonEncode(a)}");
          ErrorResponse response1 =
              await api.addToCartIkhwan("", "", "", "", jsonEncode(a));
          print("response.data");
          print(response1.message);
          print(response1.data);
          print(response1.isSuccessful);
          print("response1.data[cart_id]");
          print(response1.data["cart_id"]);

          List rawIds = [response1.data["cart_id"]];
          cartIds = rawIds.map((e) => e as int).toList();
          log(jsonEncode(CartPayRequest(
            ids: cartIds,
            source: "mobile",
            paymentMethod: gatewayMethod.toString(),
            redirectUrl: (gatewayMethod == "2") ? bankLink : null,
            bankCode: (gatewayMethod == "2") ? bankCode : null,
            bankType: (gatewayMethod == "2") ? bankType : null,
          )));
          ErrorResponse response = await api.paymentsv2(
            CartPayRequest(
              ids: cartIds,
              source: "mobile",
              paymentMethod: gatewayMethod,
              redirectUrl: (gatewayMethod == "2") ? bankLink : null,
              bankCode: (gatewayMethod == "2") ? bankCode : null,
              bankType: (gatewayMethod == "2") ? bankType : null,
            ),
          );
          // ErrorResponse response = await api.payments(
          //   PaymentsRequest(
          //     amount: _enquiryModel3.nettCalculations!.total.toString(),
          //     source: "mobile",
          //     transactionItems: jsonEncode([transactionItems]),
          //     paymentMethod: gatewayMethod,
          //     bankCode: gatewayMethod == "11" ? bank : null,
          //     redirectUrl: gatewayMethod == "11" ? bankLink : null,
          //   ),
          // );
          if (response.data != null) {
            Payments payments = Payments.fromJson(response.data);
            print(gatewayMethod.toString());
            if (gatewayMethod.toString() == "3") {
              Uint8List bytes =
                  Base64Decoder().convert(response.data["qr_image"]);

              Get.to(() => DuitnowQR(), arguments: {
                "payments": payments,
                "image": bytes,
              });
            } else {
              print("Reference Number: ${payments.redirect}");
              payments.referenceNumber =
                  response.data["redirect"].toString().split("/").last;
              payments.amount = amount == ""
                  ? _enquiryModel3.nettCalculations.total.toString()
                  : amount;
              payments.paymentType = int.parse(gatewayMethod);
              Get.to(() => PaymentScreen(), arguments: payments);
            }
          }
        }
      }
    } else {
      if (gatewayMethod == "") {
        snack(context, "Select payment method.".tr);
      } else {
        bool? value = await appDialogDelete("Continue Payment ? ".tr, " ");
        // bool? value = await Get.defaultDialog<bool>(
        //   radius: 14,
        //   title: "",
        //   titlePadding: EdgeInsets.zero,
        //   content: Column(
        //     children: [
        //       Icon(
        //         Icons.info,
        //         color: constants.eightColor,
        //         size: 50,
        //       ),
        //       SizedBox(height: 10),
        //       Text(
        //         "Continue Payment ? ".tr,
        //         style: TextStyle(fontWeight: FontWeight.w500),
        //       ),
        //       SizedBox(height: 10),
        //       Text(
        //         "Proceed to payment gateway".tr,
        //         textAlign: TextAlign.center,
        //       ),
        //     ],
        //   ),
        //   // middleText: "Teruskan Pembayaran?",
        //   textConfirm: "Yes".tr,
        //   confirmTextColor: Colors.white,
        //   textCancel: "Back".tr,
        //   contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 20),
        //   onConfirm: () => Get.back(result: true),
        // );

        if (value == true) {
          // Map transactionItems = {
          //   "items": {
          //     _enquiryModel3.referenceNumber.toString(): [
          //       {
          //         "unit": "1",
          //         "price": _enquiryModel3.nettCalculations!.total.toString(),
          //         "title": "Kadar (RM)",
          //         "quantity": 1,
          //         "total_price": _enquiryModel3.nettCalculations!.total
          //           ..toString()
          //       }
          //     ]
          //   },
          //   "bill_id": _enquiryModel3.id,
          //   "service_id": _enquiryModel3.serviceId,
          //   "payment_description": _enquiryModel3.referenceNumber,
          //   "extra_fields": {"type": "date", "value": null},
          //   "amount": _enquiryModel3.nettCalculations!.total.toString()
          // };
          List a = [
            {
              "service_id": null,
              "bill_id": _enquiryModel3.id,
              "amount": amount == ""
                  ? _enquiryModel3.nettCalculations.total
                      .toStringAsFixed(2)
                      .toString()
                  : amount,
              "details": {}
            },
          ];
          print("gatewayMethod");
          print(gatewayMethod);
          // print(jsonEncode([transactionItems]));
          List<int> cartIds = [];
          ErrorResponse response1 =
              await api.addToCartIkhwan("", "", "", "", jsonEncode(a));
          print("response.data");
          print(response1.message);
          print(response1.data);
          print(response1.isSuccessful);
          print("response1.data[cart_id]");
          print(response1.data["cart_id"]);

          List<dynamic> rawIds = [response1.data["cart_id"]];
          cartIds = rawIds.map((e) => e as int).toList();
          log(jsonEncode(CartPayRequest(
            ids: cartIds,
            source: "mobile",
            paymentMethod: gatewayMethod.toString(),
            redirectUrl: (gatewayMethod == "2") ? bankLink : null,
            bankCode: (gatewayMethod == "2") ? bankCode : null,
            bankType: (gatewayMethod == "2") ? bankType : null,
          )));
          ErrorResponse response = await api.paymentsv2(
            CartPayRequest(
              ids: cartIds,
              source: "mobile",
              paymentMethod: gatewayMethod,
              redirectUrl: (gatewayMethod == "2") ? bankLink : null,
              bankCode: (gatewayMethod == "2") ? bankCode : null,
              bankType: (gatewayMethod == "2") ? bankType : null,
            ),
          );
          // ErrorResponse response = await api.payments(
          //   PaymentsRequest(
          //     amount: _enquiryModel3.nettCalculations!.total.toString(),
          //     source: "mobile",
          //     transactionItems: jsonEncode([transactionItems]),
          //     paymentMethod: gatewayMethod,
          //     bankCode: gatewayMethod == "11" ? bank : null,
          //     redirectUrl: gatewayMethod == "11" ? bankLink : null,
          //   ),
          // );
          if (response.data != null) {
            Payments payments = Payments.fromJson(response.data);
            print(gatewayMethod.toString());
            if (gatewayMethod.toString() == "3") {
              Uint8List bytes =
                  Base64Decoder().convert(response.data["qr_image"]);

              Get.to(() => DuitnowQR(), arguments: {
                "payments": payments,
                "image": bytes,
              });
            } else {
              print("Reference Number: ${payments.redirect}");
              payments.referenceNumber =
                  response.data["redirect"].toString().split("/").last;
              payments.amount = amount == ""
                  ? _enquiryModel3.nettCalculations.total.toString()
                  : amount;
              payments.paymentType = int.parse(gatewayMethod);
              Get.to(() => PaymentScreen(), arguments: payments);
            }
          }
        }
      }
    }
  }

  cart(String amount) async {
    print(_enquiryModel3.serviceId.toString());
    print(_enquiryModel3.referenceNumber.toString());
    print(_enquiryModel3.nettCalculations.total..toString());
    print(_enquiryModel3.id.toString());
    List a = [
      {
        // "service_id": null,
        "bill_id": _enquiryModel3.id,
        "amount": 20,
        // amount == ""
        //     ? _enquiryModel3.nettCalculations!.total!
        //         .toStringAsFixed(2)
        //         .toString()
        //     : amount,
        "details": {}
      },
    ];
    //  ErrorResponse response = await api.addToCartIkhwan(
    //     "",
    //     _enquiryModel3.id.toString(),
    //     _enquiryModel3.referenceNumber!,
    //     amount == ""
    //         ? _enquiryModel3.nettCalculations!.total.toString()
    //         : amount,
    //     jsonEncode(a));
    ErrorResponse response =
        await api.addToCartIkhwan("", "", "", "", jsonEncode(a));
    print("response.data");
    print(response.message);
    print(response.data);
    print(response.isSuccessful);
    if (response.isSuccessful) {
      await snack(context, "Added to cart successfully.".tr);
    } else if (response.message == "Bil telah wujud didalam troli") {
      await snack(context, "Bill exist in cart".tr);
    }
    // Navigator.pop(context, true);
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      // ignore: unnecessary_null_comparison
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    // ignore: unnecessary_null_comparison
    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}

List<String> getSuggestions(String query, List<String> _enquiryModel12) {
  _enquiryModel12 = _enquiryModel12.toSet().toList();
  List<String> matches = <String>[];
  matches.addAll(_enquiryModel12);

  matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  return matches;
}
