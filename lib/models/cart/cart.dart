import 'dart:convert';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/controller/bottom_bar_controller.dart';
import 'package:flutterbase/controller/cart_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

class CartChargedTo {
  late CartController controller;
  late String chargedTo;
  List<CartAgency> agencies = [];
  RxBool isSelected = false.obs;
  BottomBarController bottomBarController;
  double get total => agencies.fold<double>(0, (last, i) => last + i.total);

  CartChargedTo.fromJson(this.controller, json, this.bottomBarController) {
    chargedTo = json['charged_to'];

    agencies.clear();
    for(var item in json['agencies']) {
      agencies.add(CartAgency.fromJson(this, item, bottomBarController));
    }
  }

  setChecked(bool v) {
    isSelected.value = v;
    for(var agency in agencies) {
      agency.setChecked(v);
    }
  }

  Future removeAll() async {
    controller.isLoading.value = true;
    for(var agency in agencies) {
      for(var entry in agency.entries) {
        if(entry.isSelected.value) {
          bottomBarController.remove(cartId: entry.id);
        }
        ApiCart().delete(entry.id);
      }
    }
    agencies.clear();
    controller.chargedTos.remove(this);
    controller.isLoading.value = false;
    toast('Succesfully removed.'.tr, level: SnackLevel.Success);
  }
}

class CartAgency {
  late String agency;
  late String department;
  late String ministry;
  late CartChargedTo chargedTo;
  RxList<CartEntry> entries = <CartEntry>[].obs;
  RxBool isSelected = false.obs;
  BottomBarController bottomBarController;
  double get total => entries.fold<double>(0, (last, i) => last + i.total);

  void setChecked(v) {
    isSelected.value = v;

    for(var item in entries) {
      item.setChecked(v);
    }
  }

  CartAgency.fromJson(this.chargedTo, json, this.bottomBarController) {
    agency = json['agency'];
    department = json['department'];
    ministry = json['ministry'];

    entries.clear();
    for(var item in json['cart_items']) {
      var entry = CartEntry.fromJson(chargedTo.chargedTo, item, bottomBarController);
      if(entry.items.isNotEmpty)
        entries.add(entry);
    }
  }

  void remove(CartEntry cartEntry, {bool notify = true}) async {
    if(cartEntry.isSelected.value) {
      bottomBarController.remove(cartId: cartEntry.id);
    }

    entries.remove(cartEntry);
    if(entries.isEmpty) {
      chargedTo.agencies.remove(this);
    }
    if(chargedTo.agencies.isEmpty) {
      chargedTo.controller.chargedTos.remove(chargedTo);
    }

    if(notify) {
      toast('Succesfully removed.'.tr, level: SnackLevel.Success);
    }

    await ApiCart().delete(cartEntry.id);
  }
}

class CartEntry {
  late int id;
  int billTypeId = 0;
  late int? billId;
  late int serviceId;
  late String serviceCode;
  late String serviceName;
  late String chargedTo;
  RxString customerName = RxString('');
  RxString customerEmail = RxString('');
  RxString customerPhone = RxString('');
  double get total => items.fold<double>(0, (last, i) => last + i.amount);
  RxBool isSelected = false.obs;
  List<CartEntryItem> items = [];
  List<CartEntryExtraField> extraFields = [];
  BottomBarController bottomBarController;
  bool canPay = false;

  CartEntry(this.bottomBarController);

  String get customerDetails {
    List<String> items = [];
    if(customerName.isNotEmpty) {
      items.add(customerName.value);
    }
    if(customerEmail.isNotEmpty) {
      items.add(customerEmail.value);
    }
    if(customerPhone.isNotEmpty) {
      items.add(customerPhone.value);
    }
    return items.join(' | ');
  }

  String get extraFieldsSummary {
    List<String> items = [];
    for(var item in extraFields) {
      if(item.value.isNotEmpty) {
        items.add(item.source + ': ' + item.value.value);
      }
    }
    return items.join(' | ');
  }

