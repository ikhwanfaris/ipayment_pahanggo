// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/checkout_button.dart';
import 'package:flutterbase/controller/bill/tanpa_bill_amount_controller.dart';
import 'package:flutterbase/screens/content/home/bill/bill.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class TanpaKadar extends StatelessWidget {
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
                padding: EdgeInsets.only(bottom: 10),
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
                padding: EdgeInsets.only(bottom: 10),
                color: constants.primaryColor,
                child: Text(
                  controller.agencyName,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              BillInput(
                controller: controller.amount,
                title: "Please enter the donation amount".tr,
                textInputType: TextInputType.numberWithOptions(
                    decimal: true, signed: true),
                onChanged: (value) {
                  String newValue =
                      value.replaceAll(',', '').replaceAll('.', '');
                  if (value.isEmpty || newValue == '00') {
                    controller.amount.text = "0.00";
                    controller.amount.selection = TextSelection.collapsed(
                        offset: controller.amount.text.length);

                    controller.total.value =
                        double.parse(controller.amount.text);
                    isFirst = true;
                    return;
                  }
                  double value1 = double.parse(newValue);
                  if (!isFirst) value1 = value1 * 100;
                  value = NumberFormat.currency(customPattern: '######.##')
                      .format(value1 / 100);

                  controller.amount.value = TextEditingValue(
                    text: value,
                    selection: TextSelection.collapsed(offset: value.length),
                  );
                  controller.total.value = double.parse(value);
                },
              ),
              AppBar(
                shape: const MyShapeBorder(-10.0),
                automaticallyImplyLeading: false,
              ),
              SizedBox(height: 10),
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
                              Obx( ()=> Text(
                                "RM${controller.total.toStringAsFixed(2)} - ",
                                style: styles.heading13Primary,
                              ),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                  Expanded(
                    flex: 1,
                    child: AddToCartButton(
                      onPressed: () => controller.addToCart(),
                      icon: LineIcons.addToShoppingCart,
                    ),
                  ),
             Expanded(
                flex: 2,
                child: CheckoutButton(
                    onPressed: () => controller.payNow(),
                    text: "Pay".tr,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
