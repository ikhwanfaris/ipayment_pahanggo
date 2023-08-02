// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutterbase/models/about_us/about_us.dart';
import 'package:flutterbase/models/bills/bills.dart' as model;
import 'package:flutterbase/models/contents/bank.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/models/chat/message.dart';
import 'package:flutterbase/models/enquiry/file_setting_enquiry.dart';
import 'package:flutterbase/models/enquiry/list_enquiry.dart';
import 'package:flutterbase/models/models.dart';
import 'package:flutterbase/models/rating/faq.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/models/contents/add_cart_request.dart';
import 'package:flutterbase/models/payments/payments.dart';
import 'package:flutterbase/models/users/add_member.dart';
import 'package:flutterbase/models/users/auth_config.dart';
import 'package:flutterbase/models/users/character_count.dart';
import 'package:flutterbase/models/users/city.dart';
import 'package:flutterbase/models/contents/menu.dart';
import 'package:flutterbase/models/users/identity_type.dart';
import 'package:flutterbase/models/organizations/list_organization_member.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/models/organizations/organization_type.dart';
import 'package:flutterbase/models/users/list_add_member.dart';
import 'package:flutterbase/models/users/passport_history.dart';
import 'package:flutterbase/models/users/postcode_city.dart';
import 'package:flutterbase/models/users/postcode_state.dart';
import 'package:flutterbase/models/users/states.dart';
import 'package:flutterbase/models/users/country.dart';
import 'package:flutterbase/models/users/district.dart';
import 'package:flutterbase/models/users/tnc.dart';
import 'package:flutterbase/models/users/user.dart';
import 'package:flutterbase/models/users/user_manual.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_core/src/get_main.dart';
import '../models/enquiry/category_enquiry.dart';
import '../utils/helpers.dart';

part 'api_config.dart';

class ErrorResponse {
  bool isSuccessful;
  String message;
  int? statusCode;
  dynamic data;

  ErrorResponse(this.isSuccessful, this.message, this.statusCode, {this.data});
}

class Api {
  String endpoint = ENDPOINT;

  String token = '';
  String path = '';
  bool tncUpdated = false;
  // bool getCurrentRatedLS = false;
  String _token = '';

  final ApiInbox inbox;

  Api(
    this.inbox,
  );

