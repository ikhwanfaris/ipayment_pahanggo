import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:get/get.dart';

class ServiceController extends GetxController {
  var isLoading = false.obs;
  var subMenuTitle = "".obs;
  var services = <Services>[].obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading(true);
    Menu subMenu = Get.arguments;
    subMenuTitle.value = subMenu.name!;
    ErrorResponse response = await api.getServicesForMenu(subMenu.id!);
    if (response.data != null) {
      var data = response.data as List<dynamic>;
      services.value = data.map((e) => Services.fromJson(e)).toList();
      log(jsonEncode(services));
    } else {
      Get.defaultDialog(content: Text("Error fetch data!"));
    }
    isLoading(false);
  }

  favourite(String serviceId) async {
    print("Service ID: $serviceId");
    // ignore: unused_local_variable
    ErrorResponse response = await api.favoriteService(serviceId);
  }
}
