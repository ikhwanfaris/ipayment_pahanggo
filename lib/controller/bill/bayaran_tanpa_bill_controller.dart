import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/events/event.dart';
import 'package:flutterbase/models/contents/add_cart_request.dart';
import 'package:flutterbase/models/contents/daily_quota.dart';
import 'package:flutterbase/models/contents/extra_fields.dart';
import 'package:flutterbase/models/contents/matrix.dart';
import 'package:flutterbase/models/contents/service.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/screens/content/home/summary.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

import '../../models/bills/bills.dart';
import '../home_controller.dart';

class BayaranTanpaBillController extends GetxController {
  BayaranTanpaBillController();
  Rx<DateTime>? selectedDate;

  RxString name = "".obs;
  RxNum total = RxNum(0);
  RxList<Matrix> matrixes = <Matrix>[].obs;
  RxList<ExtraField> extraFields = <ExtraField>[].obs;
  RxList<Products> products = <Products>[].obs;
  RxList<RxList<FilterItem>> filters = <RxList<FilterItem>>[].obs;
  RxList<Bills> bills = <Bills>[].obs;
  int serviceId = 0;
  String serviceRefNum = "";
  RxBool isLoading = false.obs;
  int billType = 0;
  Rx<DailyQuota> dailyQuota = Rx(DailyQuota());
  RxBool isFirst = true.obs;
  RxBool disableAdd = false.obs;
  RxInt currentQuota = 0.obs;
  RxInt todayQuota = 0.obs;
  RxBool hasdailyQuota = false.obs;
  RxNum count = RxNum(0);
  BottomBarController barController = BottomBarController(false);

