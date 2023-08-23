import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:get/get.dart';

import '../utils/helpers.dart';

class ServiceDetailController extends GetxController {
  Services? service;
  RxString codeAgency = "".obs;
  RxString codeService = "".obs;
  RxString nameService = "".obs;
  RxString typeService = "".obs;
  RxString refNoService = "".obs;

  String serviceRefNum = "";

  @override
  void onInit() async {
    print("hereee");
    SchedulerBinding.instance
        .addPostFrameCallback((_) => showLoadingBar(Get.context!));
    String serviceRefNum = Get.arguments;
    var response = await api.getServiceDetail(serviceRefNum);
    if (response.data == null) return;
    log(jsonEncode(response.data));
    print(response.isSuccessful);
    if (response.isSuccessful) {
      print(response.data.toString());
      service = Services.fromJson(response.data);
      codeAgency.value = service!.agency.code!;
      codeService.value = service!.serviceReferenceNumber!;
      nameService.value = service!.name!;
      typeService.value = service!.menu!.name!;
      refNoService.value = service!.serviceReferenceNumber!;
    }
    Navigator.pop(Get.context!);
    super.onInit();
  }
}
