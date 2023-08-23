import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/payment_calculation.dart';
import 'package:flutterbase/controller/bill/bill_detail_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(color: constants.secondaryColor, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Payment Summary".tr,
                style: TextStyle(
                  color: constants.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if(controller.bill!.billTypeId == 1)
                InkWell(
                  onTap: (){
                    Get.to(() => PaymentDetails(controller.bill!));
                  },
                  child: Icon(LineIcons.infoCircle, color: constants.primaryColor, size: 14,),
                ),
            ],
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                Text(
                  "Actual Amount".tr,
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Text(
                  'RM ' + moneyFormat(controller.bill!.nettCalculations.original.toDouble()),
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          if(controller.bill!.nettCalculations.changes!= 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                children: [
                  Text(
                    "Amount Changes".tr,
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    'RM ' + moneyFormat(controller.bill!.nettCalculations.changes.toDouble()),
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          if(controller.bill!.nettCalculations.rounding!= 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          "The amount is adjusted based on the Malaysia Treasury Circular.".tr,
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    'RM ' + moneyFormat(controller.bill!.nettCalculations.rounding.toDouble()),
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          if(controller.bill!.nettCalculations.paid> 0)
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Paid Total".tr,
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  Text(
                    'RM ' + moneyFormat(controller.bill!.nettCalculations.paid.toDouble()),
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          DottedLine(),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Text(
                  "Payment Total".tr,
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Text(
                  "RM " + moneyFormat(controller.bill!.nettCalculations.due),
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}