  final RxBool isChecked = false.obs;
  final RxBool isSelect = false.obs;
  late ServiceModel data;
  RxInt countItem = RxInt(0);
  RxInt wanted = RxInt(0);
  List<Map> transactionItems = [];
  var filter = Rx<String>('').obs; // Use Rx<String> for the filter.
  var items = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();
    print("Arguements: ${Get.arguments}");
    billType = Get.arguments["billType"];
    serviceRefNum = Get.arguments["serviceRefNum"];
    serviceId = Get.arguments["serviceId"];
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(Get.context!));
    print("serviceRefNum: $serviceRefNum " +
        name.toString() +
        " BayaranTanpaBillController ");
    ErrorResponse response = await api.getServiceDetail(serviceRefNum);
    Navigator.pop(Get.context!);
    if (response.data == null) return;
    data = ServiceModel.fromJson(response.data);
    name.value = data.name;
    print("Service ID: $serviceId " +
        name.toString() +
        " BayaranTanpaBillController ");
    setupMatrix(serviceId.toString());

    barController.clear();

    // dummy list of category
    items.addAll([
      'Item 1',
      'Item 2',
      'Item 3',
    ]);
  }

  void removeItem(int index) {
    items.removeAt(index);
  }

  setupMatrix(String serviceId) async {
    if (billType == 5) {
      bills.value = await api.getBillByService(serviceId: serviceId);
      print(bills.length.toString());
      // print("Data: ${jsonEncode(response.data)}");

      // bills.value = response.data;
    } else if (billType == 3) {
      ErrorResponse response = await api.getServiceMatrix(serviceId: serviceId);
      print(response.message);
      print("Matrix: ${jsonEncode(response.data)}");
      Map raw = response.data ?? {};
      if (raw.isEmpty) {
        return;
      }
      products.value = data.matrix!.products;
      List<List<FilterItem>> regularList = data.matrix!.filters;
      // Convert each inner List<FilterItem> to RxList<FilterItem>
      List<RxList<FilterItem>> reactiveList =
          regularList.map((innerList) => innerList.obs).toList();

      // Assign the reactive list to filters.value
      filters.value = reactiveList;

      List<dynamic> rawExtraFields = data.extraFields ?? [];
      // Rx<DateTime>

      // if (raw.last["extra_fields"] != null) raw.removeLast();
      // matrixes.value = rawMatrix.map((e) => Matrix.fromJson(e)).toList();
      print("1 " + matrixes.length.toString());
      // print("2 " + matrixes[0].hasDailyQuota.toString());
      // print("3 " + matrixes[0].hasDailyQuota.toString());
      // hasdailyQuota.value = matrixes[0].hasDailyQuota!;
      extraFields.value =
          rawExtraFields.map((e) => ExtraField.fromJson(e)).toList();
      extraFields.value = extraFields.map((e) {
        switch (e.type) {
          case "date":
            e.value = Rx<DateTime>(DateTime.now());
            // if (matrixes.first.hasDailyQuota ?? false) {
            //   todayQuota.value = matrixes.first.dailyQuota ?? 0;
            //   (e.value as Rx<DateTime>).listenAndPump((DateTime p0) async {
            //     int productId =
            //         matrixes.first.subitems.first.headers.first.id ?? 0;
            //     ErrorResponse response =
            //         await api.getDailyQuota(productId.toString(), p0);
            //     print(jsonEncode(response.data));
            //     dailyQuota.value = DailyQuota.fromJson(response.data);
            //   });
            // }
            break;
          case "textarea":
            e.value = Rx(TextEditingController());
            break;
          case "text":
            e.value = Rx(TextEditingController());
            break;
          default:
        }
        return e;
      }).toList();
    }
  }

  addToCart() async {
    print("addToCart");
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }
    if (billType == 5) {
    } else if (total.value == 0) {
      showAmountError();
      return;
    }
    var copyMatrix =
        matrixes.map((element) => Matrix.fromJson(element.toJson())).toList();
    print(jsonEncode(copyMatrix));
    // List<int> toRemoveCategory = [];
    // for (var i = 0; i < copyMatrix.length; i++) {
    //   var matrix = copyMatrix[i];
    //   List<int> toRemoveParent = [];
    //   for (var i = 0; i < matrix.subItems.length; i++) {
    //     var subItem = matrix.subItems[i];
    //     List<int> toRemove = [];
    //     for (var i = 0; i < subItem.quantities.length; i++) {
    //       if (subItem.quantities[i].amount.value == 0) {
    //         toRemove.add(i);
    //       }
    //     }
    //     for (var index in toRemove.reversed) {
    //       subItem.quantities.removeAt(index);
    //     }r
    //     if (subItem.quantities.isEmpty) toRemoveParent.add(i);
    //   }
    //   for (var index in toRemoveParent.reversed) {
    //     matrix.subItems.removeAt(index);
    //   }
    //   if (matrix.subItems.isEmpty) toRemoveCategory.add(i);
    // }
    // for (var index in toRemoveCategory.reversed) {
    //   copyMatrix.removeAt(index);
    // }

    // NEW
    var request = AddCartRequest(
      serviceId: serviceId.toString(),
      amount: total.toDouble(),
    );
    print("POST api/carts/add request: ${request.toJson()}");
    ErrorResponse response = await api.addToCartDzaf(request);
    print("POST api/carts/add response: ${response.data}");
    print("POST api/carts/add response: ${jsonEncode(extraFields)}\]");
    print(response.message);
    if (response.message == "") {
      int cartId = response.data["cart_id"];

      var putRequest = AddCartRequest(
        amount: total.toDouble(),
        details: jsonEncode([
          {"items": copyMatrix},
          {"extra_fields": extraFields}
        ]),
      );

      log("PUT api/carts/<cart_id> request: ${putRequest.toJson()}");
      api.updateCart(putRequest, cartId);
      // await ApiCart().update(cartId, body: putRequest.toJson());
      // response = await api.updateCart(putRequest, cartId);
      log("PUT  api/carts/<cart_id> response: ${response.data}");
      eventBus.fire(CartUpdatedEvent());

      //  OLD
      // var request = AddCartRequest(
      //   amount: total.toStringAsFixed(2),
      //   serviceId: serviceId.toString(),
      //   details: jsonEncode(copyMatrix),
      // );

      // ErrorResponse response = await api.addToCartDzaf(request);
      // eventBus.fire(CartUpdatedEvent());

      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "Success".tr,
        response.message,
        backgroundColor: Color(0xFF33A36D),
        colorText: Colors.white,
      );
    } else {}
  }

  bayar() {
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }
    for (var i = 0; i < extraFields.length; i++) {
      if (extraFields[i].type == "date") {
        if (extraFields[i].value.toString() == "") {
          showExtraFieldError();
          return;
        }
      }
      if (extraFields[i].type == "textarea") {
        if (extraFields[i].value.value.text.toString() == "") {
          showExtraFieldError();
          return;
        }
      }
    }
    if (total.value == 0) {
      showQuantityError();
      return;
    }
    print(total.value.toString());

    Get.to(
      () => Summary(),
      arguments: {
        "matrixes": products,
        "extraFields": extraFields,
        "title": name.value,
        "total": total.value,
        "billType": billType,
        "serviceId": serviceId,
      },
    );
  }

  addToCart3() async {
    print("addToCart3");
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }

    if (total.value == 0) {
      showAmountError();
      return;
    }
    var copyMatrix =
        matrixes.map((element) => Matrix.fromJson(element.toJson())).toList();
    print(jsonEncode(copyMatrix));
    // List<int> toRemoveCategory = [];
    // for (var i = 0; i < copyMatrix.length; i++) {
    //   var matrix = copyMatrix[i];
    //   List<int> toRemoveParent = [];
    //   for (var i = 0; i < matrix.subItems.length; i++) {
    //     var subItem = matrix.subItems[i];
    //     List<int> toRemove = [];
    //     for (var i = 0; i < subItem.quantities.length; i++) {
    //       if (subItem.quantities[i].amount.value == 0) {
    //         toRemove.add(i);
    //       }
    //     }
    //     for (var index in toRemove.reversed) {
    //       subItem.quantities.removeAt(index);
    //     }r
    //     if (subItem.quantities.isEmpty) toRemoveParent.add(i);
    //   }
    //   for (var index in toRemoveParent.reversed) {
    //     matrix.subItems.removeAt(index);
    //   }
    //   if (matrix.subItems.isEmpty) toRemoveCategory.add(i);
    // }
    // for (var index in toRemoveCategory.reversed) {
    //   copyMatrix.removeAt(index);
    // }

    // NEW
    var request = AddCartRequest(
      serviceId: serviceId.toString(),
      amount: total.toDouble(),
    );
    print("POST api/carts/add request: ${request.toJson()}");
    ErrorResponse response = await api.addToCartDzaf(request);
    print("POST api/carts/add response: ${response.data}");
    print("POST api/carts/add response: ${jsonEncode(extraFields)}\]");
    print("response.message");
    print(response.message);
    if (response.message == "") {
      int cartId = response.data["cart_id"];

      var putRequest = AddCartRequest(
        amount: total.toDouble(),
        details: jsonEncode([
          {"items": copyMatrix},
          {"extra_fields": extraFields}
        ]),
      );

      log("PUT api/carts/<cart_id> request: ${putRequest.toJson()}");
      api.updateCart(putRequest, cartId);
      // await ApiCart().update(cartId, body: putRequest.toJson());
      // response = await api.updateCart(putRequest, cartId);
      log("PUT  api/carts/<cart_id> response: ${response.data}");
      eventBus.fire(CartUpdatedEvent());

      //  OLD
      // var request = AddCartRequest(
      //   amount: total.toStringAsFixed(2),
      //   serviceId: serviceId.toString(),
      //   details: jsonEncode(copyMatrix),
      // );

      // ErrorResponse response = await api.addToCartDzaf(request);
      // eventBus.fire(CartUpdatedEvent());

      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "Success".tr,
        response.message,
        backgroundColor: Color(0xFF33A36D),
        colorText: Colors.white,
      );
    } else {}
  }

  bayar3() {
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }
    for (var i = 0; i < extraFields.length; i++) {
      if (extraFields[i].type == "date") {
        if (extraFields[i].value.toString() == "") {
          showExtraFieldError();
          return;
        }
      }
      if (extraFields[i].type == "textarea") {
        if (extraFields[i].value.value.text.toString() == "") {
          showExtraFieldError();
          return;
        }
      }
    }
    if (total.value == 0) {
      showQuantityError();
      return;
    }
    print(total.value.toString());

    for (var i = 0; i < products.length; i++) {
      print(products[i].amount.toString());
    }
    Get.to(
      () => Summary(),
      arguments: {
        "matrixes": products,
        "extraFields": extraFields,
        "title": name.value,
        "total": total.value,
        "billType": billType,
        "serviceId": serviceId,
      },
    );
  }

  addToCart5() async {
    print("addToCart5");
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }

    if (total.value == 0) {
      showSelectError();
      return;
    }
    // var copyMatrix =
    //     matrixes.map((element) => Matrix.fromJson(element.toJson())).toList();
    // print(jsonEncode(copyMatrix));
    for (var i = 0; i < bills.length; i++) {
      print(bills[i].select.value.toString());
      if (bills[i].select.value == true) {
        transactionItems.add({
          "bill_id": bills[i].id,
          // "amount": bills[i].amount1,
          "details": {},
          // "bill_id": bill.id.toString(),
          // "service_id": bill.serviceId.toString(),
          // "payment_description": bill.service?.name ?? "-",
          // "extra_fields": {},
          // "amount": (bill.nettCalculations?.total ?? 0).toString()
        });
      }
    }
    // List<int> toRemoveCategory = [];
    // for (var i = 0; i < copyMatrix.length; i++) {
    //   var matrix = copyMatrix[i];
    //   List<int> toRemoveParent = [];
    //   for (var i = 0; i < matrix.subItems.length; i++) {
    //     var subItem = matrix.subItems[i];
    //     List<int> toRemove = [];
    //     for (var i = 0; i < subItem.quantities.length; i++) {
    //       if (subItem.quantities[i].amount.value == 0) {
    //         toRemove.add(i);
    //       }
    //     }
    //     for (var index in toRemove.reversed) {
    //       subItem.quantities.removeAt(index);
    //     }r
    //     if (subItem.quantities.isEmpty) toRemoveParent.add(i);
    //   }
    //   for (var index in toRemoveParent.reversed) {
    //     matrix.subItems.removeAt(index);
    //   }
    //   if (matrix.subItems.isEmpty) toRemoveCategory.add(i);
    // }
    // for (var index in toRemoveCategory.reversed) {
    //   copyMatrix.removeAt(index);
    // }

    // NEW
    // var request = AddCartRequest(
    //   serviceId: serviceId.toString(),
    //   amount: total.toDouble(),
    // );
    print("Items: ${jsonEncode(transactionItems)}");
    ErrorResponse response = await api
        .addToCartDzaf(AddCartRequest(items: jsonEncode(transactionItems)));
    print("POST api/carts/add response: ${response.data}");
    print("POST api/carts/add response: ${jsonEncode(extraFields)}\]");
    print("response.message");
    print(response.message);
    if (response.message == "Berjaya dimasukkan ke dalam troli") {
      // int cartId = response.data["cart_id"];

      // var putRequest = AddCartRequest(
      //   amount: total.toDouble(),
      //   details: jsonEncode([
      //     {"items": copyMatrix},
      //     {"extra_fields": extraFields}
      //   ]),
      // );

      // log("PUT api/carts/<cart_id> request: ${putRequest.toJson()}");
      // api.updateCart(putRequest, cartId);
      // await ApiCart().update(cartId, body: putRequest.toJson());
      // response = await api.updateCart(putRequest, cartId);
      // log("PUT  api/carts/<cart_id> response: ${response.data}");
      eventBus.fire(CartUpdatedEvent());

      //  OLD
      // var request = AddCartRequest(
      //   amount: total.toStringAsFixed(2),
      //   serviceId: serviceId.toString(),
      //   details: jsonEncode(copyMatrix),
      // );

      // ErrorResponse response = await api.addToCartDzaf(request);
      // eventBus.fire(CartUpdatedEvent());

      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "Success".tr,
        response.message,
        backgroundColor: Color(0xFF33A36D),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        snackPosition: SnackPosition.TOP,
        "Error".tr,
        "Bill exist in cart".tr,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  bayar5() {
    String _token = store.getItem('token').toString();
    if (_token == "null") {
      Get.to(() => LoginScreen());
      return;
    }
    for (var i = 0; i < extraFields.length; i++) {
      if (extraFields[i].type == "date") {
        if (extraFields[i].value.toString() == "") {
          showExtraFieldError();
          return;
        }
      }
      if (extraFields[i].type == "textarea") {
        if (extraFields[i].value.value.text.toString() == "") {
          showExtraFieldError();
          return;
        }
      }
    }
    if (total.value == 0) {
      showQuantityError();
      return;
    }
    print(total.value.toString());

    for (var i = 0; i < products.length; i++) {
      print(products[i].amount.toString());
    }
    Get.to(
      () => Summary(),
      arguments: {
        "matrixes": bills,
        "extraFields": extraFields,
        "title": name.value,
        "total": total.value,
        "billType": billType,
        "serviceId": serviceId,
      },
    );
  }

  favourite(String serviceId) async {
    print("Service ID: $serviceId" + " name: SubmenuController");
    // ignore: unused_local_variable

    ErrorResponse response = await api.favABill(serviceId);
    print("response.message.toString()");
    print(response.message.toString());
    await Get.find<HomeController>().setupFavorite();
    print("MESSAGE: $response.message" + " SubmenuController");

    if (!response.message.contains("removed")) {
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.symmetric(horizontal: 20),
        message: "Added to favourite list successfully.".tr,
        backgroundColor: Color(0xFF33A36D),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
      ));
    } else {
      Get.showSnackbar(GetSnackBar(
        margin: EdgeInsets.symmetric(horizontal: 20),
        message: "Successfully removed from favorites list.".tr,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        isDismissible: true,
        duration: Duration(seconds: 2),
      ));
      // Get.snackbar(
      //   "",
      //   backgroundColor: Color(0xFF33A36D),
      //   colorText: Colors.white,
      // );
    }
    onInit();
  }

  favourite2(String serviceId) async {
    print("favourite2");
    // ignore: unused_local_variable

    // ErrorResponse response = await api.favABill(serviceId);
    // print("SubmenuController response.message.toString()");
    // print(response.message.toString());

    // print("MESSAGE: $response.message" + " SubmenuController");

    // if (!response.message.contains("removed")) {
    //   Get.showSnackbar(GetSnackBar(
    //     margin: EdgeInsets.symmetric(horizontal: 20),
    //     message: "Added to favourite list successfully.".tr,
    //     backgroundColor: Color(0xFF33A36D),
    //     snackPosition: SnackPosition.TOP,
    //     duration: Duration(seconds: 2),
    //   ));
    // } else {
    //   Get.showSnackbar(GetSnackBar(
    //     margin: EdgeInsets.symmetric(horizontal: 20),
    //     message: "Successfully removed from favorites list.".tr,
    //     backgroundColor: Colors.red,
    //     snackPosition: SnackPosition.TOP,
    //     isDismissible: true,
    //     duration: Duration(seconds: 2),
    //   ));
    //   // Get.snackbar(
    //   //   "",
    //   //   backgroundColor: Color(0xFF33A36D),
    //   //   colorText: Colors.white,
    //   // );
    // }
    // onInit();
  }

  detail(String serviceId) async {
    print("yessss");
    print(serviceId);
  }

  void applyFilter(String filter) async {
    if (filter.isEmpty) {
      products.value = data.matrix!.products;
    } else {
      products.value = products
          .where((element) =>
              element.name.toLowerCase().contains(filter.toLowerCase()))
          .toList();
    }
  }

  void filterCheckboxProducts(List<int>? checkboxIds) async {
    if (checkboxIds == null) {
      products.value = data.matrix!.products;
    } else {
      // If the checkbox is ticked, filter products based on checkboxId
      products.value = products.where((element) {
        return element.chains.any((chain) => checkboxIds.contains(chain.id));
      }).toList();
    }
  }
}







