import 'dart:convert';
import 'dart:developer';

import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/bills/favorite.dart';
import 'package:get/get.dart';

// import 'home_controller.dart';

class FavoriteServiceController extends GetxController {
  RxList<Favorite> favoriteServices = <Favorite>[].obs;
  @override
  void onInit() {
    setupFavorite();
    super.onInit();
  }

  setupFavorite() async {
    ErrorResponse response = await api.getFavoriteService();
    if (response.data != null) {
      List<dynamic> raw = response.data as List<dynamic>;
      favoriteServices.value = raw
          .map((e) => Favorite.fromJson(e))
          .toList()
          .where((element) => element.service != null)
          .toList();
    }
    log(jsonEncode(favoriteServices));
  }

  favourite(String serviceId) async {
    print("Service ID: $serviceId");
    // ignore: unused_local_variable
    ErrorResponse response = await api.favoriteService(serviceId);
    await setupFavorite();
  }
}
