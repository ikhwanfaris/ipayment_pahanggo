import 'package:flutter/material.dart';
import 'package:flutterbase/controller/duitnow_qr_controller.dart';
import 'package:flutterbase/screens/home/menu.dart';
import 'package:flutterbase/screens/shared/fail.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class DuitnowQR extends StatelessWidget {
  final controller = Get.put(DuitnowQRController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        backgroundColor: Color(0xFFf9f9f9),
        iconTheme: IconThemeData(
          color: constants.primaryColor,
        ),
        title: Center(
            child: Text(
          "Duitnow QR",
          style: styles.heading5,
        )),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Get.to(() => FailPayment()),
          child: Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => Get.offAll(() => MenuScreen()),
            icon: Icon(LineIcons.times),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 100),
          SizedBox(
            width: Get.width * 0.7,
            child: Text(
              "Please scan the QR code to proceed the payment.".tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Image.memory(
              Get.arguments["image"],
              scale: 2,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: Get.width * 0.7,
            child: Text(
              "Please wait and do not close.".tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: Get.width * 0.6,
            child: ElevatedButton.icon(
              icon: Icon(Icons.share),
              label: Text("Share QR", style: TextStyle(fontSize: 16)),
              onPressed: () => controller.shareQr(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Constants().sixColor,
                minimumSize: const Size(300, 60),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
