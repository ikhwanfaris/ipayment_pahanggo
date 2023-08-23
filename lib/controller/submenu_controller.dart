import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/models/shared/translatable.dart';
import 'package:get/get.dart';

class SubmenuController extends GetxController {
  RxString title = "".obs;
  RxList<Menu> submenus = <Menu>[].obs;
  RxList<Services> services = <Services>[].obs;
  RxBool isLoading = false.obs;
  late Menu menu;

  @override
  void onInit() async {
    menu = Get.arguments as Menu;
    print("Menu ID: ${menu.id}" + " name: SubmenuController");
    print("Menu ID: ${jsonEncode(menu)}" + " name:  SubmenuController");
    await setup();
    super.onInit();
  }

  Future<void> setup() async {
    if (menu.translatables.isNotEmpty) {
      String currentLocale = Get.locale?.languageCode ?? "en";

      for (Translatables element in menu.translatables) {
        if (element.language == currentLocale) {
          title.value = element.content ?? "";
        }
      }
    }
    if (title.value == "") {
      title.value = menu.name!;
    }
    isLoading(true);
    submenus.value = await api.getSubmenu(menu.id!);
    ErrorResponse response = await api.getServicesForMenu(menu.id!);
    if (response.data != null) {
      var data = response.data as List<dynamic>;
      services.value = data.map((e) => Services.fromJson(e)).toList();
    }
    isLoading(false);
  }

  favourite(String serviceId) async {
    log("Service ID: $serviceId", name: "SubmenuController");
    // ignore: unused_local_variable

    ErrorResponse response = await api.favoriteService(serviceId);
    log("MESSAGE: $response.message", name: "SubmenuController");

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
  }
}
