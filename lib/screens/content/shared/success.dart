import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:get/get.dart';

import '../../../components/primary_button_two.dart';

class SuccessPayment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/dist/Success.svg'),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text("Your payment has successful.".tr,
                  style: TextStyle(fontSize: 22)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    "Amount Paid:".tr,
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 1,
                  child: Text(
                    textAlign: TextAlign.start,
                    "RM${Get.arguments["amount"]}",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 4,
                    child: Text(
                      "Reference No".tr,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 7,
                    child: Text(
                      Get.arguments["reference_number"],
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: Get.width * 0.7,
              child: PrimaryButton2(
                text: "Generate Receipt".tr,
                onPressed: () async {
                  // log("SINI");
                  // log(Get.arguments["transaction_id"]);
                  // ErrorResponse response = await api.printReceipt(Get.arguments["transaction_id"]);
                  // log(response.data);
                  Get.to(() => MenuScreen(initalPage: 3));
                },
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: Get.width * 0.7,
              child: PrimaryButton(
                text: "Home".tr,
                onPressed: () => Get.offAll(() => MenuScreen(initalPage: 0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
