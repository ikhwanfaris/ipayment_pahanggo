import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/models/cart/cart.dart';
import 'package:get/get.dart';

class CartController extends GetxController
{

  RxBool isLoading = true.obs;
  List<CartChargedTo> chargedTos = [];
  late BottomBarController bottomBarController;

  loadCart() async {
    isLoading.value = true;
    var rawData = await api.getCarts();
    chargedTos.clear();
    for(var item in rawData.data) {
      chargedTos.add(CartChargedTo.fromJson(this, item, bottomBarController));
    }
    isLoading.value = false;
  }

  void setBottomBarController(BottomBarController bottomBarController) {
    this.bottomBarController = bottomBarController;
  }

}