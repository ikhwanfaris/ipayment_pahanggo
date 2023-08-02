import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterbase/models/payments/payments.dart';
// import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/screens/content/shared/fail.dart';
import 'package:flutterbase/screens/content/shared/success.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
// import 'package:line_icons/line_icons.dart';

class Payment extends StatefulWidget {
  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  InAppWebViewController? webViewController;
  Payments? payments;
  bool isLoading = true;
  // bool gatewayActive = false;

  @override
  void initState() {
    payments = Get.arguments;
    // ignore: todo
    // TODO: implement initState

    Future.delayed(const Duration(seconds: 2)).then((value) {
      url();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFf9f9f9),
        iconTheme: IconThemeData(
          color: constants.primaryColor,
        ),
        leading:
            // null,
            GestureDetector(
          onTap: () => Get.to(() => FailPayment()),
          child: Icon(Icons.arrow_back_ios),
        ),
        elevation: 0,
        // actions: [
        //   IconButton(
        //     onPressed: () => Get.offAll(() => MenuScreen()),
        //     icon: Icon(LineIcons.times),
        //   ),
        // ],
      ),
      body: (isLoading)
          ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultLoadingBar(),
              SizedBox(height: 16),
              Text(
                "Please wait and do not close.".tr,
                style: styles.heading5,
              )
            ],
          ))
          : InAppWebView(
              key: GlobalKey(),
              initialUrlRequest: URLRequest(url: url()),
              onWebViewCreated: (controller) async {
                webViewController = controller;
              },
              onLoadStop: (controller, url) async {
                print(url.toString().split("/").last);
                String endpoint = url.toString().split("/").last;
                if (endpoint.contains("cancel")) {
                  Get.to(() => FailPayment());
                }
                controller.addJavaScriptHandler(
                  handlerName: "callback",
                  callback: (args) {
                    print(args);
                    if (args[0]["status"] == "PAYMENT_SUCCESSFUL") {
                      log("Payments: ${jsonEncode(payments)}");
                      Get.to(
                        () => SuccessPayment(),
                        arguments: {
                          "amount": payments?.amount,
                          "reference_number": (payments?.paymentType == 2)
                              ? url
                                  .toString()
                                  .split("/")
                                  .last
                                  .split("&")
                                  .where((element) =>
                                      element.contains("reference_number"))
                                  .first
                                  .split("=")
                                  .last
                              : payments?.referenceNumber,
                        },
                      );
                    } else if (args[0]["status"] == "PAYMENT_FAILED") {
                      Get.to(() => FailPayment());
                    }
                  },
                );
              },
              // onConsoleMessage: (controller, consoleMessage) {
              //   print(consoleMessage);
              // },
            ),
    );
  }

  Uri url() {
    String? url = payments?.redirect ?? "";

    setState(() {
      if (url.isNotEmpty) {
        isLoading = false;
      }
    });
 
    return Uri.parse(url);
  }
}
