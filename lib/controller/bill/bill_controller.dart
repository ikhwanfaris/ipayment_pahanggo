import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/events/event.dart';
import 'package:flutterbase/models/contents/add_cart_request.dart';
import 'package:flutterbase/models/contents/bill.dart';
import 'package:flutterbase/models/contents/service.dart';
import 'package:flutterbase/models/payments/rounding.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/screens/content/home/summary.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BillController extends GetxController {
  Rx<DateTime> selectedDate = DateTime.now().obs;
  final TextEditingController searchBillText = TextEditingController();
  final TextEditingController amount = TextEditingController();
  RxString identityCode = "".obs;
  RxBool amountRequired = false.obs;
  RxList<Bill> bills = <Bill>[].obs;

  RxString name = "".obs;
  RxDouble total = 0.0.obs;
  int serviceId = 0;
  String serviceRefNum = "";
  RxBool isThirdPartyPayment = false.obs;

  @override
  void onInit() async {
    super.onInit();
    serviceRefNum = Get.arguments["serviceRefNum"];
    amountRequired.value = Get.arguments["amountRequired"] as bool;

    log("Service Ref Number: $serviceRefNum");
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(Get.context!));
    ErrorResponse response = await api.getServiceDetail(serviceRefNum);
    Navigator.pop(Get.context!);
    if (response.data == null) return;
    log(jsonEncode(response.data));
    ServiceModel data = ServiceModel.fromJson(response.data);
    isThirdPartyPayment.value =
        (data.allowThirdPartyPayment == "0") ? true : false;
    serviceId = data.id;
    if (data.billType != null) log("Bill type: ${data.billType!.type}");
    name.value = data.name;
    // firstSearch();
    searchBill();
  }

  firstSearch() async {
    bool isPublic = true;
    String _token = store.getItem('token').toString();
    if (_token != "null") {
      isPublic = false;
    }

    ErrorResponse response =
        await api.getBills(serviceRefNum + ",", public: isPublic);
    Navigator.pop(Get.context!);
    if (response.isSuccessful) {
      List<dynamic> raw = response.data as List<dynamic>;
      bills.value = raw.map((e) => Bill.fromJson(e)).map((e) {
        log(e.billType!.id.toString());
        e.isSelected = false.obs;
        e.amountController = TextEditingController(text: "0.00");
        // ignore: unrelated_type_equality_checks
        e.isFavorite = RxBool((e.favorite == 1));
        return e;
      }).toList();
      // log(bills.first.status);
      // bills.first.status = "Tidak Aktif";
      // bills.first.service.chargedTo = "Pelanggan";
    }
  }

  favoriteBill(RxBool isFavorite, int billId) async {
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }
    isFavorite.value = !isFavorite.value;

    await api.favABill(billId.toString());
    if (isFavorite.value) {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "Success".tr,
        "Added to favourite list successfully.".tr,
        backgroundColor: Color(0xFF33A36D),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "Success".tr,
        "Successfully removed from favorites list.".tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  onChangeAmount(String value, Bill element, bool isFirst) async {
    String newValue = value.replaceAll(',', '').replaceAll('.', '');
    if (value.isEmpty || newValue == '00') {
      element.amountController?.text = "0.00";
      element.amountController?.selection = TextSelection.collapsed(
        offset: 4,
      );
      isFirst = true;
      total.value = 0;
      return;
    }
    double value1 = double.parse(newValue);
    if (!isFirst) value1 = value1 * 100;
    value =
        NumberFormat.currency(customPattern: '######.##').format(value1 / 100);

    log(value);

    element.amountController?.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(
        offset: value.length,
      ),
    );

    await calculateTotal();
  }

  calculateTotal() async {
    total.value = bills
        .where((p0) => p0.amountController?.text != "")
        .map((element) => num.parse(element.amountController?.text ?? "0"))
        .toList()
        .reduce((value, element) => value + element)
        .toDouble();
    log(total.toString());

    var response = await api.roundingAdjustment(total.value.toStringAsFixed(2));
    Rounding roundingAmount = Rounding.fromJson(response.data);
    total.value = roundingAmount.value + total.value;
  }

  searchBill() {
    // ignore: unused_local_variable
    bool isPublic = true;
    String _token = store.getItem('token').toString();
    if (_token != "null") {
      isPublic = false;
    }
    searchBillText.addListener(() {
      identityCode.value = searchBillText.text;
    });

    debounce(identityCode, (value) async {
      bills.clear();
      // if (value == "") {
      //   return;
      // }
      // ErrorResponse response = await api.getBills("$serviceRefNum,$value", public: isPublic);

      ErrorResponse response;
      // if (isPublic) {
      response = await api.searchBill(value.toString(), "$serviceRefNum");
      // } else {
      //   // response =
      //   //     await api.getBills("$serviceRefNum,$value", public: isPublic);
      //   response = await api.getBills("$serviceRefNum",
      //       public: isPublic, identityCode: value.toString());
      // }

      if (response.isSuccessful) {
        List<dynamic> raw = response.data as List<dynamic>;
        bills.value = raw.map((e) => Bill.fromJson(e)).map((e) {
          e.isSelected = false.obs;
          e.amountController = TextEditingController(text: "0.00");
          // ignore: unrelated_type_equality_checks
          e.isFavorite = RxBool((e.favorite == 1));
          return e;
        }).toList();
        // log(bills.first.status);
        // bills.first.status = "Tidak Aktif";
        // bills.first.service.chargedTo = "Pelanggan";
      }
    }, time: 0.seconds);
  }

  addToCart(bool isSingle, {Bill? bill}) async {
    // if (total.value == 0) {
    //   showQuantityError();
    //   return;
    // }
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }

    List<Bill> selectedBills = [];
    if (isSingle) {
      selectedBills.add(bill!);
    } else {
      selectedBills =
          bills.where((p0) => p0.isSelected?.value == true).toList();
    }

    bool containKerajaan = selectedBills
            .where((element) => element.service?.chargedTo == "Kerajaan")
            .toList()
            .length >
        0;

    bool containPelanggan = selectedBills
            .where((element) => element.service?.chargedTo == "Pelanggan")
            .toList()
            .length >
        0;

    if (containKerajaan && containPelanggan) {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "Error".tr,
        "Single checkout is allowed for bills under the same category only.".tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    // for (var bill in selectedBills) {
    //   if (bill.amountController?.text == "") {
    //     Get.defaultDialog(content: Text("Sila masukkan amaun!"));
    //     return;
    //   }
    // }

    List<AddCartRequest> requests = [];
    for (var element in selectedBills) {
      if (element.billTypeId == 1) {
        requests.add(
          AddCartRequest(
            amount: (element.nettCalculations?.total ?? 0).toDouble(),
            billId: element.id.toString(),
          ),
        );
      } else if (element.billTypeId == 2) {
        var amount = element.amountController?.text ?? "0";
        var response = await api.roundingAdjustment(amount);
        var rounding = Rounding.fromJson(response.data);
        requests.add(
          AddCartRequest(
            amount: (num.parse(amount) + rounding.value).toDouble(),
            billId: element.id.toString(),
          ),
        );
      }
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
          // response.message,
          backgroundColor: Color(0xFF33A36D),
          colorText: Colors.white,
        );
      }
    }
  }

  payNow() {
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }

    var selectedBills =
        bills.where((p0) => p0.isSelected!.value == true).toList();
    bool containKerajaan = selectedBills
            .where((element) => element.service?.chargedTo == "Kerajaan")
            .toList()
            .length >
        0;

    bool containPelanggan = selectedBills
            .where((element) => element.service?.chargedTo == "Pelanggan")
            .toList()
            .length >
        0;

    if (containKerajaan && containPelanggan) {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "Error".tr,
        "Single checkout is allowed for bills under the same category only.".tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    Get.to(
      () => Summary(),
      arguments: {
        "data": bills.where((p0) => p0.isSelected!.value == true).toList(),
        "title": name.value,
        "billType": (amountRequired.value) ? 2 : 1
      },
    );
  }
}

// class ProductDetail {
//   bool isTicket;
//   String title;
//   String? unit;
//   List<num>? prices;
//   List<String>? items;
//   List<String>? units;
//   List<RxInt>? actualValue;

//   ProductDetail({
//     required this.isTicket,
//     required this.title,
//     this.unit,
//     this.units,
//     this.items,
//     this.prices,
//     this.actualValue,
//   });

//   Map<String, dynamic> toJson(ProductDetail product) {
//     return <String, dynamic>{
//       'isTicket': product.isTicket,
//       'title': product.title,
//       'unit': product.unit,
//       'units': product.units,
//       'items': product.items,
//       'prices': product.prices,
//       'actualValue': product.actualValue,
//     };
//   }
// }