// setupMatrix1(String serviceRefNum) async {
//     ErrorResponse response = await api.getServiceDetail(serviceRefNum);
//     if (response.data == null) return;
//     ServiceModel data = ServiceModel.fromJson(response.data);
//     if (data.billType != null) log("Bill type: ${data.billType!.type}");

//     name.value = data.name;

//     for (var first in data.matrix!) {
//       if (first.matrix[0].length > 2) {
//         // print("---------Tiket---------");
//         List<String> items = List<String>.from(first.matrix[0]);
//         List<List<dynamic>> getProducts = first.matrix.sublist(1);
//         for (var i = 0; i < getProducts.length; i++) {
//           ProductDetail product = ProductDetail(
//             isTicket: true,
//             title: "",
//             unit: "",
//             items: items.sublist(1),
//           );

//           // Get title
//           MatrixMatrixClass titleUnit =
//               MatrixMatrixClass.fromJson(getProducts[i][0]);

//           // Get price
//           List<String> raw = List<String>.from(getProducts[i].sublist(1));
//           List<num> prices = raw.map(num.parse).toList();
//           product.title = titleUnit.title;
//           product.unit = titleUnit.unit;
//           product.prices = prices;
//           product.actualValue =
//               List.generate(items.sublist(1).length, (index) => RxInt(0));
//           products.add(product);
//         }
//       } else {
//         // print("---------Item---------");
//         List<String> items = [];
//         List<String> units = [];
//         List<num> prices = [];
//         List<RxInt> actualValues = [];
//         List<List<dynamic>> getProducts = first.matrix.sublist(1);
//         // print(getProducts);

//         for (var i = 0; i < getProducts.length; i++) {
//           // GET PRICE AND TITLE
//           MatrixMatrixClass titleUnit =
//               MatrixMatrixClass.fromJson(getProducts[i][0]);

//           num price;
//           try {
//             price = num.parse(getProducts[i][1]);
//           } catch (e) {
//             price = getProducts[i][1];
//           }
//           items.add(titleUnit.title);
//           units.add(titleUnit.unit);
//           prices.add(price);
//           actualValues.add(RxInt(0));
//         }
//         products.add(
//           ProductDetail(
//             title: first.name,
//             isTicket: false,
//             items: items,
//             units: units,
//             prices: prices,
//             actualValue: actualValues,
//           ),
//         );
//       }
//     }
//   }