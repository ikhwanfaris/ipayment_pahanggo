import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/favorite.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController
{
  List<Favorite> _favorites = <Favorite>[];
  RxList<Favorite> favorites = <Favorite>[].obs;
  RxBool isLoading = true.obs;
  String searchText = '';

  Future fetch(String type) async {
    isLoading.value = true;
    _favorites.clear();
    ErrorResponse? items;

    switch(type) {
      case 'services':
        items = await api.getFavoriteService();
        break;
      case 'bills':
        items = await api.getFavoriteBills();
        break;
    }

    if(items!.isSuccessful) {
      for(var item in items.data) {
        _favorites.add(Favorite.fromJson(item));
      }
    }
    filter('');
    isLoading.value = false;
  }

  Future removeFavorite({ int? billId, int? serviceId, BuildContext? context}) async {
    _favorites.removeWhere((element) => billId != null ? element.billId == billId : element.serviceId == serviceId);
    if(billId != null) {
      favoriteCount.setValues(await api.removeFavorite(billId: billId));

    }
    if(serviceId != null) {
      favoriteCount.setValues(await api.removeFavorite(serviceId: serviceId));
    }
    snack(context ?? getContext(), "Successfully removed from favorites list.".tr, level: SnackLevel.Success);
  }

  Future addFavorite({int? billId, int? serviceId, BuildContext? context}) async {
    var item = Favorite.fromJson(await api.addFavorite(serviceId: serviceId, billId: billId));
    _favorites.add(item);
    await favoriteCount.fetch();
    snack(context ?? getContext(), "Successfully added to favorites list.".tr, level: SnackLevel.Success);
  }

  void filter(String value) {
    searchText = value;
    favorites.value = [];
    for(var item in _favorites) {
      if(value == '') {
        favorites.add(item);
      } else {
        if(item.bill != null && item.bill!.contains(value)) {
          favorites.add(item);
        }
        if(item.service != null && item.service!.contains(value)) {
          favorites.add(item);
        }
      }
    }
  }
}

class FavoriteCountController extends GetxController
{
  RxInt services = 0.obs;
  RxInt bills = 0.obs;

  FavoriteCountController() {
    fetch();
  }

  fetch() async {
    setValues(await api.getFavoriteCount());
  }

  setValues(Map<String, dynamic> values) {
    services.value = int.tryParse(values['services'].toString()) ?? 0;
    bills.value = int.tryParse(values['bills'].toString()) ?? 0;
  }
}

final FavoriteController favorites = FavoriteController();
final FavoriteCountController favoriteCount = FavoriteCountController();