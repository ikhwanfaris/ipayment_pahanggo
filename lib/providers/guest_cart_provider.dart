import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/models.dart';
import 'package:localstorage/localstorage.dart';
import 'package:flutterbase/utils/helpers.dart' as Helpers;

const kStoreKeyCartItems = 'cart_items';

class GuestCartProvider extends ChangeNotifier {
  GuestCartProvider() {
    _cartItems = [];

    ready();
  }

  bool _ready = false;

  late List<CartItem> _cartItems;

  LocalStorage get storage => Helpers.store;

  List<CartItem> all() {
    return _cartItems;
  }

  Future<void> clear() async {
    _cartItems = [];

    await _save();

    notifyListeners();
  }

  int count() {
    return _cartItems.length;
  }

  double total() {
    double result = 0;

    for (var i = 0; i < _cartItems.length; i++) {
      result += _cartItems[i].amount;
    }

    return result;
  }

  Future<void> update(CartItem cartItem) async {
    var newList =
        _cartItems.where((element) => element.id != cartItem.id).toList();

    newList.add(cartItem);

    _cartItems = newList;

    await _save();

    notifyListeners();
  }

  Future<void> add(CartItem cartItem) async {
    _cartItems.add(cartItem);

    await _save();

    notifyListeners();
  }

  Future<void> delete(CartItem cartItem) async {
    var newList =
        _cartItems.where((element) => element.id != cartItem.id).toList();

    _cartItems = newList;

    await _save();

    notifyListeners();
  }

  Future<void> ready() async {
    if (_ready) return;

    await _pull();

    _ready = true;

    notifyListeners();
  }

  Future<void> _save() async {
    await storage.setItem(kStoreKeyCartItems, _cartItems);
    xlog('_save');
  }

  Future<void> _pull() async {
    try {
      String prevSaved = storage.getItem(kStoreKeyCartItems);
      // String prevSaved =
      // r'''[{"id":268,"user_id":16,"service_id":2,"bill_id":null,"details":null,"amount":"19.00","status":"Active","created_at":"2023-02-17T00:57:26.000000Z","updated_at":"2023-02-17T00:57:26.000000Z","guest_user_id":null,"service":{"id":2,"agency_id":1,"ministry_id":26,"name":"Institut Perakaunan Negara (IPN) - Kuarters","menu_id":4,"service_reference_number":"S00141","bill_type_id":2,"service_group_id":null,"agency_system_id":null,"system_supporting_document_path":null,"system_approval_letter_date":null,"system_approval_letter_ref":null,"system_description":null,"system_logo":null,"system_name":null,"product_label_display":null,"extra_fields":[],"file_extensions":"[]","max_file_size":null,"ref_no_label":"Bil","allow_cby":1,"cby_chargelines":"[]","receipt_type":"Biasa - N","allow_partial_payment":0,"is_sensitive":0,"is_send_igfmas":0,"is_invoice_iGFMAS":0,"allow_third_party_payment":"0","third_party_search_types":"[]","service_mode":null,"integration_data":"[]","service_charge_data":"[]","tax_data":"[]","discount_data":"[]","chargeline_data":"[{\"id\":14,\"code\":\"025001 23202\",\"description\":\"UTILITI AIR\",\"year\":\"2022\",\"ministry_id\":26,\"department_id\":1,\"agency_id\":1,\"preparer_ptj_id\":983,\"charged_ptj_id\":983,\"is_fund\":0,\"fund_vote_id\":387,\"program_activity_id\":315,\"project_id\":null,\"account_code_id\":5196,\"is_send\":null,\"created_at\":\"2022-10-19T00:12:45.000000Z\",\"updated_at\":\"2022-10-19T00:12:45.000000Z\",\"classification_code_id\":14}]","collection_channels":null,"preparer_locations":[],"usage_mode":"Collection Channel","collection_type":"Hasil","charged_to":"Pelanggan","status":"Disahkan","creator_id":8,"has_modified":1,"submitted_at":"2023-01-13 22:39:57","approval_agency_at":"19/02/2023 03:04:22","approval_agency_by":null,"approval_agency_remarks":null,"approval_ba_remarks":null,"approval_ba_at":"19/02/2023 03:04:22","approval_ba_by":null,"janm_checker":2,"approval_janm_fungsian_at":"19/02/2023 03:04:22","approval_janm_fungsian_remarks":null,"approval_janm_fungsian_by":null,"approval_janm_teknikal_at":"19/02/2023 03:04:22","approval_janm_teknikal_remarks":null,"approval_janm_teknikal_by":null,"operation_management":null,"approval_collection_information":0,"is_active":1,"created_at":"2022-10-10T09:07:39.000000Z","updated_at":"2023-02-16T06:40:11.000000Z","service_category":"Air","agency":{"id":1,"name":"INSTITUT PERAKAUNAN NEGARA (IPN)","code":"260101","profile":"Excellent accounting at your service","address":"Putrajaya"},"bill_type":{"id":2,"type":"Bil Tanpa Amaun"},"menu":{"id":4,"name":"Air"},"favourite":0,"with_matrix":false},"bill":null}]''';
      List<CartItem> newList = [];
      List<dynamic> list = json.decode(prevSaved);

      for (var i = 0; i < list.length; i++) {
        newList.add(
          CartItem.fromJson(list[i] as Map<String, dynamic>),
        );
      }

      _cartItems = newList;
    } catch (e) {
      xlog(e.toString());
    }
  }
}
