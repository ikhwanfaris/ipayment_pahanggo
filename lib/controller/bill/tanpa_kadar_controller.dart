import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/events/event.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/models/cart/add_cart_request.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

class TanpaKadarController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final TextEditingController amount = TextEditingController(text: "0.00");

  RxString name = "".obs;
  RxDouble total = 0.0.obs;
  String serviceId = "0";
  String agencyName = "";

  @override
  void onInit() async {
    String serviceRefNum = Get.arguments["serviceRefNum"];
    agencyName = Get.arguments["agencyName"];
    ErrorResponse response = await api.getServiceDetail(serviceRefNum);
    if (response.data == null) return;
    log(jsonEncode(response.data));
    Services data = Services.fromJson(response.data);
 log("Bill type: ${data.billType.type}");
    name.value = data.name!;
    serviceId = data.id.toString();
    super.onInit();
  }

  addToCart() async {
    if (total.value == 0) {
      showAmountError();
      return;
    }
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }

    ErrorResponse response = await api.roundingAdjustment(amount.text);
    var rounding = Rounding.fromJson(response.data);
    var parseAmount = num.parse(amount.text);
    parseAmount += rounding.value!;
    log(parseAmount.toStringAsFixed(2));

    var request = AddCartRequest(
      serviceId: serviceId,
      amount: parseAmount.toDouble(),
    );

    response = await api.addToCartDzaf(request);
    eventBus.fire(CartUpdatedEvent());

    Get.snackbar(
      snackPosition: SnackPosition.TOP,
      "Success".tr,
      response.message,
      backgroundColor: Color(0xFF33A36D),
      colorText: Colors.white,
    );

    // ErrorResponse response = await api.addToCart(request);
  }

  payNow() async {
    if (total.value == 0) {
      showAmountError();
      return;
    }
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }
    // ErrorResponse response = await api.roundingAdjustment(amount.text);
    // var rounding = Rounding.fromJson(response.data);
    // var parseAmount = num.parse(amount.text);
    // parseAmount += rounding.value;

    // Get.to(() => Summary(), arguments: {
    //   "billType": 4,
    //   "data": BayaranTanpaBilAmaun(
    //     agencyName: Get.arguments["agencyName"],
    //     serviceId: serviceId,
    //     serviceName: name.value,
    //     amount: amount.text,
    //   )
    // });
  }
}

class BayaranTanpaBilAmaun {
  final String serviceId;
  final String serviceName;
  final String amount;
  final String agencyName;

  BayaranTanpaBilAmaun({
    required this.serviceId,
    required this.serviceName,
    required this.amount,
    required this.agencyName,
  });

  // Map<String, dynamic> toJson(ProductDetail product) {
  //   return <String, dynamic>{
  //     'isTicket': product.isTicket,
  //     'title': product.title,
  //     'unit': product.unit,
  //     'units': product.units,
  //     'items': product.items,
  //     'prices': product.prices,
  //     'actualValue': product.actualValue,
  //   };
  // }
}
