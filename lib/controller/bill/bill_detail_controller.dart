import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/events/event.dart';
import 'package:flutterbase/models/contents/add_cart_request.dart';
import 'package:flutterbase/models/contents/bank.dart';
import 'package:flutterbase/models/contents/bill.dart';
import 'package:flutterbase/models/payments/payment_gateway.dart';
import 'package:flutterbase/models/payments/payments.dart';
import 'package:flutterbase/models/payments/rounding.dart';
import 'package:flutterbase/models/shared/translatable.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/screens/content/home/duitnow_qr.dart';
import 'package:flutterbase/screens/content/home/payment.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

class BillDetailController extends GetxController {
  String title = "";
  num jumlah = 0;
  List<DropdownMenuItem<BankType>> listDropdown = [];
  Rx<BankType> selectedBank =
      BankType(code: '', name: '', type: '', url: '').obs;
  Rx<PaymentGateway> paymentType = PaymentGateway(id: 1).obs;
  RxList<PaymentGateway> paymentGateways = <PaymentGateway>[].obs;
  Bill? bill;
  List<Map> transactionItems = [];
  RxDouble roundingAmount = 0.0.obs;
  RxBool isLoading = RxBool(false);
  BottomBarController barController = BottomBarController(false);

  @override
  void onInit() async {
    isLoading.value = true;
    print(Get.arguments);
    bill = await Bill.fetch(Get.arguments['id']);
    print(bill!.id);
    isLoading.value = false;
    barController.clear();
    barController.add(billId: bill!.id, bill!.nettCalculations!.due!);
    // bill = Get.arguments as Bill;
    // jumlah = bill!.nettCalculations?.total ?? 0;
    // await calculateRounding();
    // await setupPaymentGateway();
    // await setupBankList();
    super.onInit();
  }

  Future<void> calculateRounding() async {
    var response =
        await api.roundingAdjustment(bill?.amountController?.text ?? "0");
    if (response.isSuccessful) {
      Rounding rounding = Rounding.fromJson(response.data);
      roundingAmount.value = rounding.value;
      bill?.amountController?.text =
          (num.parse(bill?.amountController?.text ?? "0") + rounding.value)
              .toStringAsFixed(2);
    }
  }

  String setupGatewayName(PaymentGateway paymentGateway) {
    String currentLocale = Get.locale?.languageCode ?? "en";

    for (Translatables element in paymentGateway.translatables ?? []) {
      if (element.language == currentLocale) {
        return element.content ?? paymentGateway.name!;
      }
    }
    return paymentGateway.name ?? "";
  }

  Future<void> setupPaymentGateway() async {
    ErrorResponse response = await api.getPaymentGateways();
    List<dynamic> raw = response.data as List<dynamic>;
    paymentGateways.value = raw
        .map((e) => PaymentGateway.fromJson(e))
        .where(
          (element) => element.isActive == 1,
        )
        .toList();
    paymentType.value = paymentGateways[0];
  }

  Future<void> setupBankList() async {
    ErrorResponse response = await api.getBankList();
    List<dynamic> raw = response.data as List<dynamic>;
    List<Bank> _banks = raw.map((e) => Bank.fromJson(e)).toList();
    final Map<String, Bank> bankMap = new Map();
    _banks.forEach((item) {
      bankMap[item.name] = item;
    });

    List<Bank> parseBanks = bankMap.values
        .toList()
        .where((element) => element.active)
        .where((element) => element.redirectUrls != null)
        .toList();

    List<BankType> bankTypes = [];
    for (var parseBank in parseBanks) {
      for (var bank in parseBank.redirectUrls!) {
        if (bank.type != " ") {
          bankTypes.add(
            BankType(
              code: parseBank.code,
              name: parseBank.name,
              type: bank.type,
              url: bank.url,
            ),
          );
        }
      }
    }
    final Map<String, BankType> bankTypeMap = new Map();
    bankTypes.forEach((item) {
      bankTypeMap[item.name + item.type] = item;
    });

    listDropdown = bankTypeMap.values
        .toList()
        // .where((element) => element.active)
        // .where((element) => element.redirectUrls != null)
        .map((e) => DropdownMenuItem<BankType>(
              child: Text(
                  "${e.name} (${(e.type == 'COR' ? 'Corporate' : 'Retail')})"),
              value: e,
            ))
        .toList();

    selectedBank.value = listDropdown[0].value!;
  }

