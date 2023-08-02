import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/events/event.dart';
import 'package:flutterbase/models/contents/add_cart_request.dart';
import 'package:flutterbase/models/contents/service.dart';
import 'package:flutterbase/models/payments/rounding.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/screens/content/home/summary.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

import '../../models/bills/bills.dart' as model;

class TanpaBillAmountController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final TextEditingController amount = TextEditingController(text: "0.00");

  RxString name = "".obs;
  RxDouble total = 0.0.obs;
  String serviceId = "0";
  String billId = "0";
  String agencyName = "";
  RxList<model.Bills> bills = <model.Bills>[].obs;
  RxNum count = RxNum(0);
  RxString roundingAmount = "".obs;
  RxNum total2 = RxNum(0);
  List<Map> transactionItems = [];

  @override
  void onInit() async {
    String serviceRefNum = Get.arguments["serviceRefNum"];
    agencyName = Get.arguments["agencyName"];
    print(serviceRefNum);
    ErrorResponse response = await api.getServiceDetail(serviceRefNum);
    print("getServiceDetail");
    if (response.data == null) return;
    print(jsonEncode(response.data));
    ServiceModel data = ServiceModel.fromJson(response.data);
    print("ServiceModel");
    print(jsonEncode(response.data));
    if (data.billType != null) print("Bill type: ${data.billType!.type}");
    if (data.billType != null) print("Bill id: ${data.billType!.id}");
    name.value = data.name;
    serviceId = data.id.toString();
    billId = data.billType!.id.toString();
    bills.value = await api.getBillByService(serviceId: serviceId);
    print(bills.length.toString());
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
    parseAmount += rounding.value;
    log(parseAmount.toStringAsFixed(2));

    for (var i = 0; i < bills.length; i++) {
      print(bills[i].select.value.toString());
      print(bills[i].amount2.value.text.toString());
      if (bills[i].select.value == true) {
        transactionItems.add({
          "bill_id": bills[i].id,
          "amount": bills[i].amount2.value.text,
          "details": {},
        });
      }
    }

    print("Items: ${jsonEncode(transactionItems)}");
    ErrorResponse response2 = await api
        .addToCartDzaf(AddCartRequest(items: jsonEncode(transactionItems)));
    print("POST api/carts/add response: ${response2.data}");
    print("response.message");
    print(response2.message);
    if (response2.message == "Bil telah wujud didalam troli") {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "Error".tr,
        "Bill exist in cart".tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else if (response2.message == "Berjaya dimasukkan ke dalam troli") {
      eventBus.fire(CartUpdatedEvent());

      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "Success".tr,
        response2.message,
        backgroundColor: Color(0xFF33A36D),
        colorText: Colors.white,
      );
    }

    // ErrorResponse response = await api.addToCart(request);
  }

  payNow() async {
    if (total2.value == 0) {
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

    Get.to(() => Summary(), arguments: {
      "billType": 4,
      "total": total2.value,
      "matrixes": bills,
      "data": BayaranTanpaBilAmaun(
        agencyName: Get.arguments["agencyName"],
        serviceId: serviceId,
        serviceName: name.value,
        amount: amount.text,
      )
    });
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
