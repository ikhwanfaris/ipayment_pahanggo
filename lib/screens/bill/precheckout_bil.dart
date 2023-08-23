import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../models/bills/bills.dart';
import 'checkout.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class PreCheckout extends StatefulWidget {
  final billItem;
  const PreCheckout(this.billItem, {super.key});

  @override
  State<PreCheckout> createState() => _PreCheckoutState();
}

class _PreCheckoutState extends State<PreCheckout> {
  Map roundingValue = {};
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
      realcart2 = widget.billItem;
    });
    print("realcart2.length");
    print(realcart2.length);
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
                          ? BillItemOne(
                              item: realcart2[index],
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
                          ? BillItemTwo(
                              item: realcart2[index],
                              sixedBox: SizedBox(
                                width: 220.0,
                                height: 60,
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    enableSuggestions: false,
                                    inputFormatters: <TextInputFormatter>[
                                      CurrencyTextInputFormatter(
                                        decimalDigits: 2,
                                        symbol: '',
                                      ),
                                    ],
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    expands: false,
                                    autocorrect: false,
                                    decoration: styles.inputDecoration.copyWith(
                                      label: getRequiredLabel('Amount (RM)'.tr),
                                    ),
                                    onChanged: (val) async {
                                      if (val != "" && val.length >= 2) {
                                        val = val.replaceAll(",", "");
                                        roundingValue = {};
                                        roundingValue =
                                            await api.GetRounding(val);

                                        print(roundingValue.toString());
                                        setState(() {
                                          roundingValue = roundingValue;
                                        });
                                        double afterRounding = 0.00;
                                        afterRounding = double.parse(val) +
                                            roundingValue['value'];

                                        setState(() {
                                          val = afterRounding
                                              .toStringAsFixed(2)
                                              .toString();
                                          realcart2[index].amount =
                                              val.toString();
                                        });
                                      } else if (val.length == 0) {
                                        Future.delayed(
                                                const Duration(seconds: 1))
                                            .then((value) => setState(() {
                                                  realcart2[index].amount = "";
                                                }));
                                      } else if (val == "") {
                                        realcart2[index].amount = "";
                                        setState(() {
                                          realcart2[index].amount = "";
                                        });
                                      } else {
                                        realcart2[index].amount = "";
                                        setState(() {
                                          realcart2[index].amount = "";
                                        });
                                      }
                                    },
                                  ),
                                ),
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
                    double sum2 = 0.0;

                    if (case1 == true) {
                      for (var i = 0; i < realcart2.length; i++) {
                        sum2 += double.parse(
                            (realcart2[i].nettCalculations!.total!.toString()));
                      }
                    }

                    print(sum2.toString());
                    if (case2 == true) {
                      print(sum2.toString());
                      for (var i = 0; i < realcart2.length; i++) {
                        if (realcart2[i].amount.toString() != "") {
                          sum2 +=
                              double.parse((realcart2[i].amount.toString()));
                        }
                      }
                    }

                    navigate(context, CheckoutScreen(realcart2, sum2));
                  }
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Pay".tr,
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

class BillItemOne extends StatelessWidget {
  const BillItemOne({Key? key, required this.item});

  final Bill item;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.referenceNumber!.toString(),
                          style: styles.heading6bold,
                        ),
                        Text(
                          "RM " + item.nettCalculations.total.toString(),
                          style: styles.heading12bold,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('iPayment Bill Reference Number'.tr + ":"),
                            Text('Date'.tr + ":"),
                            Text('Status'.tr + ":"),
                            Text('Transaction Charged To'.tr + ":"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              item.billNumber!.toString(),
                            ),
                            item.startAt != null
                                ? Text(
                                    DateFormat.yMd()
                                        .format(item.startAt!)
                                        .toString(),
                                  )
                                : Text("No date".tr),
                            Text(
                              item.status!.toString(),
                            ),
                            Text(
                              item.service.chargedTo.toString(),
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
    );
  }
}

class BillItemTwo extends StatelessWidget {
  const BillItemTwo({Key? key, required this.item, required this.sixedBox});

  final Bill item;
  final Widget sixedBox;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.referenceNumber!.toString(),
                          style: styles.heading6bold,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [sixedBox],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Total'.tr + ":",
                          style: styles.heading12bold,
                        ),
                        item.amount != ""
                            ? Text(
                                'RM ' + moneyFormat(double.parse(item.amount!)),
                                style: styles.heading12bold,
                              )
                            : Container(),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('iPayment Bill Reference Number'.tr + ":"),
                            Text('Date'.tr + ":"),
                            Text('Status'.tr + ":"),
                            Text('Transaction Charged To'.tr + ":"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              item.billNumber!.toString(),
                            ),
                            item.startAt != null
                                ? Text(
                                    formatDate(
                                      DateTime.parse(item.startAt.toString()),
                                      [dd, '/', mm, '/', yyyy],
                                    ),
                                  )
                                : Text("No date".tr),
                            Text(
                              item.status!.toString(),
                            ),
                            Text(
                              item.service.chargedTo.toString(),
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
    );
  }
}
