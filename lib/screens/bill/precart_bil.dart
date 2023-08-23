import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TestingBill extends StatefulWidget {
  final enquiryModel3;
  const TestingBill(this.enquiryModel3, {super.key});

  @override
  State<TestingBill> createState() => _TestingBillState();
}

class _TestingBillState extends State<TestingBill> {
  var _formKey = GlobalKey<FormState>();
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
      realcart2 = widget.enquiryModel3;
    });
    print('--------');
    for (var i = 0; i < realcart2.length; i++) {
      print(realcart2[i].billTypeId.toString());
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
    print(case1.toString());
    print(case2.toString());
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
            _formKey.currentState?.dispose();
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
          "Tambah ke troli 1",
          style: styles.heading5,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            case1 == true
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: realcart2.length,
                    //  _organizationModel.length,
                    itemBuilder: (context, index) {
                      return realcart2[index].billTypeId.toString() == "1"
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  AppBar(
                                    backgroundColor: constants.secondaryColor,
                                    centerTitle: true,
                                    leading: Container(),
                                    title: Text(
                                      "Bil",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Color(0xFFF5F6F9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
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
                                                      moneyFormat(double.parse(
                                                        realcart2[index]
                                                            .net!
                                                            .toString(),
                                                      )),
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
                                                    Text('No Bil :'),
                                                    Text('Tarikh :'),
                                                    Text('Status :'),
                                                    Text(
                                                        'Pihak Tanggung Caj :'),
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
                                                    Text(
                                                      DateFormat.yMd()
                                                          .format(DateTime
                                                              .parse(realcart2[
                                                                      index]
                                                                  .startAt!))
                                                          .toString(),
                                                    ),
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
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: realcart2.length,
                    //  _organizationModel.length,
                    itemBuilder: (context, index) {
                      return realcart2[index].billTypeId.toString() == "2"
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  AppBar(
                                    backgroundColor: constants.secondaryColor,
                                    centerTitle: true,
                                    leading: Container(),
                                    title: Text(
                                      "Bil Tanpa Amaun",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.info),
                                    title: Text(
                                        "Amaun dilaraskan berdasarkan Pekeliling Perbendaharaan Malaysia."),
                                  ),
                                  Card(
                                    elevation: 0,
                                    color: Color(0xFFF5F6F9),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
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
                                                Text(
                                                  "RM " +
                                                      moneyFormat(double.parse(
                                                        realcart2[index]
                                                            .nettCalculations!
                                                            .total!
                                                            .toString(),
                                                      )),
                                                  style: styles.heading12bold,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Form(
                                                  key: _formKey,
                                                  child: SizedBox(
                                                    width: 250.0,
                                                    height: 100,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: TextFormField(
                                                        enableSuggestions:
                                                            false,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        expands: false,
                                                        autocorrect: false,
                                                        decoration: styles
                                                            .inputDecoration
                                                            .copyWith(
                                                          label: getRequiredLabel(
                                                              'Please enter amount'
                                                                  .tr),
                                                        ),
                                                        onChanged: (val) async {
                                                          if (val != "" &&
                                                              val.length > 2) {
                                                            a = {};
                                                            a = await api
                                                                .GetRounding(
                                                                    val);
                                                            setState(() {
                                                              a = a;
                                                            });

                                                            double test = 0.0;
                                                            test = double.parse(
                                                                    val) +
                                                                a['value'];
                                                            print("end result");
                                                            print(test
                                                                .toString());
                                                            setState(() {
                                                              val = test
                                                                  .toString();
                                                              realcart2[index]
                                                                      .amount =
                                                                  val.toString();
                                                            });
                                                            print(a.isNotEmpty);
                                                            print(a['value']);
                                                            print(
                                                                realcart2[index]
                                                                    .amount);
                                                          } else {
                                                            setState(() {
                                                              realcart2[index]
                                                                  .amount = "";
                                                            });
                                                          }
                                                        },
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Sila masukkan amaun';
                                                          }
                                                          return null;
                                                        },
                                                      ),
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
                                                    Text('No Bil :'),
                                                    Text('Tarikh :'),
                                                    Text('Status :'),
                                                    Text(
                                                        'Pihak Tanggung Caj :'),
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
                                                    Text(
                                                      DateFormat.yMd()
                                                          .format(DateTime
                                                              .parse(realcart2[
                                                                      index]
                                                                  .startAt!))
                                                          .toString(),
                                                    ),
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
                                  // ListTile(
                                  //   title: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Text(realcart2[index].referenceNumber),
                                  //   ),
                                  //   subtitle: Form(
                                  //     key: _formKey,
                                  //     child: TextFormField(
                                  //       enableSuggestions: false,
                                  //       keyboardType: TextInputType.number,
                                  //       expands: false,
                                  //       autocorrect: false,
                                  //       decoration: styles.inputDecoration.copyWith(
                                  //         label: getRequiredLabel('Masukkan Amaun'),
                                  //       ),
                                  //       onChanged: (val) async {
                                  //         // setState(() {
                                  //         //   realcart2[index].amount = val.toString();
                                  //         // });
                                  //         a = {};
                                  //         a = await api.GetRounding(val);
                                  //         setState(() {
                                  //           a = a;
                                  //         });

                                  //         if (a['value'] != 0 || a['value'] != -0) {
                                  //           double test = 0.0;
                                  //           test = double.parse(val) + a['value'];
                                  //           print(test.toString());
                                  //           setState(() {
                                  //             val = test.toString();
                                  //             realcart2[index].amount =
                                  //                 val.toString();
                                  //           });
                                  //           print(a.isNotEmpty);
                                  //           print(a['value']);
                                  //           print(realcart2[index].amount);
                                  //           // _refreshIndicatorKey.currentState?.show();

                                  //           // Future.delayed(const Duration(seconds: 1)).then(
                                  //           //   (value) => setState(
                                  //           //     () {

                                  //           //     },
                                  //           //   ),
                                  //           // );
                                  //         }
                                  //       },
                                  //       validator: (value) {
                                  //         if (value == null || value.isEmpty) {
                                  //           return 'Sila masukkan amaun bayaran';
                                  //         }
                                  //         return null;
                                  //       },
                                  //     ),
                                  //   ),
                                  // ),
                                  // a.isNotEmpty == true
                                  //     ? ListTile(
                                  //         title: Padding(
                                  //           padding: const EdgeInsets.all(8.0),
                                  //           child: Text(
                                  //               "Amaun setelah dilaras ialah : RM " +
                                  //                   realcart2[index].amount),
                                  //         ),
                                  //       )
                                  // : Container(),
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
                  if (_formKey.currentState!.validate()) {
                    print(realcart2.length);
                    List a = [];
                    for (var i = 0; i < realcart2.length; i++) {
                      a.add(
                        {
                          "service_id": null,
                          "bill_id": realcart2[i].id,
                          "amount": realcart2[i].billTypeId.toString() == "2"
                              ? realcart2[i]
                                  .amount
                                  .toStringAsFixed(2)
                                  .toString()
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
                    print(response.message);
                    print(response.data);
                    print(response.isSuccessful);
                    if (response.isSuccessful == true) {
                      await snack(context, "Added to cart successfully.".tr);

                      Future.delayed(const Duration(seconds: 1)).then(
                        (value) => setState(
                          () {
                            Navigator.pop(context, true);
                          },
                        ),
                      );
                    }

                    // Get.back();
                    // await _getData();
                  }
                  // Navigator.pop(context, "no");
                  // _formKey.currentState?.dispose();
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Add to Cart",
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
