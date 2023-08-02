// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/controller/bill/bill_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/screens/content/home/bill/bill_detail.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../components/vertical_detail.dart';

class Bill extends StatelessWidget {
  final controller = Get.put(BillController());
  bool isFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right:55),
            child: Text(
              "Search".tr + " " + "Bill".tr,
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
                color: constants.primaryColor,
                child: Obx(
                  () => Text(
                    controller.name.value,
                    style: styles.heading1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Obx(
                () => (controller.isThirdPartyPayment.value)
                    ? Container()
                    : Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            color: constants.primaryColor,
                            child: Text(
                              "Identity Number or Bill Reference Number (Agency or iPayment).".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: constants.primaryColor,
                            child: TextFormField(
                              controller: controller.searchBillText,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  Icons.search,
                                  color: constants.primaryColor,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              // (controller.amountRequired.value)
              //     ? BillInput(
              //         controller: controller.amount,
              //         title: "Jumlah Bayaran",
              //         textInputType:
              //             TextInputType.numberWithOptions(decimal: true),
              //         onChanged: (value) {
              //           String newValue =
              //               value.replaceAll(',', '').replaceAll('.', '');
              //           if (value.isEmpty || newValue == '00') {
              //             controller.amount.clear();
              //             isFirst = true;
              //             return;
              //           }
              //           double value1 = double.parse(newValue);
              //           if (!isFirst) value1 = value1 * 100;
              //           value =
              //               NumberFormat.currency(customPattern: '######.##')
              //                   .format(value1 / 100);

              //           controller.amount.value = TextEditingValue(
              //             text: value,
              //             selection:
              //                 TextSelection.collapsed(offset: value.length),
              //           );
              //         },
              //       )
              //     : Container(),
              AppBar(
                shape: const MyShapeBorder(-10.0),
                automaticallyImplyLeading: false,
              ),
              SizedBox(height: 10),
              Obx(
                () => Column(
                  children: (controller.bills.isEmpty)
                      ? [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                // border: Border.all(color: Constants().tenColor, width: 2),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: Offset(0, 2), // changes position of shadow
                                  ),
                                ]),
                            margin: EdgeInsets.only(top: 100),
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "You have no bills to pay.".tr,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          )
                        ]
                      : controller.bills
                          .map(
                            (element) => Card(
                              color: (element.status == "Aktif") ? constants.secondaryColor.shade100 : Colors.grey,
                              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                              child: ExpansionTile(
                                // iconColor: constants.primaryColor,
                                leading: Obx(
                                  () => Checkbox(
                                    onChanged: (element.status == "Aktif")
                                        ? (value) {
                                            element.isSelected!.value = value!;
                                            if (value) {
                                              controller.total.value += element.nettCalculations?.total ?? 0;
                                            } else {
                                              controller.total.value -= element.nettCalculations?.total ?? 0;
                                            }
                                          }
                                        : null,
                                    value: element.isSelected!.value,
                                  ),
                                ),
                                title: Text(element.detail ?? ""),
                                subtitle: Text(
                                  dateFormatterDisplay.format(element.createdAt ?? DateTime.now()),
                                ),

                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () => controller.favoriteBill(
                                        element.isFavorite!,
                                        element.id!,
                                      ),
                                      child: Obx(
                                        () => element.isFavorite?.value ?? RxBool(false).value ? Icon(Icons.favorite) : Icon(Icons.favorite_outline),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () => Get.to(() => BillDetail(), arguments: element),
                                      child: Icon(Icons.remove_red_eye),
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () => controller.addToCart(true, bill: element),
                                      child: Icon(LineIcons.addToShoppingCart, size: 30),
                                    ),
                                  ],
                                ),
                                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  VerticalDetail(
                                    title: "Agency Bill Ref. No.".tr,
                                    detail: element.referenceNumber ?? "-",
                                  ),
                                  VerticalDetail(
                                    title: "iPayment Ref. No.".tr,
                                    detail: element.billNumber ?? "",
                                  ),
                                  VerticalDetail(
                                    title: "Customer Name".tr,
                                    detail: element.customerName ?? "-",
                                  ),
                                  VerticalDetail(
                                    title: "Agency".tr,
                                    detail: element.agency?.name ?? "-",
                                  ),
                                  VerticalDetail(
                                    title: "Department".tr,
                                    detail: element.agency?.department.departmentName ?? "-",
                                  ),
                                  VerticalDetail(
                                    title: "Ministry".tr,
                                    detail: element.agency?.ministry.ministryName ?? "-",
                                  ),
                                  VerticalDetail(
                                    title: "Bill Reference Date".tr,
                                    detail: dateFormatterDisplay.format(element.startAt ?? DateTime.now()),
                                  ),
                                  VerticalDetail(
                                    title: "Payment Due Date".tr,
                                    detail: dateFormatterDisplay.format(element.endAt ?? DateTime.now()),
                                  ),
                                  VerticalDetail(
                                    title: "Status".tr,
                                    detail: element.status ?? "-",
                                  ),
                                  element.billTypeId == 1
                                      ? VerticalDetail(
                                          title: "Payment Total".tr,
                                          detail: "RM " + moneyFormat(double.parse(element.nettCalculations?.total.toString() ?? '0'))
                                        )
                                      : Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Payment Total".tr,
                                                style: TextStyle(color: constants.primaryColor, fontSize: 16),
                                              ),
                                              SizedBox(height: 5),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    "RM ",
                                                    style: TextStyle(fontSize: 16),
                                                  ),
                                                  Container(
                                                    width: Get.width * 0.4,
                                                    height: 35,
                                                    child: TextField(
                                                      controller: element.amountController,
                                                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                        ),
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                      ),
                                                      onChanged: (value) => controller.onChangeAmount(value, element, isFirst),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                      ),
                                  // SizedBox(height: 10),
                                  // VerticalDetail(
                                  //   title: "Charge Bearer".tr,
                                  //   detail: element.service?.chargedTo ?? "",
                                  // ),
                                  SizedBox(height: 10)
                                ],
                              ),
                            ),
                          )
                          .toList(),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => (controller.bills.where((p0) => p0.isSelected!.value == true).isNotEmpty)
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: AddToCartButton(
                        onPressed: () => controller.addToCart(false),
                        icon: LineIcons.addToShoppingCart,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 8,
                      child: Obx(
                        () => PrimaryButton(
                          onPressed: () => controller.payNow(),
                          text: 'RM${controller.total.toStringAsFixed(2)} - ' + "Pay".tr,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Padding(padding: EdgeInsets.zero)),
    );
  }
}

class BillInput extends StatelessWidget {
  const BillInput({
    Key? key,
    required this.title,
    required this.controller,
    this.hintText = "",
    this.onChanged,
    this.textInputType,
  }) : super(key: key);

  final String title;
  final String hintText;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: constants.primaryColor,
      child: Column(
        children: [
          Container(
            color: constants.primaryColor,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          SizedBox(height: 10),
          Container(
            color: constants.primaryColor,
            child: TextFormField(
              onChanged: onChanged,
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
                prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}