// import 'dart:convert';
// import 'dart:developer';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterbase/models/bills/bills.dart';
// import 'package:flutterbase/models/payments/payments.dart';
// import 'package:flutterbase/screens/home/menu.dart';
import 'package:flutterbase/screens/shared/fail.dart';
import 'package:flutterbase/screens/shared/success.dart';
// import 'package:flutterbase/screens/shared/success.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:flutterbase/utils/rive_animation.dart';
import 'package:get/get.dart';
// import 'package:line_icons/line_icons.dart';

class PaymentScreen extends StatefulWidget {
  final String redirectUrl;

  PaymentScreen({this.redirectUrl = ''});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  InAppWebViewController? webViewController;
  Payment? payments;
  RxBool isLoading = true.obs;
  // bool gatewayActive = false;

  Uri get url => Uri.parse(widget.redirectUrl);

  @override
  void initState() {
    payments = Get.arguments;
    // ignore: todo
    // TODO: implement initState
    // Future.delayed(const Duration(seconds: 2)).then((value) {
    //   url();
    // });

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
      body: Stack(
            children: [
              InAppWebView(
                  key: GlobalKey(),
                  initialUrlRequest: URLRequest(url: url),
                  onWebViewCreated: (controller) async {
                    webViewController = controller;
                  },
                  onLoadStart:(controller, url) {
                    isLoading.value = true;
                  },
                  onLoadStop: (controller, url) async {
                    isLoading.value = false;
                    print(url.toString().split("/").last);
                    String endpoint = url.toString().split("/").last;
                    if (endpoint.contains("cancel")) {
                      Get.to(() => FailPayment());
                    }
                    controller.addJavaScriptHandler(
                      handlerName: "callback",
                      callback: (args) {
                        print(args);
                        print(' PEMBAYARAN STATUS: ${args[0]}');
                        if (args[0]["status"] == "PAYMENT_SUCCESSFUL") {
                          log("WISMIT: ${jsonEncode(payments)}");
                          Get.to(
                            () => SuccessPayment(),
                            arguments: {
                              "amount": payments?.amount,
                              "reference_number":
                                  // (payments?.paymentType == 2)
                                  //     ? url
                                  //         .toString()
                                  //         .split("/")
                                  //         .last
                                  //         .split("&")
                                  //         .where((element) =>
                                  //             element.contains("reference_number"))
                                  //         .first
                                  //         .split("=")
                                  //         .last
                                  //     :
                                  payments?.referenceNumber,
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
              Obx(() => isLoading.value ? Container(
                color: Colors.black54,
                child: Center(
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
                  )
                ),
              ) : SizedBox()),
            ],
          ),
    );
  }
}
