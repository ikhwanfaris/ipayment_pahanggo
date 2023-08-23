import 'package:flutterbase/api/barrel/api_cart.dart';
import 'package:get/get.dart';

class CartCounterController extends GetxController {
  RxInt count = 0.obs;

  refreshCount() async {
    var count = await ApiCart().getCount();
    this.count.value = count;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  String toString() {
    return count.value.toString();
  }
}

CartCounterController cartCount = CartCounterController();