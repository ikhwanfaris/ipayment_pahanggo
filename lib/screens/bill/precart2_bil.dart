import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class TestingBill2 extends StatefulWidget {
  final enquiryModel3;
  const TestingBill2(this.enquiryModel3, {super.key});

  @override
  State<TestingBill2> createState() => _TestingBill2State();
}

class _TestingBill2State extends State<TestingBill2> {
  // GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // var _formKey = GlobalKey<FormState>();
  Map a = {};
  List realcart2 = [];
  bool case1 = false;
  bool case2 = false;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  initApp() async {
    setState(() {
      realcart2 = [];
    });

    setState(() {
      realcart2 = widget.enquiryModel3;
    });
    print("realcart2.length");
    print(realcart2.length);
    print('--------');
    for (var i = 0; i < realcart2.length; i++) {
      print(i.toString());
    }
    print('--------');
    for (var i = 0; i < realcart2.length; i++) {
      print(realcart2[i].billTypeId);
      if (realcart2[i].billTypeId == 1) {
        setState(() {
          case1 = true;
        });
      }
      if (realcart2[i].billTypeId == 2) {
        setState(() {
          case2 = true;
        });
      }
    }
    print('--------');
    print(realcart2.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Constants().primaryColor,
          onPressed: () async {
            for (var i = 0; i < realcart2.length; i++) {
              setState(() {
                realcart2[i].amount = "";
              });
            }
            // _formKey.currentState?.dispose();
            // _formKey.currentState?.deactivate();
            Future.delayed(const Duration(seconds: 1)).then(
              (value) => setState(
                () {
                  Navigator.pop(context, true);
                },
              ),
            );
          },
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        title: Text(
          "",
          style: styles.heading5,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            case1 == true
                ? AppBar(
                    backgroundColor: constants.secondaryColor,
                    centerTitle: true,
                    leading: Container(),
                    title: Text(
                      "Bil".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Container(),
            case1 == true
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: realcart2.length,
                    //  _organizationModel.length,
                    itemBuilder: (context, index) {
                      return realcart2[index].billTypeId.toString() == "1"
                          ? Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 0,
                                    color: Color(0xFFF5F6F9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  realcart2[index]
                                                      .referenceNumber!
                                                      .toString(),
                                                  style: styles.heading6bold,
                                                ),
                                                Text(
                                                  "RM " +
                                                      realcart2[index]
                                                          .nettCalculations!
                                                          .total!
                                                          .toString(),
                                                  style: styles.heading12bold,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        'iPayment Bill Reference Number'
                                                                .tr +
                                                            ":"),
                                                    Text('Date'.tr + ":"),
                                                    Text('Status'.tr + ":"),
                                                    Text(
                                                        'Transaction Charged To'
                                                                .tr +
                                                            ":"),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      realcart2[index]
                                                          .billNumber!
                                                          .toString(),
                                                    ),
                                                    realcart2[index].startAt !=
                                                            null
                                                        ? Text(
                                                            DateFormat.yMd()
                                                                .format(DateTime
                                                                    .parse(realcart2[
                                                                            index]
                                                                        .startAt!))
                                                                .toString(),
                                                          )
                                                        : Text("No date".tr),
                                                    Text(
                                                      realcart2[index]
                                                          .status!
                                                          .toString(),
                                                    ),
                                                    Text(
                                                      realcart2[index]
                                                          .service!
                                                          .chargedTo
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                    },
                  )
                : SizedBox(),

            case2 == true
                ? AppBar(
                    backgroundColor: constants.secondaryColor,
                    centerTitle: true,
                    leading: Container(),
                    title: Text(
                      "Bill Without Amount".tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                : Container(),
            case2 == true
                ? ListTile(
                    leading: Icon(Icons.info),
                    title: Text(
                        "The amount is adjusted based on the Malaysia Treasury Circular."
                            .tr),
                  )
                : Container(),
            case2 == true
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: realcart2.length,
                    //  _organizationModel.length,
                    itemBuilder: (context, index) {
                      return realcart2[index].billTypeId.toString() == "2"
                          ? Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Column(
                                children: [
                                  Card(
                                    elevation: 0,
                                    color: Color(0xFFF5F6F9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // for (var item in bills)

                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  realcart2[index]
                                                      .referenceNumber!
                                                      .toString(),
                                                  style: styles.heading6bold,
                                                ),
                                                // Text(
                                                //   "RM " +
                                                //       realcart2[index]
                                                //           .nettCalculations!
                                                //           .total!
                                                //           .toString(),
                                                //   style: styles.heading12bold,
                                                // ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: 220.0,
                                                  height: 60,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: TextFormField(
                                                      // initialValue: "0.00",
                                                      enableSuggestions: false,
                                                      inputFormatters: <
                                                          TextInputFormatter>[
                                                        CurrencyTextInputFormatter(
                                                          decimalDigits: 2,
                                                          symbol: '',
                                                        ),
                                                      ],
                                                      // inputFormatters: [
                                                      //   FilteringTextInputFormatter
                                                      //       .allow(
                                                      //     RegExp(
                                                      //         r'^\d+\.?\d{0,2}'),
                                                      //   ),
                                                      // ],
                                                      keyboardType: TextInputType
                                                          .numberWithOptions(
                                                              decimal: true),
                                                      expands: false,
                                                      autocorrect: false,
                                                      decoration: styles
                                                          .inputDecoration
                                                          .copyWith(
                                                        label: getRequiredLabel(
                                                            'Amount (RM)'.tr),
                                                      ),
                                                      onChanged: (val) async {
                                                        print("val");
                                                        print(val);
                                                        if (val != "" &&
                                                            val.length >= 2) {
                                                          val = val.replaceAll(
                                                              ",", "");
                                                          a = {};
                                                          a = await api
                                                              .GetRounding(val);
                                                          print(
                                                              "rounding value");
                                                          print(a.toString());
                                                          setState(() {
                                                            a = a;
                                                          });
                                                          double test = 0.00;
                                                          test = double.parse(
                                                                  val) +
                                                              a['value'];
                                                          print(
                                                              test.toString());
                                                          setState(() {
                                                            val = test
                                                                .toStringAsFixed(
                                                                    2)
                                                                .toString();
                                                            realcart2[index]
                                                                    .amount =
                                                                val.toString();
                                                          });
                                                          print(a.isNotEmpty);
                                                          print(a['value']);
                                                          print(realcart2[index]
                                                              .amount);
                                                        } else if (val.length ==
                                                            0) {
                                                          print("empty 2");
                                                          Future.delayed(
                                                                  const Duration(
                                                                      seconds:
                                                                          1))
                                                              .then(
                                                                  (value) =>
                                                                      setState(
                                                                          () {
                                                                        realcart2[index].amount =
                                                                            "";
                                                                      }));
                                                        } else if (val == "") {
                                                          realcart2[index]
                                                              .amount = "";
                                                          setState(() {
                                                            realcart2[index]
                                                                .amount = "";
                                                          });
                                                        } else {
                                                          realcart2[index]
                                                              .amount = "";
                                                          setState(() {
                                                            realcart2[index]
                                                                .amount = "";
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                // Text('Amaun selepas dilaras :'),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Payment Total'.tr + ":",
                                                  style: styles.heading12bold,
                                                ),
                                                realcart2[index].amount != ""
                                                    ? Text(
                                                        'RM ' +
                                                            moneyFormat(double
                                                                .parse(realcart2[
                                                                        index]
                                                                    .amount)),
                                                        style: styles
                                                            .heading12bold,
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        'iPayment Bill Reference Number'
                                                                .tr +
                                                            ":"),
                                                    Text('Date'.tr + ":"),
                                                    Text('Status'.tr + ":"),
                                                    Text(
                                                        'Transaction Charged To'
                                                                .tr +
                                                            ":"),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      realcart2[index]
                                                          .billNumber!
                                                          .toString(),
                                                    ),
                                                    realcart2[index].startAt !=
                                                            null
                                                        ? Text(
                                                            formatDate(
                                                              DateTime.parse(
                                                                  realcart2[
                                                                          index]
                                                                      .startAt
                                                                      .toString()),
                                                              [
                                                                dd,
                                                                '/',
                                                                mm,
                                                                '/',
                                                                yyyy
                                                              ],
                                                            ),
                                                          )
                                                        : Text("No date".tr),
                                                    Text(
                                                      realcart2[index]
                                                          .status!
                                                          .toString(),
                                                    ),
                                                    Text(
                                                      realcart2[index]
                                                          .service!
                                                          .chargedTo
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container();
                    },
                  )
                : Container(),
            // ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants().sixColor,
                  fixedSize: const Size(300, 60),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () async {
                  bool submit = true;

                  for (var i = 0; i < realcart2.length; i++) {
                    if (case2 == true) {
                      if (realcart2[i].amount == "" &&
                          realcart2[i].billTypeId.toString() == "2") {
                        print(i.toString());
                        print("its empty");
                        snack(context, "Please enter amount".tr,
                            level: SnackLevel.Error);
                        setState(() {
                          i = realcart2.length;
                          submit = false;
                        });
                      }
                      if (realcart2[i].amount != "" &&
                          realcart2[i].billTypeId.toString() == "2") {
                        double test1 = 0.00;
                        test1 = double.parse(realcart2[i].amount);

                        if (test1 < 0.99) {
                          print("its less than rm 1");
                          snack(context,
                              "Please enter amount more than RM1.00.".tr);
                          setState(() {
                            i = realcart2.length;
                            submit = false;
                          });
                        }
                      }
                    }
                  }

                  if (submit == true) {
                    print(realcart2.length);
                    List a = [];
                    for (var i = 0; i < realcart2.length; i++) {
                      a.add(
                        {
                          "service_id": null,
                          "bill_id": realcart2[i].id,
                          "amount": realcart2[i].billTypeId.toString() == "2"
                              ? realcart2[i].amount.toString()
                              : realcart2[i]
                                  .nettAmount
                                  .toStringAsFixed(2)
                                  .toString(),
                          "details": {}
                        },
                      );
                    }

                    ErrorResponse response = await api.addToCartIkhwan(
                        "", "", "", "", jsonEncode(a));
                    print("response.data");
                    print("response.message");
                    print(response.message);
                    print(response.data);
                    print(response.isSuccessful);
                    print(response.statusCode);
                    if (response.isSuccessful == true) {
                      await snack(context, "Added to cart successfully.".tr);

                      Future.delayed(const Duration(seconds: 1)).then(
                        (value) => setState(
                          () {
                            Navigator.pop(context, true);
                          },
                        ),
                      );
                    } else if (response.message ==
                        "Bil telah wujud didalam troli") {
                      await snack(context, "Bill exist in cart".tr);
                    }

                    // Get.back();
                    // await _getData();
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Add To Cart".tr,
                    style: styles.raisedButtonTextWhite,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
