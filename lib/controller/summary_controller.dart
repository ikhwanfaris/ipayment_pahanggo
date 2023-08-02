import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/controller/bill/tanpa_bill_amount_controller.dart';
import 'package:flutterbase/models/contents/add_cart_request.dart';
import 'package:flutterbase/models/contents/bank.dart';
import 'package:flutterbase/models/contents/bill.dart';
import 'package:flutterbase/models/contents/extra_fields.dart';
import 'package:flutterbase/models/contents/matrix.dart';
import 'package:flutterbase/models/payments/payment_gateway.dart';
import 'package:flutterbase/models/payments/payments.dart';
import 'package:flutterbase/models/payments/rounding.dart';
import 'package:flutterbase/models/shared/translatable.dart';
import 'package:flutterbase/screens/content/home/duitnow_qr.dart';
import 'package:flutterbase/screens/content/home/payment.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

import '../models/bills/bills.dart' as model;

class SummaryController extends GetxController {
  String title = "";
  RxInt billType = 0.obs;

  RxList<Matrix> matrixes = <Matrix>[].obs;
  RxList<Products> products = <Products>[].obs;
  RxList<ExtraField> extraFields = <ExtraField>[].obs;
  RxList<model.Bills> billss = <model.Bills>[].obs;
  RxList<SummaryDetail> summaryDetails = RxList();
  RxBool isFirst = true.obs;
  // List<DropdownMenuItem<Bank>> listDropdown = [];
  // Rx<Bank> selectedBank = Bank(code: '', name: '', active: false).obs;

  List<DropdownMenuItem<BankType>> listDropdown = [];
  Rx<BankType> selectedBank =
      BankType(code: '', name: '', type: '', url: '').obs;
  Rx<PaymentGateway> paymentType = PaymentGateway(id: 1, name: "").obs;
  RxList<PaymentGateway> paymentGateways = <PaymentGateway>[].obs;

  List<Map> transactionItems = [];
  List<TextEditingController> totalBilTanpaAmaun = [];

  RxString roundingAmount = "".obs;
  RxString actualAmount = "".obs;
  RxNum jumlah = RxNum(0);

  List<Bill> bills = [];
  int serviceId = 0;

  final TextEditingController typeAheadController = TextEditingController();
  late String selectedCity;
  RxList<Bank> cor = <Bank>[].obs;
  RxList<Bank> ret = <Bank>[].obs;
  RxString bankText = "Select Bank or E-wallet".tr.obs;
  RxString bank = "".obs;

  RxString bankCode = "".obs;
  RxString bankLink = "".obs;
  RxString bankType = "".obs;
  List<String> enquiryModel12 = [];
  List<Bank> enquiryModel4 = [];

