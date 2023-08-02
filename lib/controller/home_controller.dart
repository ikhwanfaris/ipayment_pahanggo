import 'dart:convert';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/bulletin/bulletin.dart';
import 'package:flutterbase/models/contents/favorite.dart';
import 'package:flutterbase/models/contents/menu.dart';
import 'package:flutterbase/models/shared/translatable.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final CarouselController carousel = CarouselController();
  final RxInt currentSlide = 0.obs;
  final RxBool isInitialized = false.obs;
  RxList<Favorite> favoriteServices = <Favorite>[].obs;
  RxList<Menu> menuList = RxList<Menu>();
  RxList<Bulletin> bulletinList = RxList<Bulletin>();
  RxList<Bulletin> hebahanList = RxList<Bulletin>();

  @override
  void onInit() async {
    setupBulletin();
    setupMenu();
    setupFavorite();
    setupHebahan();
    super.onInit();

    isInitialized(true);
  }

  setupBulletin() async {
    var response = await api.getBulletin(isBulletin: true);
    bulletinList.value =
        (response.data as List).map((e) => Bulletin.fromJson(e)).toList();
    log(jsonEncode(bulletinList));
  }

  setupHebahan() async {
    var response = await api.getBulletin(isBulletin: false);
    hebahanList.value =
        (response.data as List).map((e) => Bulletin.fromJson(e)).toList();
    log(jsonEncode(bulletinList));
  }

  setupMenu() async {
    menuList.value = await api.setupContents();
  }

  String? handleTranslation(Menu menu) {
    String currentLocale = Get.locale?.languageCode ?? "en";

    for (Translatables element in menu.translatables ?? []) {
      if (element.language == currentLocale) {
        return element.content ?? menu.name;
      }
    }
    return menu.name;
  }

  String handleHebahanTranslation(Bulletin bulletin) {
    String currentLocale = Get.locale?.languageCode ?? "en";

    for (Translatables element in bulletin.translatables ?? []) {
      if (element.language == currentLocale) {
        return element.content ?? "";
      }
    }
    return "menu.name";
  }

  setupFavorite() async {
    ErrorResponse response = await api.getFavoriteService();
    if (response.data != null) {
      List<dynamic> raw = response.data as List<dynamic>;
      favoriteServices.value = raw.map((e) => Favorite.fromJson(e)).toList();
      favoriteServices.forEach((element) => log(element.service!.name));
      print("favoriteServices.length.toString() " +
          favoriteServices.length.toString());
    }
  }
}
