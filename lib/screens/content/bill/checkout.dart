// ignore_for_file: unused_field

import 'dart:convert';
import 'dart:typed_data';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/models/bill/bill.dart';
import 'package:flutterbase/models/bills/bills.dart' as model;
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../helpers.dart';
import 'package:flutterbase/models/contents/bank.dart';

import '../../../models/payments/payments.dart';
import '../home/duitnow_qr.dart';
import '../home/payment.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CheckoutScreen extends StatefulWidget {
  final enquiryModel2;
  final double sum;
  const CheckoutScreen(this.enquiryModel2, this.sum, {Key? key})
      : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  List _enquiryModel3 = [];
  var inputFormat = DateFormat('dd-MM-yyyy');
  bool alreadySaved = false;
  List<Bank> _enquiryModel4 = [];
  List<Bill> _enquiryModel5 = [];
  List<model.PaymentGateway> _enquiryModel6 = [];
  List<Bank> _enquiryModel11 = [];
  List<String> _enquiryModel12 = [];
  String gateway = "Select Payment Method".tr;
  String bankText = "Select Bank or E-wallet".tr;
  String bank = "";
  String bankCode = "";
  String bankLink = "";
  String bankType = "";
  String gatewayMethod = "";

  String amount = "";
  double sum2 = 0.0;
  double sum3 = 0.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _typeAheadController = TextEditingController();
  late String _selectedCity;
  List<Bank> cor = [];
  List<Bank> ret = [];
  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    Future.delayed(const Duration(seconds: 0)).then((value) => setState(() {}));
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(context));
    print(widget.enquiryModel2);
    setState(() {
      _enquiryModel3 = widget.enquiryModel2;
      sum3 = widget.sum;
    });
    _enquiryModel6 = await api.GetPaymentGateway();
    _enquiryModel4 = await api.GetPaynetBank();
    setState(() {
      // gateway = _enquiryModel6[0].name.toString();
      _enquiryModel4 = _enquiryModel4;
      _enquiryModel6 = _enquiryModel6;
    });
    _enquiryModel4.removeWhere((item) => item.redirectUrls == null);

    setState(() {
      _enquiryModel4 = _enquiryModel4;
    });

    for (var v = 0; v < _enquiryModel4.length; v++) {
      for (var q = 0; q < _enquiryModel4[v].redirectUrls!.length - 1; q++) {
        if (_enquiryModel4[v].redirectUrls!.length == 2) {
          if (_enquiryModel4[v].redirectUrls![q].type ==
                  _enquiryModel4[v].redirectUrls![q + 1].type ||
              _enquiryModel4[v].redirectUrls![q].type == " " ||
              _enquiryModel4[v].redirectUrls![q + 1].type == " ") {
            _enquiryModel4[v].redirectUrls!.removeLast();
          }
        }
      }
    }
    setState(() {
      _enquiryModel4 = _enquiryModel4;
    });

    _enquiryModel4.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    for (var v = 0; v < _enquiryModel4.length; v++) {
      for (var q = 0; q < _enquiryModel4[v].redirectUrls!.length; q++) {
        _enquiryModel11.add(
          Bank(
            active: true,
            code: _enquiryModel4[v].code,
            name: _enquiryModel4[v].name +
                " " +
                // (Corporate) (Retail)
                (_enquiryModel4[v].redirectUrls![q].type.toString() == "RET"
                    ? "(Retail)"
                    : "(Corporate)"),
            redirectUrls: [
              RedirectUrl(
                  type: _enquiryModel4[v].redirectUrls![q].type,
                  url: _enquiryModel4[v].redirectUrls![q].url)
            ],
          ),
        );
      }
    }

    for (var v = 0; v < _enquiryModel4.length; v++) {
      for (var q = 0; q < _enquiryModel4[v].redirectUrls!.length; q++) {
        _enquiryModel12.add(_enquiryModel4[v].name);
      }
    }

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
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              "Checkout".tr,
              style: styles.heading5,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _enquiryModel3.isEmpty
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: ListView.builder(
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _enquiryModel3.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            title: Text(
                              _enquiryModel3[index].billNumber.toString(),
                              style: styles.heading12bold,
                            ),
                            subtitle: _enquiryModel3[index].billTypeId == 1
                                ? Text(
                                    "RM " +
                                        _enquiryModel3[index]
                                            .nettCalculations!
                                            .total!
                                            .toStringAsFixed(2)
                                            .toString(),
                                    style: styles.heading12bold,
                                  )
                                : Text(
                                    "RM " +
                                        moneyFormat(double.parse(
                                            _enquiryModel3[index]
                                                .amount
                                                .toString())),
                                    style: styles.heading12bold,
                                  ),
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  "Agency Bill Ref. No.".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Text(
                                    _enquiryModel3[index]
                                        .referenceNumber
                                        .toString(),
                                    style: styles.heading12sub),
                              ),
                              ListTile(
                                title: Text(
                                  "iPayment Ref. No.".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Text(
                                    _enquiryModel3[index].billNumber.toString(),
                                    style: styles.heading12sub),
                              ),
                              ListTile(
                                title: Text(
                                  "Service Category".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Text(
                                    _enquiryModel3[index]
                                        .service!
                                        .serviceCategory!
                                        .toString(),
                                    style: styles.heading12sub),
                              ),
                              // ListTile(
                              //   title: Text(
                              //     "Payment Details".tr,
                              //     style: styles.heading12bold,
                              //   ),
                              //   subtitle: Text(
                              //       _enquiryModel3[index].detail.toString(),
                              //       style: styles.heading12sub),
                              // ),
                              ListTile(
                                title: Text(
                                  "Agency Name".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Text(
                                    _enquiryModel3[index]
                                        .service!
                                        .name!
                                        .toString(),
                                    style: styles.heading12sub),
                              ),
                              ListTile(
                                title: Text(
                                  "Bill Reference Date".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 8.0, 8.0, 8.0),
                                  child: Text(
                                    _enquiryModel3[index].startAt.toString() !=
                                            "null"
                                        ? formatDate(
                                            DateTime.parse(_enquiryModel3[index]
                                                .startAt
                                                .toString()),
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
                                  padding: const EdgeInsets.fromLTRB(
                                      0, 8.0, 8.0, 8.0),
                                  child: Text(
                                    _enquiryModel3[index].endAt.toString() !=
                                            "null"
                                        ? formatDate(
                                            DateTime.parse(_enquiryModel3[index]
                                                .endAt
                                                .toString()),
                                            [dd, '/', mm, '/', yyyy],
                                          )
                                        : "No date".tr,
                                    style: styles.heading12sub,
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "User Category".tr,
                                  style: styles.heading12bold,
                                ),
                                subtitle: Text(
                                    _enquiryModel3[index].customer == null
                                        ? "Pelanggan"
                                        : "Kerajaan",
                                    style: styles.heading12sub),
                              ),
                              // ListTile(
                              //   title: Text(
                              //     "Tarikh Rujukan Bil",
                              //     style: styles.heading12bold,
                              //   ),
                              //   subtitle: Padding(
                              //     padding: const EdgeInsets.fromLTRB(
                              //         0, 8.0, 8.0, 8.0),
                              //     child: _enquiryModel3[index].startAt != null
                              //         ? Text(
                              //             formatDate(
                              //               DateTime.parse(_enquiryModel3[index]
                              //                   .startAt
                              //                   .toString()),
                              //               [dd, '/', mm, '/', yyyy],
                              //             ),
                              //             style: styles.heading12sub,
                              //           )
                              //         : Text("No date",
                              //             style: styles.heading12sub),
                              //   ),
                              // ),
                              // ListTile(
                              //   title: Text(
                              //     "Tarikh Tamat",
                              //     style: styles.heading12bold,
                              //   ),
                              //   subtitle: Padding(
                              //     padding: const EdgeInsets.fromLTRB(
                              //         0, 8.0, 8.0, 8.0),
                              //     child: _enquiryModel3[index].endAt != null
                              //         ? Text(
                              //             formatDate(
                              //               DateTime.parse(_enquiryModel3[index]
                              //                   .endAt
                              //                   .toString()),
                              //               [dd, '/', mm, '/', yyyy],
                              //             ),
                              //             style: styles.heading12sub,
                              //           )
                              //         : Text("No date",
                              //             style: styles.heading12sub),
                              //   ),
                              // ),
                              // ListTile(
                              //   title: Text(
                              //     "Kategori Pengguna",
                              //     style: styles.heading12bold,
                              //   ),
                              //   subtitle: Padding(
                              //     padding: const EdgeInsets.fromLTRB(
                              //         0, 8.0, 8.0, 8.0),
                              //     child: Text(
                              //       _enquiryModel3[index].customer == null
                              //           ? "Pelanggan"
                              //           : "Kerajaan",
                              //       style: styles.heading12sub,
                              //     ),
                              //   ),
                              // ),
                            ],
                          );
                        },
                      ),
                    ),
              Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          "Payment Total".tr +
                              ": RM " +
                              sum3.toStringAsFixed(2).toString(),
                          style: styles.heading5bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
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
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  gateway,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black38),
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
                                          backgroundColor:
                                              constants.secondaryColor,
                                          centerTitle: true,
                                          leading: Container(),
                                          title: Text(
                                            "Payment Method".tr,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          actions: [
                                            IconButton(
                                              onPressed: () => Get.back(),
                                              icon: Icon(Icons.close_rounded),
                                            )
                                          ],
                                        ),
                                        ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: _enquiryModel6.length,
                                          //  _organizationModel.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              leading: _enquiryModel6[index]
                                                          .logo !=
                                                      null
                                                  ? Image.network(
                                                      "https://internal-ipayment.anm.gov.my/storage/" +
                                                          _enquiryModel6[index]
                                                              .logo!,
                                                      // width: 60,
                                                      // height: 50,
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object exception,
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
                                              title: _enquiryModel6[index]
                                                          .title !=
                                                      ""
                                                  ? Text(_enquiryModel6[index]
                                                      .title!)
                                                  : Text("No title"),
                                              onTap: () {
                                                print(_enquiryModel6[index]
                                                    .title!);
                                                setState(() {
                                                  gateway =
                                                      _enquiryModel6[index]
                                                          .title!
                                                          .toString();
                                                  gatewayMethod =
                                                      _enquiryModel6[index]
                                                          .id
                                                          .toString();
                                                });

                                                Get.back();
                                              },
                                            );
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
                      gatewayMethod == "11" || gatewayMethod == "2"
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        fit: FlexFit.tight,
                                        flex: 6,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 1.0),
                                          child: SizedBox(
                                            height: 250,
                                            child: ListView(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(1.0),
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
                                                          itemBuilder:
                                                              (context, suggestion) {
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
                                                                    _enquiryModel4
                                                                        .length;
                                                                v++) {
                                                              for (var q = 0;
                                                                  q <
                                                                      _enquiryModel4[
                                                                              v]
                                                                          .redirectUrls!
                                                                          .length;
                                                                  q++) {
                                                                if (_enquiryModel4[
                                                                            v]
                                                                        .name ==
                                                                    suggestion
                                                                        .toString()) {
                                                                  print("yes");
                                                                  print(
                                                                      _enquiryModel4[
                                                                              v]
                                                                          .name);
                                                                  if (_enquiryModel4[
                                                                              v]
                                                                          .redirectUrls![
                                                                              q]
                                                                          .type
                                                                          .toString() ==
                                                                      "RET") {
                                                                    ret.add(
                                                                      Bank(
                                                                        active:
                                                                            true,
                                                                        code: _enquiryModel4[v]
                                                                            .code,
                                                                        name: _enquiryModel4[v]
                                                                            .name,
                                                                        redirectUrls: [
                                                                          RedirectUrl(
                                                                              type: _enquiryModel4[v].redirectUrls![q].type,
                                                                              url: _enquiryModel4[v].redirectUrls![q].url)
                                                                        ],
                                                                      ),
                                                                    );
                                                                  }
                                                                  if (_enquiryModel4[
                                                                              v]
                                                                          .redirectUrls![
                                                                              q]
                                                                          .type
                                                                          .toString() ==
                                                                      "COR") {
                                                                    cor.add(
                                                                      Bank(
                                                                        active:
                                                                            true,
                                                                        code: _enquiryModel4[v]
                                                                            .code,
                                                                        name: _enquiryModel4[v]
                                                                            .name,
                                                                        redirectUrls: [
                                                                          RedirectUrl(
                                                                              type: _enquiryModel4[v].redirectUrls![q].type,
                                                                              url: _enquiryModel4[v].redirectUrls![q].url)
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
                                                                            (context,
                                                                                index) {
                                                                          return ListTile(
                                                                            title:
                                                                                Text(ret[index].name),
                                                                            onTap:
                                                                                () {
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
                                                                        title: Text(
                                                                            ""),
                                                                      ),
                                                                    ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text("Corporate"),
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
                                                                            (context,
                                                                                index) {
                                                                          return ListTile(
                                                                            title:
                                                                                Text(cor[index].name),
                                                                            onTap:
                                                                                () {
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
                                                                        title: Text(
                                                                            ""),
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
                                                                Text(
                                                                    bank + " "),
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
                                          //  Text(
                                          //   bank,
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       color: Colors.black38),
                                          // ),
                                        ),
                                      ),
                                      // Flexible(
                                      //   flex: 1,
                                      //   fit: FlexFit.tight,
                                      //   child: IconButton(
                                      //     onPressed: () {
                                      //       Get.bottomSheet(
                                      //         persistent: false,
                                      //         ListView(
                                      //           children: [
                                      //             // Padding(
                                      //             //   padding: const EdgeInsets.symmetric(
                                      //             //       vertical: 15.0),
                                      //             //   child: Text(
                                      //             //     "Payment Options",
                                      //             //     style: TextStyle(
                                      //             //       fontSize: 18,
                                      //             //       fontWeight: FontWeight.w600,
                                      //             //     ),
                                      //             //   ),
                                      //             // ),
                                      //             AppBar(
                                      //               backgroundColor: constants
                                      //                   .secondaryColor,
                                      //               centerTitle: true,
                                      //               leading: Container(),
                                      //               title: Text(
                                      //                 "Selection of Banks".tr,
                                      //                 style: TextStyle(
                                      //                   fontSize: 18,
                                      //                   fontWeight:
                                      //                       FontWeight.w500,
                                      //                 ),
                                      //               ),
                                      //               actions: [
                                      //                 IconButton(
                                      //                   onPressed: () {
                                      //                     Get.back();
                                      //                     this
                                      //                         ._typeAheadController
                                      //                         .clear();
                                      //                   },
                                      //                   icon: Icon(Icons
                                      //                       .close_rounded),
                                      //                 )
                                      //               ],
                                      //             ),
                                      //             Padding(
                                      //               padding:
                                      //                   EdgeInsets.all(10.0),
                                      //               child: Column(
                                      //                 children: <Widget>[
                                      //                   TypeAheadFormField(
                                      //                       textFieldConfiguration:
                                      //                           TextFieldConfiguration(
                                      //                         controller: this
                                      //                             ._typeAheadController,
                                      //                         decoration:
                                      //                             InputDecoration(
                                      //                                 labelText:
                                      //                                     'Bank'),
                                      //                       ),
                                      //                       suggestionsCallback:
                                      //                           (pattern) {
                                      //                         return getSuggestions(
                                      //                             pattern,
                                      //                             _enquiryModel12);
                                      //                       },
                                      //                       itemBuilder: (context,
                                      //                           suggestion) {
                                      //                         return ListTile(
                                      //                           title: Text(
                                      //                             suggestion
                                      //                                 .toString(),
                                      //                           ),
                                      //                         );
                                      //                       },
                                      //                       transitionBuilder:
                                      //                           (context,
                                      //                               suggestionsBox,
                                      //                               controller) {
                                      //                         return suggestionsBox;
                                      //                       },
                                      //                       onSuggestionSelected:
                                      //                           (suggestion) {
                                      //                         this
                                      //                                 ._typeAheadController
                                      //                                 .text =
                                      //                             suggestion
                                      //                                 .toString();

                                      //                         print(" ad " +
                                      //                             suggestion
                                      //                                 .toString());
                                      //                         for (var v = 0;
                                      //                             v <
                                      //                                 _enquiryModel4
                                      //                                     .length;
                                      //                             v++) {
                                      //                           for (var q = 0;
                                      //                               q <
                                      //                                   _enquiryModel4[v]
                                      //                                       .redirectUrls!
                                      //                                       .length;
                                      //                               q++) {
                                      //                             if (_enquiryModel4[
                                      //                                         v]
                                      //                                     .name ==
                                      //                                 suggestion
                                      //                                     .toString()) {
                                      //                               cor = [];

                                      //                               ret = [];
                                      //                               print(
                                      //                                   "yes");
                                      //                               print(_enquiryModel4[
                                      //                                       v]
                                      //                                   .name);
                                      //                               if (_enquiryModel4[v]
                                      //                                       .redirectUrls![q]
                                      //                                       .type
                                      //                                       .toString() ==
                                      //                                   "RET") {
                                      //                                 print(
                                      //                                     "added ret");
                                      //                                 ret.add(
                                      //                                   Bank(
                                      //                                     active:
                                      //                                         true,
                                      //                                     code:
                                      //                                         _enquiryModel4[v].code,
                                      //                                     name:
                                      //                                         _enquiryModel4[v].name,
                                      //                                     redirectUrls: [
                                      //                                       RedirectUrl(
                                      //                                           type: _enquiryModel4[v].redirectUrls![q].type,
                                      //                                           url: _enquiryModel4[v].redirectUrls![q].url)
                                      //                                     ],
                                      //                                   ),
                                      //                                 );
                                      //                               }
                                      //                               if (_enquiryModel4[v]
                                      //                                       .redirectUrls![q]
                                      //                                       .type
                                      //                                       .toString() ==
                                      //                                   "COR") {
                                      //                                 print(
                                      //                                     "added COR");
                                      //                                 cor.add(
                                      //                                   Bank(
                                      //                                     active:
                                      //                                         true,
                                      //                                     code:
                                      //                                         _enquiryModel4[v].code,
                                      //                                     name:
                                      //                                         _enquiryModel4[v].name,
                                      //                                     redirectUrls: [
                                      //                                       RedirectUrl(
                                      //                                           type: _enquiryModel4[v].redirectUrls![q].type,
                                      //                                           url: _enquiryModel4[v].redirectUrls![q].url)
                                      //                                     ],
                                      //                                   ),
                                      //                                 );
                                      //                               }
                                      //                               setState(
                                      //                                   () {
                                      //                                 ret = ret;
                                      //                                 cor = cor;
                                      //                               });
                                      //                             }
                                      //                           }
                                      //                         }
                                      //                       },
                                      //                       validator: (value) {
                                      //                         if (value!
                                      //                             .isEmpty) {
                                      //                           return 'Please select a bank';
                                      //                         }
                                      //                         return 'Please select a bank';
                                      //                       },
                                      //                       onSaved: (value) {
                                      //                         print(value
                                      //                             .toString());
                                      //                         setState(() {
                                      //                           this._selectedCity =
                                      //                               value!;
                                      //                         });

                                      //                         print(this
                                      //                             ._selectedCity
                                      //                             .toString());
                                      //                       }),
                                      //                   SizedBox(
                                      //                     height: 10.0,
                                      //                   ),
                                      //                   // RaisedButton(
                                      //                   //   child:
                                      //                   //       Text('Submit'),
                                      //                   //   onPressed: () {
                                      //                   //     if (this
                                      //                   //         ._formKey
                                      //                   //         .currentState
                                      //                   //         .validate()) {
                                      //                   //       this
                                      //                   //           ._formKey
                                      //                   //           .currentState
                                      //                   //           .save();
                                      //                   //       Scaffold.of(
                                      //                   //               context)
                                      //                   //           .showSnackBar(SnackBar(
                                      //                   //               content:
                                      //                   //                   Text('Your Favorite City is ${this._selectedCity}')));
                                      //                   //     }
                                      //                   //   },
                                      //                   // )
                                      //                 ],
                                      //               ),
                                      //             ),
                                      //             Row(
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment
                                      //                       .spaceEvenly,
                                      //               children: [
                                      //                 Column(
                                      //                   children: [
                                      //                     Text("ret"),
                                      //                     Container(
                                      //                       color: Colors.red,
                                      //                       width: 150,
                                      //                       child: ListView
                                      //                           .builder(
                                      //                         physics:
                                      //                             NeverScrollableScrollPhysics(),
                                      //                         shrinkWrap: true,
                                      //                         itemCount:
                                      //                             ret.length,
                                      //                         //  _organizationModel.length,
                                      //                         itemBuilder:
                                      //                             (context,
                                      //                                 index) {
                                      //                           return ListTile(
                                      //                             // leading:
                                      //                             //  _enquiryModel6[
                                      //                             //                 index]
                                      //                             //             .logo !=
                                      //                             //         ""
                                      //                             //     ? _enquiryModel6[
                                      //                             //             index]
                                      //                             //         .logo
                                      //                             //     :
                                      //                             // Icon(Icons
                                      //                             //     .money),
                                      //                             title: Text(
                                      //                                 ret[index]
                                      //                                     .name),
                                      //                             onTap: () {
                                      //                               print(ret[
                                      //                                       index]
                                      //                                   .name);
                                      //                               setState(
                                      //                                   () {
                                      //                                 bank = ret[
                                      //                                         index]
                                      //                                     .name
                                      //                                     .toString();
                                      //                                 bankCode = ret[
                                      //                                         index]
                                      //                                     .code
                                      //                                     .toString();
                                      //                                 bankLink = ret[
                                      //                                         index]
                                      //                                     .redirectUrls!
                                      //                                     .last
                                      //                                     .url
                                      //                                     .toString();
                                      //                                 bankType = ret[
                                      //                                         index]
                                      //                                     .redirectUrls!
                                      //                                     .first
                                      //                                     .type
                                      //                                     .toString();
                                      //                               });

                                      //                               Get.back();
                                      //                             },
                                      //                           );
                                      //                         },
                                      //                       ),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //                 Column(
                                      //                   children: [
                                      //                     Text("cor"),
                                      //                     Container(
                                      //                       color:
                                      //                           Colors.yellow,
                                      //                       width: 150,
                                      //                       child: ListView
                                      //                           .builder(
                                      //                         physics:
                                      //                             NeverScrollableScrollPhysics(),
                                      //                         shrinkWrap: true,
                                      //                         itemCount:
                                      //                             cor.length,
                                      //                         //  _organizationModel.length,
                                      //                         itemBuilder:
                                      //                             (context,
                                      //                                 index) {
                                      //                           return ListTile(
                                      //                             // leading:
                                      //                             //  _enquiryModel6[
                                      //                             //                 index]
                                      //                             //             .logo !=
                                      //                             //         ""
                                      //                             //     ? _enquiryModel6[
                                      //                             //             index]
                                      //                             //         .logo
                                      //                             //     :
                                      //                             // Icon(Icons
                                      //                             //     .money),
                                      //                             title: Text(
                                      //                                 cor[index]
                                      //                                     .name),
                                      //                             onTap: () {
                                      //                               print(cor[
                                      //                                       index]
                                      //                                   .name);
                                      //                               setState(
                                      //                                   () {
                                      //                                 bank = cor[
                                      //                                         index]
                                      //                                     .name
                                      //                                     .toString();
                                      //                                 bankCode = cor[
                                      //                                         index]
                                      //                                     .code
                                      //                                     .toString();
                                      //                                 bankLink = cor[
                                      //                                         index]
                                      //                                     .redirectUrls!
                                      //                                     .last
                                      //                                     .url
                                      //                                     .toString();
                                      //                                 bankType = cor[
                                      //                                         index]
                                      //                                     .redirectUrls!
                                      //                                     .first
                                      //                                     .type
                                      //                                     .toString();
                                      //                               });

                                      //                               Get.back();
                                      //                             },
                                      //                           );
                                      //                         },
                                      //                       ),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //               ],
                                      //             )
                                      //           ],
                                      //         ),
                                      //         backgroundColor: Colors.white,
                                      //       );
                                      //     },
                                      //     icon: Icon(Icons.edit_outlined),
                                      //     color: constants.primaryColor,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 200,
                  child: PrimaryButton(
                    onPressed: () async {
                      await pay();
                    },
                    text: 'Pay'.tr,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  pay() async {
    if (gatewayMethod == "") {
      snack(context, "Select payment method.".tr);
    } else {
      // ignore: unused_local_variable
      var isConfirm = await appDialogDelete("Continue Payment ? ".tr, " ");
      // bool? value = await Get.defaultDialog<bool>(
      //   radius: 14,
      //   title: "",
      //   titlePadding: EdgeInsets.zero,
      //   content: Column(
      //     children: [
      //       // Icon(
      //       //   Icons.info,
      //       //   color: constants.eightColor,
      //       //   size: 50,
      //       // ),
      //       SizedBox(height: 10),
      //       Text(
      //         "Continue Payment ? ".tr,
      //         style: TextStyle(fontWeight: FontWeight.w500),
      //       ),
      //       SizedBox(height: 10),
      //       // Text(
      //       //   "Proceed to payment gateway".tr,
      //       //   textAlign: TextAlign.center,
      //       // ),
      //     ],
      //   ),
      //   // middleText: "Teruskan Pembayaran?",
      //   textConfirm: "Yes".tr,
      //   confirmTextColor: Colors.white,
      //   textCancel: "Back".tr,
      //   contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 20),
      //   onConfirm: () => Get.back(result: true),
      // );

      if (isConfirm == true) {
        print("_enquiryModel3.length.toString() " +
            _enquiryModel3.length.toString());
        // List checkout = [];
        // for (var i = 0; i < _enquiryModel3.length; i++) {
        //   Map transactionItems = {
        //     "items": {
        //       _enquiryModel3[i].referenceNumber: [
        //         {
        //           "unit": "1",
        //           "price": _enquiryModel3[i].billTypeId.toString() == "1"
        //               ? double.parse(
        //                   _enquiryModel3[i].nettCalculations!.total!.toString())
        //               : double.parse(_enquiryModel3[i].amount.toString()),
        //           "title": "Kadar (RM)",
        //           "quantity": 1,
        //           "total_price": _enquiryModel3[i].billTypeId.toString() == "1"
        //               ? _enquiryModel3[i].nettCalculations!.total!.toString()
        //               : _enquiryModel3[i].amount.toString()
        //         }
        //       ]
        //     },
        //     "bill_id": null,
        //     "service_id": _enquiryModel3[i].serviceId,
        //     "payment_description": _enquiryModel3[i].referenceNumber,
        //     "extra_fields": {"type": "date", "value": ""},
        //     "amount": _enquiryModel3[i].billTypeId.toString() == "1"
        //         ? _enquiryModel3[i].nettCalculations!.total!.toString()
        //         : _enquiryModel3[i].amount.toString()
        //   };
        //   checkout.add(transactionItems);
        // }

        List a = [];
        for (var i = 0; i < _enquiryModel3.length; i++) {
          a.add({
            "service_id": null,
            "bill_id": _enquiryModel3[i].id,
            "amount": _enquiryModel3[i].billTypeId.toString() == "1"
                ? _enquiryModel3[i]
                    .nettCalculations!
                    .total!
                    .toStringAsFixed(2)
                    .toString()
                : _enquiryModel3[i].amount.toString(),
            "details": {}
          });
        }

        print("gatewayMethod");
        print(gatewayMethod);
        print(jsonEncode(a));
        List<int> cartIds = [];
        ErrorResponse response1 =
            await api.addToCartIkhwan("", "", "", "", jsonEncode(a));
        print("response.data");
        print(response1.message);
        print(response1.data);
        print(response1.isSuccessful);
        print("response1.data[cart_ids]");
        print(response1.data["cart_ids"]);
        print("_enquiryModel3.length.toString()");
        print(_enquiryModel3.length.toString());
        List rawIds = [];
        if (_enquiryModel3.length == 1) {
          rawIds = [response1.data["cart_id"]];
        } else {
          rawIds = response1.data["cart_ids"];
        }

        cartIds = rawIds.map((e) => e as int).toList();
        //
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
          print("sum3.toString() " + response.toString());
          print("sum3.toString() " + sum3.toString());
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
            print("sum3.toString() " + sum3.toString());
            payments.amount = sum3.toString();
            payments.paymentType = int.parse(gatewayMethod);
            Get.to(() => Payment(), arguments: payments);
          }
        }

        // print(jsonEncode(checkout));
        // ErrorResponse response = await api.payments(
        //   PaymentsRequest(
        //     amount: sum3.toString(),
        //     source: "mobile",
        //     transactionItems: jsonEncode(checkout),
        //     paymentMethod: gatewayMethod,
        //     bankCode: gatewayMethod == "11" ? bank : null,
        //     redirectUrl: gatewayMethod == "11" ? bankLink : null,
        //   ),
        // );
        // Payments payments = Payments.fromJson(response.data);
        // print("response.data");
        // print(response.data);
        // print("response.data[redirect]");
        // print(response.data["redirect"]);

        // if (gatewayMethod.toString() == "3") {
        //   Uint8List bytes = Base64Decoder().convert(response.data["qr_image"]);

        //   Get.to(() => DuitnowQR(), arguments: {
        //     "payments": payments,
        //     "image": bytes,
        //   });
        // } else {
        //   Get.to(() => Payment(), arguments: payments);
        // }
      }
    }
  }
}

List<String> getSuggestions(String query, List<String> _enquiryModel12) {
  _enquiryModel12 = _enquiryModel12.toSet().toList();
  List<String> matches = <String>[];
  matches.addAll(_enquiryModel12);

  matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
  return matches;
}
