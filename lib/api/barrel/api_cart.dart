import 'package:dio/dio.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/models.dart';
import 'package:flutterbase/models/payments/qr_pay_result.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';
import 'package:http_query_string/http_query_string.dart';

class ApiCart extends ApiClient {
  Future<ApiCartIndex> getIndex({
    List<int>? ids,
    bool withTotal = false,
  }) async {
    List<CartItem> list = [];
    String? total;

    try {
      var queryString = Encoder().convert({
        ...((ids ?? []).length > 0 ? {'ids': ids} : {}),
        ...(withTotal ? {'with_total': 1} : {})
      });

      var response = await ApiClient.instance.get("/api/carts?$queryString");

      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(CartItem.fromJson(item));
        }
      }

      total = response.data['total'];
    } on DioError catch (_) {
    } catch (_) {
      xdd(_);
    }

    return ApiCartIndex(cartItems: list, total: total);
  }

  Future<CartCountResponse?> getCount() async {
    try {
      var response = await ApiClient.instance.get("/api/carts/count");

      if (response.data['data'] != null) {
        return CartCountResponse.fromJson(response.data['data']);
      }
    } on DioError catch (_) {
      xdd(_);
      return null;
    } catch (_) {
      xdd(_);
      return null;
    }

    return null;
  }

  Future<bool> delete(int cid) async {
    try {
      await ApiClient.instance.delete("/api/carts/$cid");
    } on DioError catch (_) {
      xdd(_);
      return false;
    } catch (_) {
      xdd(_);
      return false;
    }

    return true;
  }

  Future<bool> addItems(List<CartItem> cartItems) async {
    try {
      Map<String, dynamic> data = {
        'items': cartItems,
      };

      await ApiClient.instance.post("/api/carts/add", data: data);
    } on DioError catch (_) {
      xdd(_);
      return false;
    } catch (_) {
      xdd(_);
      return false;
    }

    return true;
  }

  Future<bool> update(int cid, {required Map<String, dynamic> body}) async {
    try {
      await ApiClient.instance.put("/api/carts/$cid", data: body);
    } on DioError catch (_) {
      xdd(_);
      return false;
    } catch (_) {
      xdd(_);
      return false;
    }

    return true;
  }

  Future<PayResult?> pay(Map<String, dynamic> queryParams) async {
    CancelToken token = CancelToken();

    // var snackCtrl = toast(
    //   'Please wait and do not close.'.tr,
    //   action: SnackBarAction(
    //     label: 'Cancel'.tr,
    //     onPressed: () {
    //       token.cancel('Cancel request.');
    //     },
    //   ),
    // );

    try {
      queryParams['source'] = 'mobile';

      var response = await ApiClient.instance.get("/api/carts/pay",
          queryParameters: queryParams, cancelToken: token);

      // snackCtrl.close();

      if (response.data['data'] != null) {
        return PayResult.fromJson(response.data['data']);
      }
    } on DioError catch (_) {
      xdd(_);
      return null;
    } catch (_) {
      xdd(_);
      return null;
    }

    return null;
  }

  Future<QrPayResult?> payQr(Map<String, dynamic> queryParams) async {
    CancelToken token = CancelToken();

    // var snackCtrl = toast(
    //   'Please wait and do not close.'.tr,
    //   action: SnackBarAction(
    //     label: 'Cancel'.tr,
    //     onPressed: () {
    //       token.cancel('Cancel request.');
    //     },
    //   ),
    // );

    try {
      queryParams['source'] = 'mobile';

      var response = await ApiClient.instance.get("/api/carts/pay",
          queryParameters: queryParams, cancelToken: token);

      // snackCtrl.close();

      if (response.data['data'] != null) {
        return QrPayResult.fromJson(response.data['data']);
      }
    } on DioError catch (e, s) {
      xlog([e, s].toString());
      toast(
        "Something went wrong, please try again later.".tr,
        level: SnackLevel.Error,
      );
      return null;
    } catch (e, s) {
      xlog([e, s].toString());
      toast(
        "Something went wrong, please try again later.".tr,
        level: SnackLevel.Error,
      );
      return null;
    }

    return null;
  }
}

class ApiCartIndex {
  ApiCartIndex({required this.cartItems, this.total});

  String? total;
  List<CartItem> cartItems;
}