  pay() async {
    bool? value = await confirmPaymentv2();
    if (value != null) {
      List<int> cartIds = [];
      int billType = bill?.billTypeId ?? 1;
      if (billType == 1) {
        transactionItems.add({
          "bill_id": bill!.id!,
          "amount": bill!.nettCalculations!.total,
          "details": {},
          // "bill_id": bill.id.toString(),
          // "service_id": bill.serviceId.toString(),
          // "payment_description": bill.service?.name ?? "-",
          // "extra_fields": {},
          // "amount": (bill.nettCalculations?.total ?? 0).toString()
        });
      } else if (billType == 2) {
        var amount = double.parse(bill!.amountController!.text);
        transactionItems.add({
          "bill_id": bill!.id!,
          "amount": amount,
          "details": {},
          // "bill_id": bill.id.toString(),
          // "service_id": bill.serviceId.toString(),
          // "payment_description": bill.service?.name ?? "-",
          // "extra_fields": {},
          // "amount": (bill.nettCalculations?.total ?? 0).toString()
        });
      }

      ErrorResponse response = await api
          .addToCartDzaf(AddCartRequest(items: jsonEncode(transactionItems)));
      List<dynamic> rawIds = response.data["cart_ids"];
      cartIds = rawIds.map((e) => e as int).toList();

      response = await api.paymentsv2(
        CartPayRequest(
          ids: cartIds,
          source: "mobile",
          paymentMethod: paymentType.value.id.toString(),
          redirectUrl:
              (paymentType.value.id == 2) ? selectedBank.value.url : null,
          bankCode:
              (paymentType.value.id == 2) ? selectedBank.value.code : null,
          bankType:
              (paymentType.value.id == 2) ? selectedBank.value.type : null,
        ),
      );

      // log(payments.qrImage ?? "");

      Payments payments = Payments.fromJson(response.data);
      payments.paymentType = paymentType.value.id;
      if (paymentType.value.id == 3) {
        Uint8List bytes = Base64Decoder().convert(payments.qrImage!);
        // Get.defaultDialog(content: Image.memory(bytes));
        Get.to(() => DuitnowQR(), arguments: {
          "payments": payments,
          "image": bytes,
        });
      } else {
        payments.referenceNumber =
            response.data["redirect"].toString().split("/").last;
        payments.amount = jumlah.toStringAsFixed(2);

        Get.to(() => Payment(), arguments: payments
            // arguments: {
            //   "url": payments.redirect,
            //   "amount": jumlah.toStringAsFixed(2),
            //   "reference_number":
            //       response.data["redirect"].toString().split("/").last,
            // },
            );
      }
    }
  }

  addToCart() async {
    // if (total.value == 0) {
    //   showQuantityError();
    //   return;
    // }
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }

    List<AddCartRequest> requests = [];
    if (bill?.billTypeId == 1) {
      requests.add(
        AddCartRequest(
          amount: (bill?.nettCalculations?.total ?? 0).toDouble(),
          billId: bill?.id.toString(),
        ),
      );
    } else if (bill?.billTypeId == 2) {
      var amount = bill?.amountController?.text ?? "0";
      var response = await api.roundingAdjustment(amount);
      var rounding = Rounding.fromJson(response.data);
      requests.add(
        AddCartRequest(
          amount: (num.parse(amount) + rounding.value).toDouble(),
          billId: bill?.id.toString(),
        ),
      );
    }

    var responses =
        await Future.wait(requests.map((e) => api.addToCartDzaf(e)));
    eventBus.fire(CartUpdatedEvent());

    // ignore: unused_local_variable
    for (var response in responses) {
      if (response.message == "Bil telah wujud didalam troli") {
        Get.snackbar(
          snackPosition: SnackPosition.TOP,
          "Error".tr,
          "Bill exist in cart".tr,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (response.message == "Berjaya dimasukkan ke dalam troli") {
        Get.snackbar(
          snackPosition: SnackPosition.TOP,
          "Success".tr,
          "Added to cart successfully.".tr,
          backgroundColor: Color(0xFF33A36D),
          colorText: Colors.white,
        );
      }
    }

    // ErrorResponse response = await api.addToCart(request);
  }
}

// enum PaymentType {
//   duitNowQR(
//       "DuitNow QR",
//       ImageIcon(
//         AssetImage("assets/dist/DuitNowQR_Primary.png"),
//         size: 30,
//       ),
//       1),
//   card("Kad", Icon(Icons.credit_card), 2),
//   duitNowTransfer(
//       "DuitNow Online Banking",
//       ImageIcon(
//         AssetImage("assets/dist/DuitNowQR_Primary.png"),
//         size: 30,
//       ),
//       5);

//   const PaymentType(this.name, this.icon, this.value);
//   final String name;
//   final Widget icon;
//   final num value;
// }

class BankType {
  final String code;
  final String name;
  final String type;
  final String url;

  BankType({
    required this.code,
    required this.name,
    required this.type,
    required this.url,
  });
}