  void setChecked(v) {

    if(v) {
      print(canPay);
      if(!canPay) {
        return;
      }
      var response = bottomBarController.add(chargedTo, total, cartId: id);
      if(response != null) {
        toast(response, level: SnackLevel.Warning);
        return;
      }
    } else {
      bottomBarController.remove(cartId: id);
    }

    isSelected.value = v;
  }

  CartEntry.fromJson(this.chargedTo, json, this.bottomBarController) {
    id = json['cart_id'];
    billTypeId = json['bill_type_id'];
    billId = json['bill_id'];
    serviceId = json['service_id'];
    serviceCode = json['service_code'];
    serviceName = json['service_name'];
    customerName.value = json['customer_name'] ?? '';
    customerEmail.value = json['customer_email'] ?? '';
    customerPhone.value = json['customer_phone'] ?? '';
    canPay = json['can_pay'];

    items.clear();
    for(var item in json['items']) {
      items.add(CartEntryItem.fromJson(item, this));
    }

    extraFields.clear();
    for(var item in json['extra_fields']) {
      extraFields.add(CartEntryExtraField.fromJson(item, this));
    }
  }

  Map<String, dynamic> getItemForCartUpdate() {
    if(billTypeId == 3 || items.isNotEmpty || extraFields.isNotEmpty) {
      List<Map<String, dynamic>> _extraFields = [];
      for(var item in extraFields) {
        var _value = item.value.value;
        if(item.type == 'date') {
          _value = _value.split('/').reversed.join('-');
        }
        _extraFields.add({
          "source": item.source,
          "type": item.type,
          "placeholder": item.placeholder,
          "value": _value,
        });
      }
      return {
        "service_id": serviceId,
        "amount": total,
        "details": {
          "items": [
            for(var item in items)
              {
                "id": item.id,
                "quantity": item.quantity.value,
                "ppu": item.perUnit.value,
                "unit": item.unit,
                "amount": item.amount
              },
          ],
          "extra_fields": _extraFields
        }
      };
    }

    return {
      "bill_id": billId,
      "amount": total,
      "details": {}
    };
  }

  void sendUpdateCart() {
    CartUpdateRequest(this).send();
  }

  void setValue(double v) {
    items[0].perUnit.value = v;
    sendUpdateCart();

    if(isSelected.value) {
      if(total > 0) {
        bottomBarController.change(total, cartId: id);
      }
    }
  }

  setCustomerDetails(String type, String v) {
    switch(type) {
      case 'name':
        customerName.value = v;
        break;
      case 'email':
        customerEmail.value = v;
        break;
      case 'phone':
        customerPhone.value = v;
        break;
    }

    sendUpdateCart();
  }
}

class CartEntryItemExtraInfo {
  String? billNumber;
  String? referenceNumber;
  DateTime? billDate;

  CartEntryItemExtraInfo();

  CartEntryItemExtraInfo.fromJson(json) {
    billNumber = json['bill_number'];
    referenceNumber = json['reference_number'];
    if(json['bill_date'] != null) {
      billDate = DateTime.tryParse(json['bill_date']);
    }
  }

  String toString() {
    List<String> parts = [];
    if(referenceNumber != null)
      parts.add(referenceNumber!);
    if(billNumber != null)
      parts.add(billNumber!);
    if(billDate != null)
      parts.add(dateFormatterDisplay.format(billDate!));
    return parts.join(' | ');
  }
}

class CartEntryItem {
  late int id;
  List<Chain> chain = [];
  String category = '';
  late String? description;
  RxInt quantity = RxInt(0);
  RxDouble perUnit = RxDouble(0);
  double get amount => quantity.value * perUnit.value;
  late String unit;
  late bool checkQuota;
  late int quotaGroup;
  late String status;
  late bool isFavourite;
  final CartEntry cartEntry;
  CartEntryItemExtraInfo extraInfo = CartEntryItemExtraInfo();

