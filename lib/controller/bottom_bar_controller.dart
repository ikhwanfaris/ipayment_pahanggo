import 'package:flutterbase/api/barrel/api_cart.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/cart/cart.dart';
import 'package:flutterbase/screens/checkout/checkout.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

class BottomBarItem {
  int? cartId;
  int? billId;
  int? serviceId;
  Map<String, dynamic> details = {};
  double amount = 0;
  final String chargedTo;

  BottomBarItem(this.chargedTo);

  Map<String, dynamic> toJson() {
    if(billId != null) {
      return {
        'bill_id': billId,
        'amount': amount,
        'details': details,
      };
    }
    return {
      'service_id': serviceId,
      'amount': amount,
      'details': details,
    };
  }
}

class BottomBarController extends GetxController
{
  final Function(bool checked)? onAllChecked;

  RxBool alwaysShown = false.obs;
  double get total => items.fold<double>(0, (sum, next) => sum + next.amount);
  int get length => items.length;
  int? updatingCartId;
  RxList<BottomBarItem> items = RxList();
  RxBool hasCheckbox = RxBool(false);
  RxBool allChecked = RxBool(false);
  bool hideCartButton = false;
  Function(bool status)? onChange;
  String? Function()? validator;
  CartCustomerDetails customer = CartCustomerDetails();
  String get currentChargedTo => items.length > 0 ? items.first.chargedTo : '';

  BottomBarController(bool hasCheckbox, { this.onAllChecked, this.onChange, this.hideCartButton = false }) {
    this.hasCheckbox.value = hasCheckbox;
  }

  String? add(String chargedTo, double amount, {int? billId, int? cartId, int? serviceId, Map<String, dynamic> items = const {}}) {
    if(currentChargedTo != '' && chargedTo != currentChargedTo) return "Cannot checkout items with different charge bearers.".tr;
    var item = BottomBarItem(chargedTo);
    var found = false;
    for(var item in this.items) {
      if(
        (cartId != null && item.cartId == cartId) ||
        (billId != null && item.billId == billId) ||
        (serviceId != null && item.serviceId == serviceId)
      ) {
        found = true;
      }
    }

    if(!found) {
      item.cartId = cartId;
      item.billId = billId;
      item.serviceId = serviceId;
      item.details = items;
      item.amount = amount;
      var _items = this.items.toList();
      _items.add(item);
      this.items.value = _items;
    }

    return null;
  }

  remove({int? billId, int? serviceId, int? cartId}) {
    var _items = this.items.toList();
    _items.removeWhere((element) => (
      billId != null ?
        element.billId == billId :
        serviceId != null ?
          element.serviceId == serviceId :
            element.cartId == cartId
    ));
    items.value = _items;
  }

  change(double amount, {int? billId, int? serviceId, int? cartId, Map<String, dynamic>? newItems}) {
    var _items = items.toList();
    var item = _items.firstWhereOrNull((element) =>
      billId != null ?
        element.billId == billId :
        serviceId != null ?
          element.serviceId == serviceId :
            element.cartId == cartId
    );
    if(item != null) {
      if(newItems != null) {
        item.details = newItems;
      }
      item.amount = amount;
      items.value = _items;
    }
  }

  setUpdatingCartId(int cartId) {
    updatingCartId = cartId;
  }

  setCustomer(CartCustomerDetails customer) {
    this.customer = customer;
  }

  Future<List<int>> addToCart({ bool onlyAdd = true }) async {
    if(validator != null) {
      String? validatorResponse = validator!();
      if(validatorResponse != null) {
        toast(validatorResponse, level: SnackLevel.Error);
        return [];
      }
    }
    if(updatingCartId != null) {
      return await doUpdateCart(onlyAdd);
    }
    return await doAddToCart(onlyAdd);
  }

  Future<List<int>> doAddToCart(bool onlyAdd) async {
    var entry = CartAddRequest(
      customer,
      items
        .map<Map<String, dynamic>>((element) => element.toJson())
        .toList()
    );

    Map<String, dynamic>? response = await ApiCart().add(entry);

    if(response != null && response['data']?['cart_ids'] == null) {
      toast(response['message'], level: SnackLevel.Error);
      return [];
    }

    List<int> cartIds = [];

    for(var item in response!['data']['cart_ids']) {
      cartIds.add(int.parse(item.toString()));
    }

    if(onlyAdd)
      toast("Added to cart successfully.".tr, level: SnackLevel.Success);

    if(cartIds.length > 1) {
      clear();
    } else if (!onlyAdd) {
      updatingCartId = cartIds.first;
    }

    return cartIds;
  }

  Future<List<int>> doUpdateCart(bool onlyAdd) async {

    var cartEntry = CartEntry(this);
    cartEntry.id = updatingCartId!;
    cartEntry.serviceId = items.first.serviceId!;

    for(var item in items.first.details['items']) {
      var entryItem = CartEntryItem.fromJson(item, cartEntry);
      entryItem.perUnit.value = item['ppu'];
      entryItem.quantity.value = item['quantity'];
      cartEntry.items.add(entryItem);
    }

    for(var item in items.first.details['extra_fields']) {
      cartEntry.extraFields.add(CartEntryExtraField.fromJson(item, cartEntry));
    }
    var request = CartUpdateRequest(cartEntry);

    await request.send();

    if(onlyAdd)
      toast("Cart updated successfully.".tr, level: SnackLevel.Success);

    return [updatingCartId!];
  }

  clear() {
    items.value = [];
    customer = CartCustomerDetails();
    allChecked.value = false;
  }

  Future checkout() async {
    var ids = await addToCart(onlyAdd: false);
    RxList<BottomBarItem> checkoutItems = <BottomBarItem>[].obs;
    print(ids);
    for(var id in ids) {
      var item = BottomBarItem('');
      item.cartId = id;
      checkoutItems.add(item);
    }
    Get.to(() => Checkout(checkoutItems));
  }

  void setValidator(String? Function()? validator) {
    this.validator = validator;
  }
}

class BottomBarCartController extends BottomBarController
{
  BottomBarCartController(hasCheckbox, { super.onAllChecked, super.onChange, super.hideCartButton = true }) : super(hasCheckbox);

  Future checkout() async {
    Get.to(() => Checkout(items));
  }
}