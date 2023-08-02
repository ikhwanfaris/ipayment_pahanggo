import 'package:get/get.dart';

class CartItem {
  int? billId;
  int? serviceId;
  List<Map<String, dynamic>> items = [];
  double amount = 0;
}

class BottomBarController extends GetxController
{
  double get total => items.fold<double>(0, (sum, next) => sum + next.amount);
  int get length => items.length;
  RxList<CartItem> items = RxList();
  RxBool hasCheckbox = RxBool(false);
  RxBool allChecked = RxBool(false);
  Function(bool status)? onChange;

  BottomBarController(bool hasCheckbox, { this.onChange }) {
    this.hasCheckbox.value = hasCheckbox;
  }

  add(double amount, {int? billId, int? serviceId, List<Map<String, dynamic>> items = const []}) {
    var item = CartItem();
    item.billId = billId;
    item.serviceId = serviceId;
    item.items = items;
    item.amount = amount;
    var _items = this.items.toList();
    _items.add(item);
    this.items.value = _items;
  }

  remove({int? billId, int? serviceId}) {
    var _items = this.items.toList();
    _items.removeWhere((element) => billId == null ? element.billId == billId : element.serviceId == serviceId);
    items.value = _items;
  }

  change(double amount, {int? billId, int? serviceId}) {
    var _items = items.toList();
    var item = _items.firstWhereOrNull((element) => billId == null ? element.billId == billId : element.serviceId == serviceId);
    if(item != null) {
      item.amount = amount;
      items.value = _items;
    }
  }

  payNow() {}

  addToCart() {}

  clear() {
    items.value = [];
  }

}