  @override
  void onInit() async {
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(Get.context!));
    billType.value = Get.arguments["billType"];
    print("bill type: $billType" + " SummaryController");
    jumlah.value = Get.arguments["total"];
    print("jumlah.value.toString()");
    print(jumlah.value.toString());
    switch (billType.value) {
      case 1:
        setupBill();
        break;
      case 2:
        setupBillTanpaAmount(firstInit: true);
        break;
      case 3:
        setupTanpaKadarSummary();
        break;
      case 4:
        setupTanpaBillAmount();
        break;
      case 5:
        setupTanpaKadarSummary2();
        break;
    }
    await setupPaymentGateway();
    await setupBankList();
    enquiryModel4 = await api.GetPaynetBank();
    // for (var i = 0; i < enquiryModel4.length; i++) {
    //   print(enquiryModel4[i].name.toString());
    // }
    enquiryModel4.removeWhere((item) => item.redirectUrls == null);
    enquiryModel4.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });

    for (var v = 0; v < enquiryModel4.length; v++) {
      for (var q = 0; q < enquiryModel4[v].redirectUrls!.length - 1; q++) {
        if (enquiryModel4[v].redirectUrls!.length == 2) {
          if (enquiryModel4[v].redirectUrls![q].type ==
                  enquiryModel4[v].redirectUrls![q + 1].type ||
              enquiryModel4[v].redirectUrls![q].type == " " ||
              enquiryModel4[v].redirectUrls![q + 1].type == " ") {
            enquiryModel4[v].redirectUrls!.removeLast();
          }
        }
      }
    }
    for (var v = 0; v < enquiryModel4.length; v++) {
      for (var q = 0; q < enquiryModel4[v].redirectUrls!.length; q++) {
        enquiryModel12.add(enquiryModel4[v].name);
      }
    }
    Navigator.pop(Get.context!);
    super.onInit();
  }

  onChangeAmaun(String value) async {
    double _roundingAmount = 0.0;
    double _actualAmount = 0.0;
    jumlah.value = 0;
    for (var element in totalBilTanpaAmaun) {
      print("element.text");
      print(element.text);
      if (element.text.isNotEmpty) jumlah.value += num.parse(element.text);
      // Get rounding amount
      var response = await api.roundingAdjustment(element.text);
      Rounding rounding = Rounding.fromJson(response.data);
      // Original/Actual amount of bill entered by user
      _actualAmount += num.parse(element.text);

      // Rounding amount of each bill
      _roundingAmount += rounding.value;
    }

    roundingAmount.value = _roundingAmount.toStringAsFixed(2);
    actualAmount.value = _actualAmount.toStringAsFixed(2);
    jumlah.value =
        num.parse(roundingAmount.value) + num.parse(actualAmount.value);
  }

  // ========== Bill Type 1 ==========
  setupBill() {
    bills = Get.arguments["data"];
    title = bills.first.agency?.name ?? "-";
    double _actualAmount = 0.0;

    for (var bill in bills) {
      log((bill.nettCalculations?.total ?? 0).toString());
      _actualAmount += bill.nettCalculations?.total ?? 0;
      summaryDetails.add(
        SummaryDetail(
          itemQtys: [],
          title: bill.service?.name ?? "-",
          subTitle: bill.billNumber,
          total: RxNum(bill.nettCalculations?.total ?? 0),
        ),
      );
      jumlah.value +=
          double.parse((bill.nettCalculations?.total ?? 0).toString());
      transactionItems.add({
        "bill_id": bill.id,
        "amount": bill.nettCalculations?.total,
        "details": {},
        // "bill_id": bill.id.toString(),
        // "service_id": bill.serviceId.toString(),
        // "payment_description": bill.service?.name ?? "-",
        // "extra_fields": {},
        // "amount": (bill.nettCalculations?.total ?? 0).toString()
      });
      actualAmount.value = _actualAmount.toStringAsFixed(2);
    }
  }

  // ========== Bill Type 2 ==========
  setupBillTanpaAmount({bool firstInit = false}) async {
    bills = Get.arguments["data"];
    title = bills.first.agency?.name ?? "-";
    roundingAmount.value = "0.00";
    double _roundingAmount = 0.0;
    double _actualAmount = 0.0;

    for (var bill in bills) {
      // Get rounding amount
      var response = await api.roundingAdjustment(bill.amountController!.text);
      Rounding rounding = Rounding.fromJson(response.data);

      // Original/Actual amount of bill entered by user
      _actualAmount += num.parse(bill.amountController!.text);

      // Rounding amount of each bill
      _roundingAmount += rounding.value;

      if (firstInit) totalBilTanpaAmaun.add(bill.amountController!);
      // onChangeAmaun(bill.amountController!.text);
      if (firstInit)
        summaryDetails.add(
          SummaryDetail(
            itemQtys: [],
            title: bill.service?.name ?? "-",
            subTitle: bill.billNumber,
            total: RxNum(num.parse((bill.amountController?.text).toString())),
          ),
        );
      jumlah.value +=
          double.parse((bill.amountController?.text ?? 0).toString());
      num amount = num.parse(bill.amountController!.text) + rounding.value;
      transactionItems.add({
        "service_id": null,
        "bill_id": bill.id,
        "amount": amount,
        "details": {},
        // "service_id": bill.serviceId.toString(),
        // "payment_description": bill.service?.name ?? "-",
        // "extra_fields": {},
      });
    }
    log(jsonEncode(transactionItems));
    roundingAmount.value = _roundingAmount.toStringAsFixed(2);
    actualAmount.value = _actualAmount.toStringAsFixed(2);
    jumlah.value =
        num.parse(roundingAmount.value) + num.parse(actualAmount.value);
  }

  // ========== Bill Type 4 ==========
  setupTanpaBillAmount() async {
    billss = Get.arguments["matrixes"];
    BayaranTanpaBilAmaun data = Get.arguments["data"];
    num total = Get.arguments["total"];
    title = data.agencyName;
    print("total");
    print(total);
    jumlah.value = total;
    print("jumlah.value");
    print(jumlah.value);
    roundingAmount.value = "0.00";
    // ignore: unused_local_variable
    double _roundingAmount = 0.0;
    double _actualAmount = 0.0;

    // Get rounding amount
    var response = await api.roundingAdjustment(data.amount);
    Rounding rounding = Rounding.fromJson(response.data);

    // Original/Actual amount of bill entered by user
    _actualAmount += num.parse(data.amount);

    // Rounding amount of each bill
    _roundingAmount += rounding.value;

    // summaryDetails.add(
    //   SummaryDetail(
    //     itemQtys: [],
    //     title: data.serviceName,
    //     total: RxNum(num.parse(data.amount)),
    //   ),
    // );
    for (var bills in billss) {
      // num total = 0;
      print(bills.select.value.toString());
      if (bills.select.value == true) {
        totalBilTanpaAmaun
            .add(TextEditingController(text: bills.amount2.value.text));
        summaryDetails.add(
          SummaryDetail(
            itemQtys: [],
            title: bills.detail!,
            total: RxNum(jumlah.value),
          ),
        );
      }
    }

    roundingAmount.value = "";
    actualAmount.value = _actualAmount.toStringAsFixed(2);

    // jumlah.value =
    //     num.parse(roundingAmount.value) + num.parse(actualAmount.value);
    for (var i = 0; i < billss.length; i++) {
      print(billss[i].select.value.toString());
      print(billss[i].amount2.value.text.toString());
      if (billss[i].select.value == true) {
        transactionItems.add({
          "bill_id": billss[i].id,
          "amount": billss[i].amount2.value.text,
          "details": {},
        });
      }
    }
  }

  // ========== Bill Type 3 ==========
  setupTanpaKadarSummary() {
    products = Get.arguments["matrixes"];
    extraFields = Get.arguments["extraFields"];
    title = Get.arguments["title"];
    serviceId = Get.arguments["serviceId"];

    // for (var matrix in matrixes) {
    //   num total = 0;
    //   for (var subitem in matrix.subitems) {
    //     List<ItemQty> itemQtys = [];
    //     if (subitem.headers.isNotEmpty) {
    //       for (var quantity in subitem.quantities) {
    //         total += quantity.amount.value * num.parse(quantity.rate.value ?? "0");
    //         if (quantity.amount.value != 0) {
    //           itemQtys.add(
    //             ItemQty(
    //               title: quantity.rate.title,
    //               item: quantity.unit.value ?? "",
    //               value: num.parse(quantity.rate.value ?? "0").toStringAsFixed(2),
    //               quantity: quantity.amount,
    //             ),
    //           );
    //         }
    //       }
    //     } else {}
    //     if (total != 0) {
    //       jumlah.value += total;
    //       summaryDetails.add(
    //         SummaryDetail(
    //           itemQtys: itemQtys,
    //           title: subitem.headers.last.name ?? "",
    //           total: RxNum(total),
    //         ),
    //       );
    //     }
    //   }
    // }

    // for (var product in products) {
    for (var i = 0; i < products.length; i++) {
      // ignore: unused_local_variable
      List<ItemQty> itemQtys = [];
      // ignore: unused_local_variable
      num total = 0;
      print("product.amount.toString()");
      print(products[i].amount.toString());
      if (products[i].amount.value == 0) {
        print(" == null");
      } else if (products[i].amount.value > 0) {
        print(" != null");
        if (products[i].amount.value > 0) {
          summaryDetails.add(
            SummaryDetail(
              subTitle: products[i].amount.toString() +
                  " X RM " +
                  num.parse(products[i].price).toStringAsFixed(2) +
                  " ",
              subsubTitle: products[i].chains,
              itemQtys: [],
              title: products[i].name,
              total: RxNum(total),
            ),
          );

          // itemQtys.add(
          //   ItemQty(
          //     title: products[i].name,
          //     item: "",
          //     value: num.parse(products[i].price).toStringAsFixed(2),
          //     quantity: products[i].amount,
          //   ),
          // );
        }
      }
    }

    // for (var product in matrix.products) {
    // itemQtys.add(
    //   ItemQty(
    //     title: product.name,
    //     item: "",
    //     value: num.parse(product.price).toStringAsFixed(2),
    //     quantity: RxInt(1),
    //   ),
    // );
    // for (var i = 0; i < product.quantities.length; i++) {
    //   Quantity quantity = product.quantities[i];
    //   if (quantity.amount.value != 0) {
    //     total +=
    //         quantity.amount.value * num.parse(quantity.rate.value ?? "0");
    //     if (i == 0 &&
    //         subItem.headers.length != 1 &&
    //         subItem.headers.isNotEmpty) {
    //       itemQtys.add(
    //         ItemQty(
    //           title: subItem.headers.last.name,
    //           item: (subItem.quantities.length == 1)
    //               ? ""
    //               : quantity.rate.title ?? "",
    //           value:
    //               num.parse(quantity.rate.value ?? "0").toStringAsFixed(2),
    //           quantity: quantity.amount,
    //         ),
    //       );
    //     } else {
    //       itemQtys.add(
    //         ItemQty(
    //           item: quantity.rate.title ?? "",
    //           value:
    //               num.parse(quantity.rate.value ?? "0").toStringAsFixed(2),
    //           quantity: quantity.amount,
    //         ),
    //       );
    //     }
    //   }
    // }
    // for (var quantity in subItem.quantities) {

    // }
    // if (total != 0) {
    //   jumlah.value += total;
    //   summaryDetails.add(
    //     SummaryDetail(
    //       itemQtys: itemQtys,
    //       title: subItem.headers.first.name ?? "",
    //       total: RxNum(total),
    //     ),
    //   );
    // }
    // }
    // if (total != 0 && matrix.subitems.first.headers.isNotEmpty) {
    //   jumlah.value += total;
    //   summaryDetails.add(
    //     SummaryDetail(
    //       itemQtys: itemQtys,
    //       title: matrix.subitems.first.headers.first.name ?? "",
    //       total: RxNum(total),
    //     ),
    //   );
    // } else {
    //   jumlah.value += total;
    //   summaryDetails.add(
    //     SummaryDetail(
    //       itemQtys: itemQtys,
    //       title: "",
    //       total: RxNum(total),
    //     ),
    //   );
    // }
    // }
  }

  // ========== Bill Type 5 ==========
  setupTanpaKadarSummary2() {
    billss = Get.arguments["matrixes"];
    extraFields = Get.arguments["extraFields"];
    title = Get.arguments["title"];
    serviceId = Get.arguments["serviceId"];

    for (var bills in billss) {
      num total = 0;
      if (bills.select.value == true) {
        summaryDetails.add(
          SummaryDetail(
            itemQtys: [],
            subTitle: bills.amount1,
            title: bills.detail!,
            total: RxNum(total),
          ),
        );
      }

      // for (var subitem in matrix.subitems) {
      //   List<ItemQty> itemQtys = [];
      //   if (subitem.headers.isNotEmpty) {
      //     for (var quantity in subitem.quantities) {
      //       total += quantity.amount.value * num.parse(quantity.rate.value ?? "0");
      //       if (quantity.amount.value != 0) {
      //         itemQtys.add(
      //           ItemQty(
      //             title: quantity.rate.title,
      //             item: quantity.unit.value ?? "",
      //             value: num.parse(quantity.rate.value ?? "0").toStringAsFixed(2),
      //             quantity: quantity.amount,
      //           ),
      //         );
      //       }
      //     }
      //   } else {}
      //   if (total != 0) {
      //     jumlah.value += total;
      //     summaryDetails.add(
      //       SummaryDetail(
      //         itemQtys: itemQtys,
      //         title: subitem.headers.last.name ?? "",
      //         total: RxNum(total),
      //       ),
      //     );
      //   }
      // }
    }

    // for (var product in products) {
    //   List<ItemQty> itemQtys = [];
    //   num total = 0;
    //   // for (var product in matrix.products) {
    //   itemQtys.add(
    //     ItemQty(
    //       title: product.name,
    //       item: "",
    //       value: num.parse(product.price ?? "0").toStringAsFixed(2),
    //       quantity: RxInt(1),
    //     ),
    //   );

    // for (var i = 0; i < subItem.quantities.length; i++) {
    //   Quantity quantity = subItem.quantities[i];
    //   if (quantity.amount.value != 0) {
    //     total +=
    //         quantity.amount.value * num.parse(quantity.rate.value ?? "0");
    //     if (i == 0 &&
    //         subItem.headers.length != 1 &&
    //         subItem.headers.isNotEmpty) {
    //       itemQtys.add(
    //         ItemQty(
    //           title: subItem.headers.last.name,
    //           item: (subItem.quantities.length == 1)
    //               ? ""
    //               : quantity.rate.title ?? "",
    //           value:
    //               num.parse(quantity.rate.value ?? "0").toStringAsFixed(2),
    //           quantity: quantity.amount,
    //         ),
    //       );
    //     } else {
    //       itemQtys.add(
    //         ItemQty(
    //           item: quantity.rate.title ?? "",
    //           value:
    //               num.parse(quantity.rate.value ?? "0").toStringAsFixed(2),
    //           quantity: quantity.amount,
    //         ),
    //       );
    //     }
    //   }
    // }
    // for (var quantity in subItem.quantities) {

    // }
    // if (total != 0) {
    //   jumlah.value += total;
    //   summaryDetails.add(
    //     SummaryDetail(
    //       itemQtys: itemQtys,
    //       title: subItem.headers.first.name ?? "",
    //       total: RxNum(total),
    //     ),
    //   );
    // }
    // }
    // if (total != 0 && matrix.subitems.first.headers.isNotEmpty) {
    //   jumlah.value += total;
    //   summaryDetails.add(
    //     SummaryDetail(
    //       itemQtys: itemQtys,
    //       title: matrix.subitems.first.headers.first.name ?? "",
    //       total: RxNum(total),
    //     ),
    //   );
    // } else {
    //   jumlah.value += total;
    //   summaryDetails.add(
    //     SummaryDetail(
    //       itemQtys: itemQtys,
    //       title: "",
    //       total: RxNum(total),
    //     ),
    //   );
    // }
    // }
  }

  pay() async {
    // Ask for confirmation payment
    bool? value = await confirmPaymentv2();
    // ignore: unused_local_variable
    String finalAmount = "";

    // Round the amount if the bill is type 2 & 3
    if (billType.value == 2 || billType.value == 3) {
      ErrorResponse response =
          await api.roundingAdjustment(jumlah.toStringAsFixed(2));
      var rounding = Rounding.fromJson(response.data);
      finalAmount = (jumlah.value + rounding.value).toStringAsFixed(2);
    } else {
      finalAmount = jumlah.toStringAsFixed(2);
    }

    if (value != null) {
      List<int> cartIds = [];

      switch (billType.value) {
        case 1:
          print("Items: ${jsonEncode(transactionItems)}");
          ErrorResponse response = await api.addToCartDzaf(
              AddCartRequest(items: jsonEncode(transactionItems)));
          if (response.message == "Bil telah wujud didalam troli") {
            Get.snackbar(
              snackPosition: SnackPosition.TOP,
              "Error".tr,
              "Bill exist in cart".tr,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else if (response.message == "Berjaya dimasukkan ke dalam troli") {
            List<dynamic> rawIds = response.data["cart_ids"];
            cartIds = rawIds.map((e) => e as int).toList();
          }
          break;
        case 2:
          log("Items: ${jsonEncode(transactionItems)}");
          await setupBillTanpaAmount();
          ErrorResponse response = await api.addToCartDzaf(
              AddCartRequest(items: jsonEncode(transactionItems)));
          if (response.message == "Bil telah wujud didalam troli") {
            Get.snackbar(
              snackPosition: SnackPosition.TOP,
              "Error".tr,
              "Bill exist in cart".tr,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else if (response.message == "Berjaya dimasukkan ke dalam troli") {
            List<dynamic> rawIds = response.data["cart_ids"];
            cartIds = rawIds.map((e) => e as int).toList();
          }
          break;
        case 4:
          log("Items: ${jsonEncode(transactionItems)}");
          ErrorResponse response = await api.addToCartDzaf(
              AddCartRequest(items: jsonEncode(transactionItems)));
          if (response.message == "Bil telah wujud didalam troli") {
            Get.snackbar(
              snackPosition: SnackPosition.TOP,
              "Error".tr,
              "Bill exist in cart".tr,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else if (response.message == "Berjaya dimasukkan ke dalam troli") {
            List<dynamic> rawIds = response.data["cart_ids"];
            cartIds = rawIds.map((e) => e as int).toList();
          }
          break;
        case 3:
          // var putRequest = AddCartRequest();
          log("addToCart payload: ${jsonEncode(AddCartRequest(
            serviceId: serviceId.toString(),
            amount: jumlah.value.toDouble(),
          ))}");
          ErrorResponse response = await api.addToCartDzaf(AddCartRequest(
            serviceId: serviceId.toString(),
            amount: jumlah.value.toDouble(),
          ));
          if (response.message == "Bil telah wujud didalam troli") {
            Get.snackbar(
              snackPosition: SnackPosition.TOP,
              "Error".tr,
              "Bill exist in cart".tr,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else if (response.message == "Berjaya dimasukkan ke dalam troli") {
            int cartId = response.data["cart_id"];
            cartIds.add(cartId);

            log("Matrix detail: ${jsonEncode(matrixes)}");
            var putRequest = AddCartRequest(
              amount: jumlah.value.toDouble(),
              details: jsonEncode([
                {"items": matrixes},
                {"extra_fields": extraFields}
              ]),
            );
            await api.updateCart(putRequest, cartId);
          }

          // await ApiCart().update(cartId, body: putRequest.toJson());
          // await ApiCart().update(cartId, body: putRequest.toJson());
          break;
        case 5:
          // var putRequest = AddCartRequest();
          print("billss.length.toString()");
          print(billss.length.toString());
          for (var i = 0; i < billss.length; i++) {
            print(i.toString());
            print(billss[i].select.value.toString());
            if (billss[i].select.value == true) {
              transactionItems.add({
                "bill_id": billss[i].id,
                "amount": billss[i].amount1,
                "details": {},
                // "bill_id": bill.id.toString(),
                // "service_id": bill.serviceId.toString(),
                // "payment_description": bill.service?.name ?? "-",
                // "extra_fields": {},
                // "amount": (bill.nettCalculations?.total ?? 0).toString()
              });
            }
          }
          print("Items: ${jsonEncode(transactionItems)}");
          ErrorResponse response = await api.addToCartDzaf(
              AddCartRequest(items: jsonEncode(transactionItems)));
          if (response.message == "Bil telah wujud didalam troli") {
            Get.snackbar(
              snackPosition: SnackPosition.TOP,
              "Error".tr,
              "Bill exist in cart".tr,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          } else if (response.message == "Berjaya dimasukkan ke dalam troli") {
            List rawIds = [];
            if (transactionItems.length == 1) {
              rawIds = [response.data["cart_id"]];
            } else {
              rawIds = response.data["cart_ids"];
            }
            cartIds = rawIds.map((e) => e as int).toList();
            // log("Matrix detail: ${jsonEncode(matrixes)}");
            // log("Amount: ${jumlah.value.toDouble()}");
            // log("Cart_id: $cartId");
            // var putRequest = AddCartRequest(
            //   amount: jumlah.value.toDouble(),
            //   details: jsonEncode([
            //     {"items": matrixes},
            //     {"extra_fields": extraFields}
            //   ]),
            // );
            // log("Update Request: ${putRequest.toJson()}");
            // await ApiCart().update(cartId, body: putRequest.toJson());
          }

          // await ApiCart().update(cartId, body: putRequest.toJson());
          break;
        default:
      }

      log(jsonEncode(CartPayRequest(
        ids: cartIds,
        source: "mobile",
        paymentMethod: paymentType.value.id.toString(),
        redirectUrl: (paymentType.value.id == 2) ? bankLink.value : null,
        bankCode: (paymentType.value.id == 2) ? bankCode.value : null,
      )));

      ErrorResponse response = await api.paymentsv2(
        CartPayRequest(
          ids: cartIds,
          source: "mobile",
          paymentMethod: paymentType.value.id.toString(),
          redirectUrl: (paymentType.value.id == 2) ? bankLink.value : null,
          bankCode: (paymentType.value.id == 2) ? bankCode.value : null,
          bankType: (paymentType.value.id == 2) ? bankType.value : null,
        ),
      );

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
        log("Reference Number: ${payments.redirect}");
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

  String setupGatewayName(PaymentGateway paymentGateway) {
    String currentLocale = Get.locale?.languageCode ?? "en";

    for (Translatables element in paymentGateway.translatables ?? []) {
      if (element.language == currentLocale) {
        return element.content ?? paymentGateway.name!;
      }
    }
    if (paymentGateway.name == "") {
      paymentGateway.name = "List of Banks/E-wallet".tr;
    }
    return paymentGateway.name!;
  }

  List<String> getSuggestions(
    String query,
  ) {
    enquiryModel12 = enquiryModel12.toSet().toList();
    for (var i = 0; i < enquiryModel12.length; i++) {
      print(enquiryModel12[i].toString());
    }
    List<String> matches = <String>[];
    matches.addAll(enquiryModel12);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  Future<void> setupPaymentGateway() async {
    ErrorResponse response = await api.getPaymentGateways();
    List<dynamic> raw = response.data as List<dynamic>;
    paymentGateways.value = raw.map((e) => PaymentGateway.fromJson(e)).toList();

    // paymentType.value = paymentGateways[0];
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

    log(jsonEncode(parseBanks));
    _banks.sort((a, b) {
      return a.name.toLowerCase().compareTo(b.name.toLowerCase());
    });
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
    for (var v = 0; v < enquiryModel4.length; v++) {
      for (var q = 0; q < enquiryModel4[v].redirectUrls!.length; q++) {
        enquiryModel12.add(enquiryModel4[v].name);
      }
    }
  }
}

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

class SummaryDetail {
  final String title;
  final String? subTitle;
  final List<Chains>? subsubTitle;
  final RxNum total;
  final List<Products> itemQtys;

  SummaryDetail({
    required this.itemQtys,
    required this.title,
    this.subTitle,
    this.subsubTitle,
    required this.total,
  });
}

class SummaryDetail2 {
  final String title;
  final String? subTitle;
  final RxNum total;
  final Map<String, ItemQty> itemQtys;

  SummaryDetail2({
    required this.itemQtys,
    required this.title,
    this.subTitle,
    required this.total,
  });
}

class ItemQty {
  final String item;
  final String value;
  final RxInt quantity;
  final String? title;

  ItemQty({
    this.title,
    required this.item,
    required this.value,
    required this.quantity,
  });
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
