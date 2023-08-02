// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
// import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/checkout_button.dart';
import 'package:flutterbase/controller/bill/tanpa_bill_amount_controller.dart';
// import 'package:flutterbase/screens/content/home/bill/bill.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../api/api.dart';
import '../../../../helpers.dart';
import '../../../../models/bills/bills.dart';
import '../../../../utils/helpers.dart';
import '../../../auth/login.dart';
import 'bayaran_tanpa_bill_detail.dart';

class TanpaBillAmount extends StatelessWidget {
  final controller = Get.put(TanpaBillAmountController());
  bool isFirst = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 55),
            child: Text(
              "Payment Without Bill and Amount".tr,
              style: styles.heading4,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                color: constants.primaryColor,
                child: Obx(
                  () => Text(
                    controller.name.value,
                    style: styles.heading1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                color: constants.primaryColor,
                child: Text(
                  controller.agencyName,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              // AppBar(
              //   shape: const MyShapeBorder(-10.0),
              //   automaticallyImplyLeading: false,
              // ),
              // SizedBox(height: 5),
              Obx(
                () {
                  List<Widget> products = [];
                  for (var element in controller.bills)
                    products.add(
                      BillInput2(
                        item: element,
                        id: element.id!,
                        isFavorite: element.favorite!.obs,
                        count: controller.count,
                        select: element.select,
                        controller: element.amount2,
                        title: element.detail!,
                        total: controller.total,
                        total2: controller.total2,
                        onPressed: () {},
                        onPressed2: () {
                          element.billMask.toString();
                        },
                        rounding: element.rounding,
                        textInputType: TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                        onChanged: (value) async {
                          print(value);
                          print("val " + value.toString());
                          if (value != "" && value.length > 1) {
                            value = value.replaceAll(",", "");
                            var a = {};
                            // ignore: unused_local_variable
                            num roundingAmount;
                            a = await api.GetRounding(value);

                            double test = 0.00;
                            test = double.parse(value) + a['value'];
                            print(test.toString());

                            value = test.toStringAsFixed(2).toString();

                            element.rounding.value = value.toString();

                            print(a.isNotEmpty);
                            print("a['value']");
                            print(a['value']);

                            Timer(Duration(seconds: 1), () {
                              print(
                                  "Yeah, this line is printed after 3 seconds");
                              element.amount2.text = value.toString();
                            });
                          }
                          // String newValue =
                          //     value.replaceAll(',', '').replaceAll('.', '');
                          // print("value");
                          // print(value);
                          // print(value.length);
                          // if (value.isEmpty || newValue == '00') {
                          //   element.amount2.text = "0.00";
                          //   element.amount2.selection = TextSelection.collapsed(
                          //       offset: element.amount2.text.length);

                          //   controller.total.value =
                          //       double.parse(element.amount2.text);
                          //   isFirst = true;
                          //   return;
                          // }
                          // double value1 = double.parse(newValue);
                          // if (!isFirst) value1 = value1 * 100;
                          // value =
                          //     NumberFormat.currency(customPattern: '######.##')
                          //         .format(value1 / 100);

                          // element.amount2.value = TextEditingValue(
                          //   text: value,
                          //   selection:
                          //       TextSelection.collapsed(offset: value.length),
                          // );
                          // controller.total.value = double.parse(value);

                          // controller.roundingAmount.value = "0.00";
                          // double _roundingAmount = 0.0;
                          // double _actualAmount = 0.0;

                          // print("element.amount2.value.text");
                          // print(element.amount2.value.text);

                          // // Get rounding amount
                          // var response = await api
                          //     .roundingAdjustment(element.amount2.value.text);
                          // Rounding rounding = Rounding.fromJson(response.data);

                          // print("rounding.value.toString()");
                          // print(rounding.value.toString());

                          // // Original/Actual amount of bill entered by user
                          // _actualAmount +=
                          //     num.parse(element.amount2.value.text);

                          // // Rounding amount of each bill
                          // _roundingAmount += rounding.value!;

                          // double a = double.parse(element.amount2.text) +
                          //     _roundingAmount;
                          // element.amount2.text = a.toStringAsFixed(2);
                        },
                      ),
                    );
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: products,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: constants.secondaryColor,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Container(
                        height: 40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Total'.tr),
                            Obx(
                              () => Text(
                                "RM ${controller.total2.toStringAsFixed(2)}",
                                style: styles.heading13Primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: AddToCartButton(
                  onPressed: () => controller.addToCart(),
                  icon: LineIcons.addToShoppingCart,
                ),
              ),
              Expanded(
                flex: 2,
                child: Obx(
                  () => CheckoutButton(
                    onPressed: () => controller.payNow(),
                    text: "Pay".tr + ' (${controller.count})',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BillInput2 extends StatelessWidget {
  const BillInput2(
      {Key? key,
      required this.title,
      required this.controller,
      this.hintText = "",
      this.onChanged,
      this.textInputType,
      this.select,
      required this.count,
      this.isFavorite,
      required this.onPressed,
      required this.onPressed2,
      required this.id,
      required this.total,
      required this.total2,
      this.rounding,
      this.item})
      : super(key: key);

  final String title;
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final TextInputType? textInputType;
  final RxBool? select;
  final RxNum count;
  final RxBool? isFavorite;
  final Function onPressed;
  final Function onPressed2;
  final int id;
  final RxDouble total;
  final RxNum total2;
  final Bills? item;
  final RxString? rounding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          // color: constants.primaryColor,
          child: Column(
            children: [
              Container(
                // color: constants.primaryColor,
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Container(
                      child: Checkbox(
                        checkColor: Colors.white,
                        // fillColor: Colors.black,
                        value: select!.value,
                        onChanged: (bool? value) {
                          print(value.toString());
                          if (value.toString() == "true") {
                            print(rounding!.value);
                            if (rounding!.value == "") {
                              showAmountError();
                            } else {
                              select!.value = value!;
                              if (select!.value == true) {
                                print("count pluss");
                                count.value++;
                                print(" count.value");
                                print(count.value.toString());
                                total2.value +=
                                    double.parse(controller.value.text);
                                // total2.value += double.parse(rounding!.value);
                              } else if (select!.value == false) {
                                print("count minuss");
                                count.value--;
                                total2.value -=
                                    double.parse(controller.value.text);
                                // total2.value -= double.parse(rounding!.value);
                              }
                            }
                          } else {
                            select!.value = value!;
                            if (select!.value == true) {
                              print("count pluss");
                              count.value++;
                              print(" count.value");
                              print(count.value.toString());
                              total2.value +=
                                  double.parse(controller.value.text);
                              // total2.value += double.parse(rounding!.value);
                            } else if (select!.value == false) {
                              print("count minuss");
                              count.value--;
                              total2.value -=
                                  double.parse(controller.value.text);
                              // total2.value -= double.parse(rounding!.value);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    // color: constants.primaryColor,
                    child: TextFormField(
                      onChanged: onChanged,
                      // (val) async {
                      // print(val);
                      // print("val " + val.toString());
                      // if (val != "" && val.length > 1) {
                      //   val = val.replaceAll(",", "");
                      //   var a = {};
                      //   num roundingAmount;
                      //   a = await api.GetRounding(val);

                      //   double test = 0.00;
                      //   test = double.parse(val) + a['value'];
                      //   print(test.toString());

                      //   val = test.toStringAsFixed(2).toString();

                      //   rounding!.value = val.toString();

                      //   print(a.isNotEmpty);
                      //   print("a['value']");
                      //   print(a['value']);

                      //   roundingAmount = a['value'];
                      // }
                      // },
                      inputFormatters: <TextInputFormatter>[
                        CurrencyTextInputFormatter(
                          decimalDigits: 2,
                          symbol: '',
                        ),
                      ],
                      controller: controller,
                      keyboardType: textInputType,
                      decoration: styles.inputDecoration.copyWith(
                        contentPadding: EdgeInsets.all(16),
                        alignLabelWithHint: true,
                        hintText: hintText,
                        filled: true,
                        isDense: true,
                        fillColor: Colors.white,
                        prefixIcon: Text(
                          "\t\tRM ",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        prefixIconConstraints:
                            BoxConstraints(minWidth: 0, minHeight: 0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      icon: Icon((isFavorite!.value)
                          ? Icons.favorite
                          : Icons.favorite_border),
                      color: Constants().primaryColor,
                      onPressed: () async {
                        print(id.toString());
                        ErrorResponse response =
                            await api.favABill(id.toString());
                        if (isLoggedIn()) {
                          isFavorite!.value = !isFavorite!
                              .value; // if (!response.message.contains("removed")) {
                          if (!response.message.contains("removed")) {
                            Get.showSnackbar(GetSnackBar(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              message:
                                  "Added to favourite list successfully.".tr,
                              backgroundColor: Color(0xFF33A36D),
                              snackPosition: SnackPosition.TOP,
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            Get.showSnackbar(GetSnackBar(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              message:
                                  "Successfully removed from favorites list."
                                      .tr,
                              backgroundColor: Colors.red,
                              snackPosition: SnackPosition.TOP,
                              isDismissible: true,
                              duration: Duration(seconds: 2),
                            ));
                            // Get.snackbar(
                            //   "",
                            //   backgroundColor: Color(0xFF33A36D),
                            //   colorText: Colors.white,
                            // );
                          }
                          onPressed();
                        } else {
                          Get.to(() => LoginScreen());
                        }
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.visibility),
                    color: Constants().primaryColor,
                    onPressed: () async {
                      Get.to(
                        () => BayaranTanpaBillDetail(
                          item!.billMask.toString(),
                        ),
                      );
                      onPressed2();
                    },
                  ),
                ],
              ),
              // Divider()
            ],
          ),
        ),
        // Obx(
        //   () => Text(rounding!.value),
        // )
      ],
    );
  }
}