  CartEntryItem(this.cartEntry, int quantity, double perUnit) {
    this.quantity.value = quantity;
    this.perUnit.value = perUnit;
  }

  CartEntryItem.fromJson(json, this.cartEntry) {
    id = json['id'];
    description = json['name'] ?? json['description'] ?? '-';
    quantity.value = json['quantity'];
    perUnit.value = double.tryParse(json['per_unit'].toString()) ?? 0;
    unit = json['unit'] ?? 'Unit';
    checkQuota = json['check_quota'] ?? false;
    quotaGroup = int.tryParse(json['quota_group'].toString()) ?? 0;
    status = (json['status'] ?? 'Aktif').toString();
    isFavourite = json['is_favourite'] ?? false;

    chain.clear();
    for(var item in (json['chain'] ?? [])) {
      chain.add(Chain.fromJson(item));
    }

    category = chain.map<String>((e) => e.name).join(' > ');

    if(jsonEncode(json['extra_info']) != '[]') {
      extraInfo = CartEntryItemExtraInfo.fromJson(json['extra_info']);
    }
  }

  increment() {
    quantity.value = quantity.value + 1;
    if(cartEntry.isSelected.value) {
      cartEntry.bottomBarController.change(cartEntry.total, cartId: cartEntry.id);
    }
    cartEntry.sendUpdateCart();
  }

  decrement() {
    if(quantity.value > 0) {
      quantity.value = quantity.value - 1;
      if(cartEntry.isSelected.value) {
        cartEntry.bottomBarController.change(cartEntry.total, cartId: cartEntry.id);
      }
      cartEntry.sendUpdateCart();
    }

    if(cartEntry.total == 0) {
      cartEntry.isSelected.value = false;
      cartEntry.bottomBarController.remove(cartId: cartEntry.id);
    }
  }

  void setQuantity(int v) {
    quantity.value = v;
    if(cartEntry.isSelected.value) {
      cartEntry.bottomBarController.change(cartEntry.total, cartId: cartEntry.id);
    }
    cartEntry.sendUpdateCart();
  }
}

class CartEntryExtraField {
  late String source;
  late String placeholder;
  late String type;
  late CartEntry cartEntry;
  RxString value = RxString('');

  CartEntryExtraField.fromJson(json, this.cartEntry) {
    print(json);
    source = json['source'] ?? 'test';
    placeholder = json['placeholder'] ?? 'sila isi';
    type = json['type'] ?? 'text';
    if(type == 'date') {
      var _value = json['value'].toString();
      if(_value.contains('-')) {
        _value = _value.split('-').reversed.join('/');
      }
      value.value = _value;
    } else {
      value.value = json['value'].toString();
    }
  }

  void setValue(String v) {
    value.value = v;
    cartEntry.sendUpdateCart();
  }
}

class CartUpdateRequest {
  final CartEntry entry;

  CartUpdateRequest(this.entry);

  Map<String, dynamic> toJson () {
    Map<String, dynamic> params = {
      'customer_name': entry.customerName.value,
      'customer_phone': entry.customerPhone.value,
      'customer_email': entry.customerEmail.value,
      'amount': entry.total,
      'item': entry.getItemForCartUpdate(),
    };
    return params;
  }

  Future<bool> send() async {
    var result = await ApiCart().update(entry.id, body: toJson());
    return result;
  }
}

class CartCustomerDetails {
  String name;
  String email;
  String phone;

  CartCustomerDetails({
    this.name = '',
    this.email = '',
    this.phone = '',
  });
}

class CartAddRequest {
  final CartCustomerDetails customer;
  final List<Map<String, dynamic>> items;

  CartAddRequest(this.customer, this.items);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'items': items,
    };

    if(customer.name.isNotEmpty) {
      data['customer_name'] = customer.name;
    }
    if(customer.email.isNotEmpty) {
      data['customer_email'] = customer.email;
    }
    if(customer.phone.isNotEmpty) {
      data['customer_phone'] = customer.phone;
    }

    return data;
  }
}