  Dio client() {
    return Dio(
      BaseOptions(
        baseUrl: endpoint,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': _token != 'null' ? 'Bearer ' + token : '',
        },
      ),
    );
  }

  Dio client2() {
    return Dio(
      BaseOptions(
        baseUrl: endpoint,
        headers: {
          'Content-Type': 'multipart/form-data',
          'Accept': '/',
          'Authorization': token.isNotEmpty ? 'Bearer ' + token : '',
        },
      ),
    );
  }

  // When app refresh
  Future<ErrorResponse> resume() async {
    _token = store.getItem(kStoreUserToken).toString();
    // String _path = store.getItem('path').toString();

    // print(_path);
    print('ORIGNAL TOKEN: ' + token);
    print('KSTORE TOKEN: ' + _token);

    token = _token;

    if (_token != 'null') {
      // ;

      try {
        await getConfigTnc();
        await setupContents();
        await setupUser();
        await inbox.fetch();
      } on DioError catch (e) {
        print(e.message);
        print(e.response?.data);
        print(e.response?.statusCode);

        return ErrorResponse(
            false,
            e.response!.data['message']
                .toString()
                .replaceAll("{", "")
                .replaceAll("[", "")
                .replaceAll("]", "")
                .replaceAll("}", ""),
            e.response?.statusCode);
      } on Error catch (e) {
        print('Test 123');
        return ErrorResponse(false, e.stackTrace.toString(), 0);
      }
    }

    return ErrorResponse(false, 'Server Error', 0);
  }

  // Calling function on resume
  Future boot() async {
    await resume();
  }

  Future<ErrorResponse> setLanguage(String lang) async {
    FormData body = FormData.fromMap({"lang": lang});
    var response = await client().post(
      '/api/user/set-language',
      data: body,
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );
    print(response.data);

    if (response.data['message'] == 'Bahasa telah dikemas kini') {
      return ErrorResponse(true, response.data["message"], response.statusCode);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
      );
    }
  }

  Future<ErrorResponse> getBulletin({required bool isBulletin}) async {
    Map<String, String> query = {"display_mode[]": "Hebahan"};
    if (isBulletin) {
      query["display_mode[]"] = "Buletin";
    }
    var response = await client().get(
      '/api/bulletin',
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );
    print(response.data);

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  Future<ErrorResponse> getFavoriteService() async {
    var response = await client().get(
      '/api/services/favorites',
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  // Get authentication user for user & gov
  Future<List<AuthConfig>> getAuthConfig() async {
    List<AuthConfig> list = [];
    try {
      var response = await client().get('/api/config');
      // print(response.data['data']['authentication_settings']);

      if (response.data['data'] != null) {
        for (var item in response.data['data']['authentication_settings']) {
          list.add(AuthConfig.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  Future<ErrorResponse> getCarts() async {
    var response = await client().get(
      '/api/carts',
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  // Payment v1
  Future<ErrorResponse> payments(PaymentsRequest request) async {
    var response = await client().post(
      '/api/payments',
      data: FormData.fromMap(request.toJson()),
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    print(response.data);

    if (response.statusCode != 200)
      return ErrorResponse(
          false, response.statusMessage.toString(), response.statusCode);

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  Future<ErrorResponse> getDailyQuota(String productId, DateTime date) async {
    var response = await client().get(
      '/api/matrix/daily-quota-by-date/$productId',
      queryParameters: {"date": dateFormatter.format(date)},
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    if (response.statusCode != 200)
      return ErrorResponse(
          false, response.statusMessage.toString(), response.statusCode);

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  // Payment v2
  Future<ErrorResponse> paymentsv2(CartPayRequest request) async {
    Map<String, dynamic> queryParameters = {
      "source": request.source,
      "payment_method": request.paymentMethod,
    };

    for (var i = 0; i < request.ids.length; i++) {
      queryParameters.addEntries({"ids[$i]": request.ids[i]}.entries);
    }

    if (request.bankCode != null) {
      queryParameters["bank_code"] = request.bankCode!;
      queryParameters["redirect_url"] = request.redirectUrl!;
      queryParameters["bank_type"] = request.bankType!;
    }
    var response = await client().get(
      '/api/carts/pay',
      queryParameters: queryParameters,
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    print(queryParameters);
    print(response.realUri);
    print(response.data);

    if (response.statusCode != 200)
      return ErrorResponse(
          false, response.statusMessage.toString(), response.statusCode);

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  Future<ErrorResponse> getDuitNowStatus(String referenceNumber) async {
    var response = await client().get(
      '/api/payments/duitnow-qr/$referenceNumber/status',
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    if (response.statusCode != 200)
      return ErrorResponse(
          false, response.statusMessage.toString(), response.statusCode);

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  Future<ErrorResponse> getPaymentGateways() async {
    var response = await client().get(
      '/api/payments/gateways',
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );
    // print(response.data[0].message);

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  Future<ErrorResponse> roundingAdjustment(String amount) async {
    var response = await client().get(
      '/api/config/rounding',
      queryParameters: {"value": amount},
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  // Future<ErrorResponse> searchService(String query) async {
  //   var response = await client().get(
  //     '/api/services/predict',
  //     queryParameters: {"s": query},
  //     options: Options(
  //       validateStatus: (status) {
  //         return status! < 500;
  //       },
  //     ),
  //   );

  //   if (response.data['message'] == 'Successful') {
  //     return ErrorResponse(true, '', data: response.data["data"]);
  //   } else {
  //     return ErrorResponse(
  //       false,
  //       response.data["message"],
  //       data: response.data["data"],
  //     );
  //   }
  // }

  Future<ErrorResponse> searchService(String query) async {
    var response = await client().get(
      '/api/services/search',
      queryParameters: {
        "keyword": query,
        "from": "portal",
      },
      options: Options(
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"]["data"],
      );
    }
  }

  Future<ErrorResponse> favoriteService(String serviceId) async {
    var response = await client().post(
      '/api/services/$serviceId/favorite',
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    print(response.data);

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  Future<ErrorResponse> getBankList() async {
    var response = await client().get(
      '/api/payments/paynet-banks',
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  searchBill(String query, String serviceId) async {
    var response =
        await client().get('/api/services/search-bill', queryParameters: {
      "query": query,
      "from": "portal",
      "service_id": serviceId,
    });

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  Future<ErrorResponse> getBills(String? search,
      {required bool public, String? identityCode}) async {
    Map<String, dynamic> query = {};
    String url = "/api/bills";

    if (public) {
      url = "/api/public/bills";
      query["search"] = search;
      query["identity_code"] = identityCode;
    } else {
      query["search"] = search;
      query["identity_code"] = identityCode;
    }
    // if (search != null) {
    //   query["search"] = search;
    // }

    print('test search bill');

    log("Search Bill url: $url");
    log("Search Bill query: $query");
    var response = await client().get(
      url,
      queryParameters: query,
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );
    print(response.data);

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  Future<ErrorResponse> getServiceMatrix({required String serviceId}) async {
    var response = await client().get(
      '/api/matrix/service/$serviceId',
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    if (response.data['message'] == 'Successful') {
      log(response.data.toString());
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  Future<List<model.Bills>> getBillByService(
      {required String serviceId}) async {
    List<model.Bills> list = [];
    var response = await client().get(
      '/api/bills/by-service?service_id=$serviceId',
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );
    print("response.data[message]");
    print(response.data['message']);
    print("response.data[data]");
    print(response.data['data']);
    if (response.data['message'] == 'Successful') {
      log(response.data.toString());
      for (var item in response.data['data']['data']) {
        list.add(model.Bills.fromJson(item));
      }
    } else {
      return list;
    }
    return list;
  }

  Future<ErrorResponse> addToCartDzaf(AddCartRequest request) async {
    print("addToCartDzaf");
    print("Items: ${jsonEncode(request)}");
    print("Items: ${FormData.fromMap(request.toJson()).toString()}");
    try {
      var response = await client().post(
        '/api/carts/add', data: FormData.fromMap(request.toJson()),
        // options: Options(
        //   validateStatus: (status) {
        //     return status! < 600;
        //   },
        // ),
      );

      print(response.data);

      if (response.statusCode == 200) {
        return ErrorResponse(
            true, response.data['message'], response.statusCode,
            data: response.data["data"]);
      } else if (response.statusCode == 400) {
        return ErrorResponse(
            true, response.data['message'], response.statusCode,
            data: response.data["data"]);
      } else {
        return ErrorResponse(
          false,
          response.data["message"],
          response.statusCode,
          data: response.data["data"],
        );
      }
    } on DioError catch (e) {
      print("error api");
      print(e.message);
      print(e.response?.data);
      return ErrorResponse(false, e.response!.data['message'].toString(),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
  }

  Future<ErrorResponse> addToCartIkhwan(String service_id, String bill_id,
      String details, String amount, String items) async {
    print("addToCartIkhwan");
    try {
      var response = await client().post(
        '/api/carts/add',
        data: {
          'items': items,
        },
      );
      print("response.statusCode.toString()");
      print(response.statusCode.toString());
      print(response.data);
      if (response.statusCode == 200) {
        return ErrorResponse(
            true,
            response.data['message'],
            data: response.data["data"],
            response.statusCode);
      } else if (response.statusCode == 400) {
        return ErrorResponse(
            true,
            response.data['message'],
            data: response.data["data"],
            response.statusCode);
      } else {
        return ErrorResponse(
            false,
            response.data["message"],
            data: response.data["data"],
            response.statusCode);
      }
    } on DioError catch (e) {
      print("error api");
      print(e.message);
      print(e.response?.data);
      return ErrorResponse(false, e.response!.data['message'].toString(),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
  }

  Future<ErrorResponse> updateCart(AddCartRequest request, int cartId) async {
    print("updateCart");
    var response = await client().put(
      '/api/carts/$cartId',
      data: request.toJson(),
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    print(response.data);

    if (response.statusCode == 200) {
      return ErrorResponse(true, response.data['message'], response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }

  Future<ErrorResponse> favABill(
    String bill_id,
  ) async {
    try {
      var response = await client().post(
        '/api/bills/favorite',
        data: {
          'bill_id': bill_id,
        },
      );
      print("API response.data['message']");
      print(response.data['message']);
      if (response.data['message'] == 'Favorited the bill.' ||
          response.data['message'] == 'Bill removed from favorite.') {
        return ErrorResponse(
            true, response.data['message'], response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Payment gateway for cybersource
  Future<Uri> pay(double amount, String serviceCode) async {
    var response = await client().post(
      '/api/services/$serviceCode/pay',
      data: {
        'amount': amount,
      },
    );

    return Uri.parse(response.data!['data']['redirect']);
  }

  // Get config (tnc)
  Future<List<Tnc>> getConfigTnc() async {
    List<Tnc> tncs = [];
    try {
      var response = await client().get('/api/config');

      var myLocaleLang = Get.locale?.languageCode;

      if (response.data['data'] != null) {
        if (myLocaleLang.toString() == 'en') {
          for (var item in response.data['data']['translatables_lang_en']) {
            tncs.add(Tnc.fromJson(item));
            await store.setItem(
                'tncIdLS',
                response.data['data']['translatables_lang_en'][0]
                    ['translatable_id']);

            print(store.getItem('tncIdLS'));
          }
        } else {
          for (var item in response.data['data']['translatables_lang']) {
            tncs.add(Tnc.fromJson(item));
            await store.setItem(
                'tncIdLS',
                response.data['data']['translatables_lang'][0]
                    ['translatable_id']);

            print(store.getItem('tncIdLS'));
          }
        }
      }
    } on DioError catch (e) {
      print(e.response?.statusCode);
    }
    return tncs;
  }

  // Update tnc_updated to false if user accepted tnc
  Future<void> updateTnc(int tncId) async {
    var response = await client().post(
      '/api/user/update-tnc',
      data: {
        'tnc_id': tncId,
      },
    );
    print(response.data['message']);
  }

  // Get list of menu
  Future<List<Menu>> setupContents() async {
    List<Menu> menus = [];
    try {
      var response = await client().get('/api/menu');
      print(response);
      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          menus.add(Menu.fromJson(item));
        }
        state.value.menuState.set(menus);
      }
    } on DioError catch (_) {}
    return menus;
  }

  // Get list of submenu
  Future<List<Menu>> getSubmenu(int getMenuByParentId) async {
    List<Menu> list = [];
    try {
      var response = await client()
          .get('/api/menu?parent_id=' + getMenuByParentId.toString());
      // print(response.data['data']);
      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(Menu.fromJson(item));
        }
      }
    } on DioError catch (_) {
      print(_);
    }
    return list;
  }

  // Get service detail by id
  Future<ErrorResponse> getServiceDetail(String serviceRefNum) async {
    try {
      var response =
          await client().get('/api/services/' + serviceRefNum.toString());
      // print(response);

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', response.statusCode,
            data: response.data["data"]);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['message']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Get service detail by id
  Future<List<model.Bills>> getBillDetail(String serviceRefNum) async {
    List<model.Bills> list = [];
    try {
      var response = await client()
          .get('/api/public/bills/bill-mask/' + serviceRefNum.toString());
      // print(response);

      if (response.data['message'] == 'Successful') {
        list.add(model.Bills.fromJson(response.data['data']));
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return list;
      // ignore: unused_catch_clause
    } on Error catch (e) {
      return list;
    }
    return list;
  }

  Future<ErrorResponse> printReceipt(String transactionItemId) async {
    log("printReceipt");
    try {
      var response =
          await client().get("/api/payments/print-receipt", queryParameters: {
        "transaction_item_id": transactionItemId,
      });
      print(response);

      if (response.data['data'] != null) {
        return ErrorResponse(true, '', response.statusCode,
            data: response.data['data']["view_url"]);
      }
    } on DioError catch (e) {
      // print(e.message);
      // print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['message']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Get service menu
  Future<ErrorResponse> getServicesForMenu(int getMenuId) async {
    try {
      var response =
          await client().get('/api/services/menu/' + getMenuId.toString());
      print(response);

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', response.statusCode,
            data: response.data["data"]);
      }
    } on DioError catch (e) {
      // print(e.message);
      // print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['message']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Login
  Future<ErrorResponse> login(String username, String password) async {
    try {
      var response = await client().post(
        '/api/auth/login',
        data: {
          'email': username,
          'password': password,
        },
      );

      if (response.data['message'] == 'Successful') {
        token = response.data['data']['access_token'];
        tncUpdated = response.data['data']['tnc_updated'];
        Locale locale =
            new Locale(response.data["data"]["user"]["lang"] ?? "en");
        getx.Get.updateLocale(locale);

        print('TOKEN: ' + token);
        await store.setItem(kStoreUserToken, token);
        await store.setItem('tncUpdatedLS', tncUpdated);

        await resume();
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);
      print(e.response?.statusCode);

      return ErrorResponse(
          false,
          e.response!.data['message']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      print('Test 123');
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Set user state
  Future<void> setupUser() async {
    var response = await client().get('/api/user');
    print(response.data['data']['tnc_updated']);
    var refreshTnc = response.data['data']['tnc_updated'];

    var getEmailHistory = response.data['data']['email_histories'];
    store.setItem('getEmailHistoryLS', getEmailHistory);

    Locale locale =
        new Locale(response.data["data"]["profile"]["lang"] ?? "en");
    getx.Get.updateLocale(locale);
    store.setItem('tncUpdatedLS', refreshTnc);
    // store.setItem('getCurrentRatedLS', response.data['data']['is_rated']);

    state.setUser(User.fromJson(
        response.data['data']['profile'] as Map<String, dynamic>));
  }

  // Forgot password
  Future<ErrorResponse> forgotPassword(String email) async {
    try {
      var response = await client().post(
        '/api/auth/forgot-password?from=portal',
        data: {
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        print('We have emailed your password reset link!');
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data['errors']['email']);

      return ErrorResponse(
          false,
          e.response!.data['errors']['email']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }

    return ErrorResponse(false, 'Server Error', 0);
  }

  // Forgot userID
  Future<ErrorResponse> forgotUserID(
      String userID, int userIdentityTypeId) async {
    try {
      var response = await client().get('/api/auth/forgot-userid/' +
          userID +
          '?user_identity_type_id=' +
          userIdentityTypeId.toString());

      if (response.data['message'] == 'Successful') {
        await store.setItem('getUserID', response.data['data']['email']);
        print(store.getItem('getUserID').toString());

        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data['errors']);

      return ErrorResponse(
          false,
          e.response!.data['errors']['ic_no']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }

    return ErrorResponse(false, 'Server Error', 0);
  }

  // Register
  Future<ErrorResponse> register(
    String email,
    bool isBanned,
    String firstName,
    String lastName,
    int citizenship,
    String identityNo,
    int countryID,
    int? stateID,
    String address1,
    String address2,
    String address3,
    String postcodeId,
    int? districtID,
    int? cityID,
    String phoneNo,
    bool isCheckedTnc,
    String password,
    String passwordConfirmation,
    int identityTypeID,
    String identityEndDate,
    String stateName,
    String districtName,
    String cityName,
    int? countryNationalityId,
  ) async {
    try {
      var response = await client().post('/api/auth/register', data: {
        'email': email,
        'is_banned': isBanned,
        'first_name': firstName,
        'last_name': lastName,
        'citizenship': citizenship,
        'identity_no': identityNo,
        'country_id': countryID,
        'state_id': stateID,
        'address_1': address1,
        'address_2': address2,
        'address_3': address3,
        'postcode': postcodeId,
        'district_id': districtID,
        'city_id': cityID,
        'phone_no': phoneNo,
        'tnc': isCheckedTnc,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'user_identity_type_id': identityTypeID,
        'identity_end_date': identityEndDate,
        'state_name': stateName,
        'district_name': districtName,
        'city_name': cityName,
        'country_nationality_id': countryNationalityId,
      });

      print(response);

      if (response.data['message'] == 'Successful') {
        var token = response.data['data']['access_token'];
        await store.setItem(kStoreUserToken, token);
        await store.setItem('registerPath', response.data['data']['path']);
        await resume();
        print('Register success');
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);
      return ErrorResponse(
          false,
          e.response!.data['errors']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Verify code send by email
  Future<ErrorResponse> verifyEmailOTP(String code, String path) async {
    try {
      var response = await client().post(
        '/api/auth/verify',
        data: {
          'code': code,
          'path': path,
        },
      );

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);
      return ErrorResponse(false, e.response!.data['errors']['code'].toString(),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Resend OTP to email
  Future<bool> resendEmailOTP(String email) async {
    try {
      var response = await client().post(
        '/api/auth/resend',
        data: {
          'email': email,
        },
      );

      print(response);

      if (response.data['message'] == 'Successful') {
        token = response.data['data']['access_token'];
        await store.setItem(kStoreUserToken, token);
        await setupUser();
        return true;
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);
    }
    return false;
  }

  // Reset password
  Future<bool> resetPassword(String token, String email, String password,
      String passwordConfirmation) async {
    try {
      var response = await client().post(
        '/api/auth/reset-password',
        data: {
          'token': token,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      print(response);
      if (response.data['message'] == 'Successful') {
        print('We have emailed your password reset link!');
        return true;
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);
    }
    return false;
  }

  // Change password
  Future<ErrorResponse> changePassword(
    String currentPasssword,
    String passsword,
    String passwordConfirmation,
  ) async {
    try {
      var response = await client().post(
        '/api/user/change-password',
        data: {
          'current_password': currentPasssword,
          'new_password': passsword,
          'new_password_confirmation': passwordConfirmation,
        },
      );
      print(response);
      if (response.data['message'] == 'Successful') {
        print('Tukar kata laluan berjaya');
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['errors']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Get passport histories
  Future<List<PassportHistory>> getPassportHistories() async {
    List<PassportHistory> list = [];
    try {
      var response = await client().get('/api/user/passport-histories');

      if (response.data['message'] == 'Successful') {
        List<dynamic> responseData = response.data['data'];

        for (var item in responseData) {
          list.add(PassportHistory.fromJson(item));
        }
        print(response);
      }
    } on DioError catch (_) {}
    return list;
  }

  // Update profile
  Future<ErrorResponse> updateProfile(
    String firstName,
    String lastName,
    String email,
    String phoneNo,
    int citizenship,
    String address1,
    String? address2,
    String? address3,
    int? stateId,
    int? districtId,
    int? cityId,
    String postcode,
    int? countryNationalityId,
    int? countryId,
    String? stateName,
    String? districtName,
    String? cityName,
    int? userIdentityTypeId,
    String? identityNo,
    String? identityEndDate,
    String? reason,
  ) async {
    try {
      print('hit api');
      var response = await client().post('/api/user', data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_no': phoneNo,
        'citizenship': citizenship,
        'address_1': address1,
        'address_2': address2,
        'address_3': address3,
        'state_id': stateId,
        'district_id': districtId, // Postcode auto
        'city_id': cityId, // Postcode auto
        'postcode': postcode,
        'country_nationality_id': countryNationalityId,
        'country_id': countryId, // Postcode auot
        'state_name': stateName,
        'district_name': districtName,
        'city_name': cityName,
        'user_identity_type_id': userIdentityTypeId,
        'identity_no': identityNo,
        'identity_end_date': identityEndDate,
        'reason': reason,
      });

      if (response.data['message'] == 'Profil anda telah dikemas kini.') {
        await setupUser();
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Get country
  Future<List<Country>> getCountry() async {
    List<Country> list = [];
    try {
      var response = await client().get('/api/config/countries_states');

      if (response.data['data'] != null) {
        for (var item in response.data['data']['countries']) {
          list.add(Country.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get states
  Future<List<States>> getStates() async {
    List<States> list = [];
    try {
      var response = await client().get('/api/config/countries_states');

      if (response.data['data'] != null) {
        for (var item in response.data['data']['states']) {
          list.add(States.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get district
  Future<List<District>> getDistrict(int? stateID) async {
    List<District> list = [];
    try {
      var response = await client()
          .get('/api/config/districts?state_id=' + stateID.toString());

      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(District.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get city
  Future<List<City>> getCity() async {
    List<City> list = [];
    try {
      var response = await client().get('/api/config/cities');

      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(City.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get postcode for state & city
  Future<List<PostcodeState>> getPostcodeState(String postcode) async {
    List<PostcodeState> list = [];

    try {
      var response = await client().get('/api/config/postcodes/' + postcode);
      if (response.data['data'].isNotEmpty) {
        list.add(PostcodeState.fromJson(response.data['data']['state']));
      } else {
        // print('State is null');
        // getStates();
      }
    } on DioError catch (_) {}
    return list;
  }

  Future<List<PostcodeCity>> getPostcodeCity(String postcode) async {
    List<PostcodeCity> list = [];
    try {
      var response = await client().get('/api/config/postcodes/' + postcode);

      if (response.data['data'].isNotEmpty) {
        for (var item in response.data['data']['cities']) {
          list.add(PostcodeCity.fromJson(item));
          await store.setItem('postcodeValidLS', 'data');
        }
      } else {
        await store.setItem('postcodeValidLS', 'empty');
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get character count from identityType
  Future<List<CharacterCount>> getCharacterCount(int id) async {
    List<CharacterCount> list = [];
    try {
      var response = await client()
          .get('/api/user-identity-types/character-count?id=' + id.toString());

      if (response.data['data'].isNotEmpty) {
        store.setItem(
            'characterCountLS', response.data['data']['character_count']);
        store.setItem('typeLS', response.data['data']['type']);
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get identity type all
  Future<List<IdentityType>> getIndentityTypeAll() async {
    List<IdentityType> list = [];
    try {
      var response = await client().get('/api/user-identity-types/individual');
      if (response.data['data'] != null) {
        for (var item in response.data['data']['citizen']) {
          list.add(IdentityType.fromJson(item));
        }
        for (var item in response.data['data']['non_citizen']) {
          list.add(IdentityType.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get identity type for netizen
  Future<List<IdentityType>> getIndentityType() async {
    List<IdentityType> list = [];
    try {
      var response = await client().get('/api/user-identity-types/individual');
      // print(response);
      if (response.data['data'] != null) {
        for (var item in response.data['data']['citizen']) {
          list.add(IdentityType.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get identity type for non-netizen
  Future<List<IdentityType>> getIndentityTypeNonCitezen() async {
    List<IdentityType> list = [];
    try {
      var response = await client().get('/api/user-identity-types/individual');
      if (response.data['data'] != null) {
        for (var item in response.data['data']['non_citizen']) {
          list.add(IdentityType.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get list of organization member
  Future<List<ListOrganizationMember>> getOrganizationMember(int oId) async {
    List<ListOrganizationMember> list = [];
    try {
      var response = await client().get('/api/organizations/' + oId.toString());

      if (response.data['data'] != null) {
        for (var item in response.data['data']['members']) {
          list.add(ListOrganizationMember.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get list of organization member
  Future<List<AddMember>> getOrganizationUserByIc(
      String identityCode, int identityTypeId) async {
    print(identityCode);
    print(identityTypeId);

    List<AddMember> list = [];
    try {
      var response = await client().get(
          '/api/organizations/admin/user-by-ic?identity_code=' +
              identityCode +
              '&identity_type_id=' +
              identityTypeId.toString());

      if (response.data['message'] == 'Successful') {
        list.add(AddMember.fromJson(response.data['data']));
        print(response);
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get list of organization admin
  Future<List<Organization>> getOrganization() async {
    List<Organization> list = [];
    try {
      var response = await client().get('/api/organizations');

      if (response.data['data'].isNotEmpty) {
        for (var item in response.data['data']) {
          list.add(Organization.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Validate organization number
  Future<List<Organization>> validateOrganizationNo(
      String org_registration_no) async {
    List<Organization> list = [];
    try {
      var response = await client().get(
          '/api/user-identity-types/validate-organization-no?org_registration_no=' +
              org_registration_no);

      print(response);

      if (response.data['data'].isNotEmpty) {
        await store.setItem('hasValueLS', 'data');
      } else {
        await store.setItem('hasValueLS', 'empty');
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get organization type
  Future<List<OrganizationType>> getOrganizationType() async {
    List<OrganizationType> list = [];
    try {
      var response =
          await client().get('/api/user-identity-types/organization');

      if (response.data['message'] == 'Successful') {
        for (var item in response.data['data']) {
          list.add(OrganizationType.fromJson(item));
        }
      } else {
        for (var item in response.data['data']) {
          list.add(OrganizationType.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Create and get organization detail
  Future<ErrorResponse> organizationDetail(
    int userId,
    String orgName,
    String orgEmail,
    int orgTypeId,
    String orgRegistrationNo,
    String dateExtablished,
    String address1,
    String address2,
    String address3,
    String postcode,
    int? stateId,
    int? districtId,
    int? cityId,
    String? stateName,
    String? districtName,
    String? cityName,
    int countryId,
    String? phoneNo,
  ) async {
    try {
      var response = await client().post('/api/organizations', data: {
        'user_id': userId,
        'org_name': orgName,
        'org_email': orgEmail,
        'user_identity_type_id': orgTypeId,
        'org_registration_no': orgRegistrationNo,
        'date_extablished': dateExtablished,
        'address_1': address1,
        'address_2': address2,
        'address_3': address3,
        'postcode': postcode,
        'state_id': stateId,
        'district_id': districtId,
        'city_id': cityId,
        'state_name': stateName,
        'district_name': districtName,
        'city_name': cityName,
        'country_id': countryId,
        'phone_no': phoneNo,
      });

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Update organization
  Future<ErrorResponse> updateOrganization(
    int orgId,
    String orgName,
    String orgEmail,
    int orgTypeId,
    String orgRegistrationNo,
    String dateExtablished,
    String address1,
    String? address2,
    String? address3,
    String postcode,
    int? stateId,
    int? districtId,
    int? cityId,
    String? stateName,
    String? districtName,
    String? cityName,
    int countryId,
    String? phoneNo,
  ) async {
    try {
      var response =
          await client().put('/api/organizations/' + orgId.toString(), data: {
        'id': orgId,
        'org_name': orgName,
        'org_email': orgEmail,
        'user_identity_type_id': orgTypeId,
        'org_registration_no': orgRegistrationNo,
        'date_extablished': dateExtablished,
        'address_1': address1,
        'address_2': address2,
        'address_3': address3,
        'postcode': postcode,
        'state_id': stateId,
        'district_id': districtId,
        'city_id': cityId,
        'state_name': stateName,
        'district_name': districtName,
        'city_name': cityName,
        'country_id': countryId,
        'phone_no': phoneNo,
      });

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['message']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Delete organization
  // Future<ErrorResponse> organizationDeleted(
  //   int? oId,
  // ) async {
  //   try {
  //     var response =
  //         await client().delete('/api/organizations/' + oId.toString());

  //     if (response.data['message'] == 'Successful') {
  //       return ErrorResponse(true, '');
  //     }
  //   } on DioError catch (e) {
  //     print(e.message);
  //     print(e.response?.data);

  //     return ErrorResponse(false, e.response!.data['errors'].toString());
  //   } on Error catch (e) {
  //     return ErrorResponse(false, e.stackTrace.toString());
  //   }
  //   return ErrorResponse(false, 'Server Error');
  // }

  // Add member to organization
  Future<ErrorResponse> addMember(
      int orgId, List<ListLocalAddMember> userInfo) async {
    List<String> fillterIcNo = userInfo.map((model) => model.icNo).toList();

    try {
      var response = await client().post(
        '/api/organizations/add-member',
        data: {
          'org_id': orgId,
          'ic_no': fillterIcNo,
        },
      );
      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['errors']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          0);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Get enquiry list
  Future<List<Enquiry>> getEnquiry(int perPage) async {
    List<Enquiry> list = [];

    try {
      var response =
          await client().get('/api/rfm?per_page=' + perPage.toString());

      // print(response.data['total']);

      if (response.data['message'] == 'Successful') {
        await store.setItem('paginateTotalLS', response.data['total']);
        for (var item in response.data['data']) {
          list.add(Enquiry.fromJson(item));
        }
      } else {
        await store.setItem('paginateTotalLS', response.data['total']);
        for (var item in response.data['data']) {
          list.add(Enquiry.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get reassgin enquiry list
  Future<List<Enquiry>> getReassignEnquiry() async {
    List<Enquiry> list = [];

    try {
      var response = await client().get('/api/rfm/get-reassign');

      if (response.data['message'] == 'Successful') {
        for (var item in response.data['data']) {
          list.add(Enquiry.fromJson(item));
        }
      
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get enquiry detail
  Future<List<Enquiry>> getEnquiryDetails(String id) async {
    List<Enquiry> list = [];

    try {
      var response = await client().get('/api/rfm?find?id=' + id);

      if (response.data['message'] == 'Successful') {
        for (var item in response.data['data']) {
          list.add(Enquiry.fromJson(item));
        }
      } else {
        for (var item in response.data['data']) {
          list.add(Enquiry.fromJson(item));
        }
      }
    } on DioError catch (e) {
      print(e.error);
      print(e.message);
    }
    return list;
  }

  // Get Enquiry Category
  Future<List<CategoryEnquiry>> getEnquiryCategory(String userType) async {
    print('USER TYPE: ' + userType);
    List<CategoryEnquiry> list = [];
    try {
      var response = await client().get('/api/rfm/category');

      print(response.data['data']['is_reference_number']);

      if (response.data['message'] == 'Successful' && userType == "user") {
        for (var item in response.data['data']["user"]) {
          list.add(CategoryEnquiry.fromJson(item));
        }
      } else {
        for (var item in response.data['data']['user']) {
          list.add(CategoryEnquiry.fromJson(item));
        }
        for (var item in response.data['data']['gov']) {
          list.add(CategoryEnquiry.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get Enquiry Category
  Future<ErrorResponse> getEnquiryRefNo(String enquiry_category_id) async {
    try {
      var response = await client().post(
        '/api/rfm/check-bill-required',
        data: {
          'enquiry_category_id': enquiry_category_id,
        },
      );

      // print(response.data['data']['is_reference_number']);

      await store.setItem(
          'isRefNoLS', response.data['data']['is_reference_number']);

      if (response.statusCode == 200) {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print("error api");
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Get Enquiry Category
  Future<List<FileSettingEnquiry>> getFileSettingEnquiry() async {
    List<FileSettingEnquiry> list = [];
    try {
      var response = await client().get('/api/rfm/upload-validation');

      // print(response.data['data']);

      if (response.data['message'] == 'Successful') {
        for (var item in response.data['data']) {
          list.add(FileSettingEnquiry.fromJson(item));
        }
      } else {
        for (var item in response.data['data']) {
          list.add(FileSettingEnquiry.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Submit Enquiry
  Future<ErrorResponse> submitEnquiry(
    int enquiryCategoryId,
    int enquirySettingId,
    String userid,
    String referencenumber,
    String title,
    String description,
    List<File> file,
    Organization org,
    int? agencyId,
  ) async {
    try {
      if (file.isNotEmpty) {
        var filePath = file[0].path;
        var fileName = file[0].path.split('/').last.toString().toTitleCase();

        var formData = FormData.fromMap({
          'enquiry_category_id': enquiryCategoryId,
          'enquiry_setting_id': enquirySettingId,
          'user_id': userid,
          'reference_number': referencenumber,
          'title': title,
          'description': description,
          'agency_id': agencyId,
          'org_id': org.id,
          "file": await MultipartFile.fromFile(filePath, filename: fileName),

          //   'file': [
          //   for (var i = 0; i < file.length; i++)
          //     {
          //       await MultipartFile.fromFile(file[i].path,
          //           contentType: new MediaType("image", "jpeg")),
          //     }
          // ]
        });

        var response = await client2().post(
          '/api/rfm/store',
          data: formData,
        );

        if (response.data['message'] == 'Successful') {
          return ErrorResponse(true, '', response.statusCode);
        }
      } else {
        var formData = FormData.fromMap({
          'enquiry_category_id': enquiryCategoryId,
          'enquiry_setting_id': enquirySettingId,
          'user_id': userid,
          'reference_number': referencenumber,
          'title': title,
          'description': description,
          'agency_id': agencyId,
          'org_id': org.id,
        });

        var response = await client2().post(
          '/api/rfm/store',
          data: formData,
        );

        if (response.data['message'] == 'Successful') {
          return ErrorResponse(true, '', response.statusCode);
        }
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Complete Enquiry
  Future<ErrorResponse> completeEnquiry(int id, String? remark) async {
    try {
      var response = await client().post(
        '/api/rfm/completed-by-user',
        data: {'id': id, 'complete_user_remark': remark},
      );

      if (response.statusCode == 200) {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print("error api");
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Rating Setting
  Future getRatingSetting() async {
    Map test = {};
    try {
      var response = await client().get('/api/rfm/rating-setting');

      print(response);

      if (response.data['message'] == 'Successful') {
        test = response.data["data"];
        return test;
      } else {
        test = response.data["data"];
        return test;
      }
    } on DioError catch (_) {}
    return test;
  }

  // Submit Rating
  Future<ErrorResponse> submitRating(
    String userid,
    String remarks,
    double score,
    String platform,
  ) async {
    try {
      var response = await client().post(
        '/api/rfm/rate',
        data: {
          'user_id': userid,
          'remarks': remarks,
          'score': score,
          'platform': platform
        },
      );

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  //Get Chat Enquiry
  Future<List<ChatMessage>> getChatEnquiry(String id) async {
    List<ChatMessage> list = [];
    try {
      var response =
          await client().get('/api/rfm/find-replay?enquiry_id=' + id);

      // print(response);

      if (response.data['message'] == 'Successful') {
        for (var item in response.data['data']) {
          list.add(ChatMessage.fromJson(item));
        }
      } else {
        for (var item in response.data['data']) {
          list.add(ChatMessage.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Submit Chat
  Future<ErrorResponse> submitChat(
    String enquiry_id,
    String user_id,
    String remark,
    List<File> file,
  ) async {
    try {
      if (file.isNotEmpty) {
        var filePath = file[0].path;
        var fileName = file[0].path.split('/').last.toString().toTitleCase();

        var formData = FormData.fromMap({
          'enquiry_id': enquiry_id,
          'user_id': user_id,
          'remark': remark,
          "file": await MultipartFile.fromFile(filePath, filename: fileName),
        });

        var response = await client2().post(
          '/api/rfm/store-replay',
          data: formData,
        );

        if (response.data['message'] == 'Successful') {
          return ErrorResponse(true, '', response.statusCode);
        }
      } else {
        var formData = FormData.fromMap({
          'enquiry_id': enquiry_id,
          'user_id': user_id,
          'remark': remark,
        });

        var response = await client2().post(
          '/api/rfm/store-replay',
          data: formData,
        );

        if (response.data['message'] == 'Successful') {
          return ErrorResponse(true, '', response.statusCode);
        }
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

// Get Faq
  Future<List<Faq>> getFAQ() async {
    List<Faq> list = [];
    try {
      var response = await client().get('/api/rfm/faq');

      print(response);

      print('IGSMS');

      if (response.data['message'] == 'Successful') {
        for (var item in response.data['data']) {
          list.add(Faq.fromJson(item));
        }
      } else {
        for (var item in response.data['data']) {
          list.add(Faq.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

// Get Bills
  Future<List<model.Bills>> GetBills(String search, String id) async {
    List<model.Bills> list = [];
    try {
      // var response = await client().get('/api/bills?search=' +
      //     search +
      //     "&bill_type_ids[]=" +
      //     id +
      //     "&per_page=50&paginated=true");
      var response = await client().get('/api/bills?search=' +
          search +
          "&identity_code_categories[]=" +
          id +
          "&per_page=50&paginated=true");
      print('/api/bills?search=' +
          search +
          "&identity_code_categories[]=" +
          id +
          "&per_page=50&paginated=true");
// + identity_code
      // print(response.data.toString());
      if (response.data['data'] != null) {
        for (var item in response.data['data']['data']) {
          list.add(model.Bills.fromJson(item));
        }
      } else if (response.data['message'] == "Not found") {
        return list;
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get Payment Gateway
  Future<List<model.PaymentGateway>> GetPaymentGateway() async {
    List<model.PaymentGateway> list = [];
    try {
      var response = await client().get('/api/payments/gateways');
// + identity_code
      if (response.data['data'] != null) {
        print(response);

        for (var item in response.data['data']) {
          list.add(model.PaymentGateway.fromJson(item));
        }
      } else if (response.data['message'] == "Not found") {
        return list;
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get Paynent Bank
  Future<List<Bank>> GetPaynetBank() async {
    List<Bank> list = [];
    try {
      var response = await client().get('/api/payments/paynet-banks');
      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(Bank.fromJson(item));
        }
      } else if (response.data['message'] == "Not found") {
        return list;
      }
    } on DioError catch (_) {}
    return list;
  }

// ! Hide dulu tak tahu kenapa ada 2 function add to cart
// //Add to cart

  // Get Payment History
  Future GetPaymetHistory(
    String search,
    String xls,
    String pdf,
    String date_from,
    String date_to,
    String payment_category,
  ) async {
    //  String search,String xls,String pdf,String date_from,String date_to,
    List<model.HistoryItem> list = [];
    try {
      print('/api/payments/histories-items' +
          '?search=' +
          search +
          '&xls=' +
          xls +
          '&pdf=' +
          pdf +
          '&date_from=' +
          date_from +
          '&date_to=' +
          date_to +
          '&payment_category=' +
          payment_category +
          '&per_page=100&order=desc');
      var response = await client().get('/api/payments/histories-items' +
          '?search=' +
          search +
          '&xls=' +
          xls +
          '&pdf=' +
          pdf +
          '&date_from=' +
          date_from +
          '&date_to=' +
          date_to +
          '&payment_category=' +
          payment_category +
          '&per_page=100&order=desc');
      if (response.data['data'] != null &&
          response.data['message'] == "Successful") {
        for (var item in response.data['data']['data']) {
          list.add(model.HistoryItem.fromJson(item));
        }
      } else if (response.data['message'] == "Not found") {
        return list;
      } else if (response.data['message'] == "Filter no result") {
        return list;
      } else if (response.data['message'] == "History in PDF") {
        print("History in PDF");
        return response.data['data'];
      } else if (response.data['message'] == "History in CSV") {
        print("History in CSV");
        return response.data['data'];
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get Payment History
  Future GetPaymetHistory2(
    String search,
    String xls,
    String pdf,
    String date_from,
    String date_to,
  ) async {
    //  String search,String xls,String pdf,String date_from,String date_to,
    List<model.History> list = [];
    try {
      print('/api/payments/histories'
              '?search=' +
          search +
          '&xls=' +
          xls +
          '&pdf=' +
          pdf +
          '&date_from=' +
          date_from +
          '&date_to=' +
          date_to +
          '&payment_category=' +
          '&per_page=100&order=desc');
      var response = await client().get('/api/payments/histories'
              '?search=' +
          search +
          '&xls=' +
          xls +
          '&pdf=' +
          pdf +
          '&date_from=' +
          date_from +
          '&date_to=' +
          date_to +
          '&payment_category=' +
          '&per_page=100&order=desc');
      if (response.data['data'] != null &&
          response.data['message'] == "Successful") {
        for (var item in response.data['data']['data']) {
          list.add(model.History.fromJson(item));
        }
      } else if (response.data['message'] == "Not found") {
        return list;
      } else if (response.data['message'] == "Filter no result") {
        return list;
      } else if (response.data['message'] == "History in PDF") {
        print("History in PDF");
        return response.data['data'];
      } else if (response.data['message'] == "History in CSV") {
        print("History in CSV");
        return response.data['data'];
      }
    } on DioError catch (_) {}
    return list;
  }

  Future GetDownloadReceipt(String id) async {
    String list = "";
    try {
      var response = await client()
          .get('/api/payments/download-receipt?transaction_item_id=' + id);
      if (response.data['data'] != null) {
        list = response.data['data']["download_url"];
      } else if (response.data['message'] == "Not found") {
        return list;
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get Paynent Bank
  Future<List<model.FavBills>> GetFavBills() async {
    List<model.FavBills> list = [];
    try {
      var response = await client().get('/api/bills/favorite');
      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(model.FavBills.fromJson(item));
        }
      } else if (response.data['message'] == "Not found") {
        return list;
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get Paynent Bank
  Future<Map> GetRounding(String value) async {
    Map list = {};
    try {
      print('/api/config/rounding?value=' + value);
      var response = await client().get('/api/config/rounding?value=' + value);
      if (response.data['data'] != null) {
        list.addAll(response.data['data']);
      } else if (response.data['message'] == "Not found") {
        return list;
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get Incomplete Trans
  Future<List<model.Incomplete>> GetIncomplete() async {
    List<model.Incomplete> list = [];
    try {
      print('/api/payments/incomplete?per_page=50');
      var response = await client().get('/api/payments/incomplete?per_page=50');
      print(response.data['data'].toString());
      print(response.data['data']['current_page'].toString());
      print(response.data['data']['data'].toString());
      if (response.data['data'] != null) {
        for (var item in response.data['data']['data']) {
          list.add(model.Incomplete.fromJson(item));
        }
      } else if (response.data['message'] == "Not found") {
        return list;
      }
    } on DioError catch (_) {}
    return list;
  }

  //   Future<List<Incomplete>> GetIncomplete() async {
  //   List<Incomplete> list = [];
  //   try {
  //     var response = await client().get('/api/payments/incomplete');
  //     if (response.data['data'] != null) {
  //       for (var item in response.data['data']) {
  //         list.add(Incomplete.fromJson(item));
  //       }
  //     } else if (response.data['message'] == "Not found") {
  //       return list;
  //     }
  //   } on DioError catch (_) {}
  //   return list;
  // }

  //Add to cart
  Future<ErrorResponse> cancelPayemnt(
    String reference_number,
  ) async {
    try {
      var response = await client().post(
        '/api/payments/cancel',
        data: {
          'reference_number': reference_number,
        },
      );

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  //* ADMIN
  // Update status organization
  Future<ErrorResponse> updateStatusAdminOrganization(
      int? org_id, int? user_id) async {
    try {
      var response = await client().post(
        '/api/organizations/admin/update-status',
        data: {'org_id': org_id, 'user_id': user_id},
      );

      print(response);

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['errors']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Delete member organization
  Future<ErrorResponse> deleteMemberAdminOrganization(
      int? org_id, int? user_id) async {
    try {
      var response = await client().post(
        '/api/organizations/admin/delete-member',
        data: {'org_id': org_id, 'user_id': user_id},
      );

      print('DELETE API ' + response.toString());

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['errors']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Reference bill/ receipt
  Future<int?> referenceBillOrReceipt(String? reference_number) async {
    try {
      var response = await client().get(
        '/api/rfm/reference-no-bill-or-receipt?reference_number=' +
            reference_number.toString(),
      );

      if (response.data['data'].isNotEmpty) {
        return response.data['data']['agency_id'];
      }

      return null;
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return null;
    } on Error catch (_) {
      return null;
    }
  }

  // Promote user to admin organization
  Future<ErrorResponse> promoteUserToAdminOrganization(
      int? org_id, int? user_id) async {
    try {
      var response = await client().post(
        '/api/organizations/admin/member-to-admin',
        data: {'org_id': org_id, 'user_id': user_id},
      );

      print('DELETE API ' + response.toString());

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['errors']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Promote user to admin organization
  Future<ErrorResponse> checkAdminOrganization(
      int? org_id, int? user_id) async {
    try {
      var response = await client().post(
        '/api/organizations/admin/check-admin',
        data: {'org_id': org_id, 'user_id': user_id},
      );

      print(response.data['data']);

      if (response.data['message'] == 'Successful') {
        await store.setItem('isMemberAdminLS', response.data['data']);
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['errors']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Demote admin to user organization
  Future<ErrorResponse> demoteAdminToUserOrganization(
      int? org_id, int? user_id) async {
    try {
      var response = await client().post(
        '/api/organizations/admin/admin-to-member',
        data: {'org_id': org_id, 'user_id': user_id},
      );

      print(response.data['data']);

      if (response.data['message'] == 'Successful') {
        await store.setItem('isMemberAdminLS', response.data['data']);
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['errors']
              .toString()
              .replaceAll("{", "")
              .replaceAll("[", "")
              .replaceAll("]", "")
              .replaceAll("}", ""),
          e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Void Enquiry
  Future<ErrorResponse> voidEnquiry(int enquiry_id, int user_id) async {
    try {
      var response = await client().post(
        '/api/rfm/void',
        data: {'enquiry_id': enquiry_id, 'user_id': user_id},
      );
      print('Berjaya batal pertanyaan.');
      if (response.statusCode == 200) {
        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print("error api");
      print(e.message);
      print(e.response?.data);
      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Enforce logout
  Future<ErrorResponse> enforceLogout(int user_id, String platform) async {
    try {
      var response = await client().post(
        '/api/rfm/enforce-rate-logout',
        data: {'user_id': user_id, 'platform': platform},
      );

      print('api: ' + response.toString());

      if (response.statusCode == 200) {
        await store.setItem('getCurrentRatedLS', response.data['data']);
        print('API rating status: ' +
            store.getItem('getCurrentRatedLS').toString());

        return ErrorResponse(true, '', response.statusCode);
      }
    } on DioError catch (e) {
      print("error api");
      print(e.message);
      print(e.response?.data);
      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Retry payment
  Future<ErrorResponse> retryPayment(
    String id,
    String payment_method,
    String bank_code,
    String redirect_url,
    String bank_type,
  ) async {
    Map dataPost = {};
    if (payment_method == "2") {
      dataPost = {
        'id': id,
        'payment_method': payment_method,
        'bank_code': bank_code,
        'redirect_url': redirect_url,
        'bank_type': bank_type,
        'source': 'mobile'
      };
    } else {
      dataPost = {
        'id': id,
        'payment_method': payment_method,
        'source': 'mobile'
      };
    }
    print(dataPost.toString());
    try {
      var response = await client().post(
        '/api/payments/retry-payment',
        data: dataPost,
      );

      print('api: ' + response.toString());

      if (response.statusCode == 200) {
        return ErrorResponse(
            true,
            response.data['message'],
            data: response.data["data"],
            response.statusCode);
      }
    } on DioError catch (e) {
      print("error api");
      print(e.message);
      print(e.response?.data);
      return ErrorResponse(
          false, e.response!.data['errors'].toString(), e.response?.statusCode);
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString(), 0);
    }
    return ErrorResponse(false, 'Server Error', 0);
  }

  // Get enquiry list
  Future<List<AboutUs>> getAboutUs() async {
    List<AboutUs> list = [];

    try {
      var response = await client().get('/api/content/about-us');

      if (response.data['message'] == 'Successful') {
        // will rework this api laler
        await store.setItem('phoneLS', response.data['data']['phone']);
        await store.setItem('emailLS', response.data['data']['email']);
        await store.setItem('webLinkLS', response.data['data']['web_link']);
        await store.setItem('fbLinkLS', response.data['data']['fb_link']);
        await store.setItem(
            'twitterLinkLS', response.data['data']['twitter_link']);
        await store.setItem(
            'youtubeLinkLS', response.data['data']['youtube_link']);

        await store.setItem(
            'enTitleLS', response.data['data']['translatables'][0]['content']);
        await store.setItem(
            'enDescLS', response.data['data']['translatables'][1]['content']);
        await store.setItem(
            'myTitleLS', response.data['data']['translatables'][2]['content']);
        await store.setItem(
            'myDescLS', response.data['data']['translatables'][3]['content']);
      }
    } on DioError catch (_) {}
    return list;
  }

  // Users manual
  Future<List<UserManual>> getUserManual() async {
    List<UserManual> list = [];

    try {
      var response =
          await client().get('/api/user-manual/link?type=Mobile App');

      print(response);

      if (response.data['message'] == 'Successful') {
        for (var item in response.data['data']) {
          list.add(UserManual.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get widget menu
  Future<List> widgetMenu() async {
    List list = [];

    try {
      var response = await client().get('/api/dashboard');

      if (response.data['message'] == 'Successful') {
        // Will rework soon

        print(response);

        await store.setItem(
            'bilIndividualLS', response.data['data']['bill_individual_count']);
        await store.setItem('billOrganizationLS',
            response.data['data']['bill_organisation_count']);
        await store.setItem(
            'enquiryActiveLS', response.data['data']['rfm_count']);
        await store.setItem(
            'serviceFavouriteLS', response.data['data']['service_count']);
        await store.setItem(
            'billFavouriteLS', response.data['data']['bill_count']);
        await store.setItem(
            'paymentPendingLS', response.data['data']['payment_pending_count']);
      }
    } on DioError catch (_) {}
    return list;
  }

  Future<ErrorResponse> getBill(int id) async {
    String url = "/api/bills/" + id.toString();

    var response = await client().get(
      url,
      options: Options(
        validateStatus: (status) {
          return status! < 600;
        },
      ),
    );

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', response.statusCode,
          data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        response.statusCode,
        data: response.data["data"],
      );
    }
  }
}

var api = Api(
  ApiInbox(),
);
