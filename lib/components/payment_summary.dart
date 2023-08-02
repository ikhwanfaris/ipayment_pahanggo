
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/controller/bill/bill_detail_controller.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class PaymentSummary extends StatelessWidget {
  const PaymentSummary({
    super.key,
    required this.controller,
  });

  final BillDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding:
          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
          color: constants.secondaryColor,
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Payment Summary".tr,
            style: TextStyle(
              color: constants.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          controller.bill?.billTypeId != 2
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          "Actual Amount".tr,
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        (controller.bill?.amountController?.text != "")
                            ? Text(
                                "RM${controller.bill?.nettCalculations?.original ?? 0}",
                                style: TextStyle(fontSize: 18),
                              )
                            : Container(),
                      ],
                    ),
                    // VerticalDetail(
                    //   title: "Discount Amount".tr,
                    //   detail:
                    //       "RM${controller.bill!.discountAmount}",
                    // ),
                    // VerticalDetail(
                    //   title: "Tax Amount".tr,
                    //   detail: "RM${controller.bill!.taxAmount}",
                    // ),
                    // VerticalDetail(
                    //   title: "Amount With Tax".tr,
                    //   detail:
                    //       "RM${controller.bill!.amountWithTax}",
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10),
                      child: DottedLine(),
                    ),
                  ],
                )
              : Container(),
          Row(
            children: [
              Text(
                "Actual Amount".tr,
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              (controller.bill?.amountController?.text != "")
                  ? Text(
                      "RM${controller.bill?.amountController?.text}",
                      style: TextStyle(fontSize: 18),
                    )
                  : Container(),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Adjustment amount".tr,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    width: Get.width * 0.6,
                    child: Text(
                      "The amount is adjusted based on the Malaysia Treasury Circular."
                          .tr,
                      style: TextStyle(
                          fontSize: 12, color: Colors.black54),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Obx(
                () => Text(
                  "RM ${controller.roundingAmount}",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          DottedLine(),
          Row(
            children: [
              Text(
                "Payment Total".tr,
                style: TextStyle(fontSize: 18),
              ),
              Spacer(),
              controller.bill?.billTypeId == 2
                  ? Flexible(
                      child: TextField(
                        controller:
                            controller.bill?.amountController,
                        decoration:
                            InputDecoration(prefixText: "RM "),
                      ),
                    )
                  : Text(
                      "RM${controller.jumlah.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 18),
                    ),
            ],
          ),
          SizedBox(height: 10),
          DottedLine(dashColor: Colors.white, dashGapLength: 0),
          SizedBox(height: 20),
          Text(
            "Please select payment method.".tr,
            style: TextStyle(
              color: constants.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: constants.secondaryColor.shade100,
                borderRadius: BorderRadius.circular(10)),
            child: Flex(
              direction: Axis.horizontal,
              children: [
                // Flexible(
                //   flex: 1,
                //   fit: FlexFit.tight,
                //   child:
                //       Obx(() => controller.paymentType.value.icon),
                // ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 5,
                  child: Obx(
                    () => Text(
                      controller.setupGatewayName(
                          controller.paymentType.value),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: IconButton(
                    onPressed: () {
                      Get.bottomSheet(
                        PaymentTypeList(controller: controller),
                        isScrollControlled: true,
                      );
                    },
                    icon: Icon(Icons.edit_outlined),
                    color: constants.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Obx(
            () => (controller.paymentType.value.id == 2)
                ? Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        "List of banks".tr,
                        style: TextStyle(
                            color: constants.primaryColor),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(
                            horizontal: 10),
                        decoration: BoxDecoration(
                            color: constants
                                .secondaryColor.shade100,
                            borderRadius:
                                BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Icon(Icons.location_city_rounded),
                            SizedBox(width: 10),
                            Expanded(
                              child: Obx(
                                () => DropdownButton<BankType>(
                                  value: controller
                                      .selectedBank.value,
                                  isExpanded: true,
                                  items:
                                      controller.listDropdown,
                                  onChanged: (value) {
                                    controller.selectedBank
                                        .value = value!;
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}

class PaymentTypeList extends StatelessWidget {
  const PaymentTypeList({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final BillDetailController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 200),
      child: Column(
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
            backgroundColor: constants.secondaryColor,
            centerTitle: true,
            leading: Container(),
            title: Text(
              "Payment Options".tr,
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
          ListView(
            shrinkWrap: true,
            children: [
              for (var payment in controller.paymentGateways)
                ListTile(
                  leading: Icon(Icons.credit_card),
                  title: Text(controller.setupGatewayName(payment)),
                  onTap: () {
                    controller.paymentType.value = payment;
                    Get.back();
                  },
                ),
            ],
          )
        ],
      ),
    );
  }
}
