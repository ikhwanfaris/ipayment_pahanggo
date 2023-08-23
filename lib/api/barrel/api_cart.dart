import 'package:dio/dio.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/controller/cart_counter_controller.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/cart/cart.dart';
import 'package:flutterbase/models/payments/pay_result.dart';
import 'package:flutterbase/models/payments/qr_pay_result.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:get/get.dart';

class ApiCart extends ApiClient {

  Future<int> getCount() async {
    try {
      var response = await ApiClient.instance.get("/api/carts/count");
      if (response.data['data'] != null) {
        return response.data['data']['count'];
      }
    } on DioError catch (_) {
      if(_.response?.statusCode == 401) {
        logout(getContext());
        return 0;
      }
      xdd(_);
      return 0;
    } catch (_) {
      xdd(_);
      return 0;
    }

    return 0;
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

    cartCount.refreshCount();

    return true;
  }

  Future<dynamic> add(CartAddRequest addRequest) async {
    var _response;

    try {
      _response = await ApiClient.instance.post("/api/carts/add", data: addRequest.toJson());
    } on DioError catch (_) {
      return _.response?.data!;
    } catch (_) {
      return {'message' : 'Unknown error'};
    }

    cartCount.refreshCount();

    return _response.data;
  }

  Future<bool> update(int cid, {required Map<String, dynamic> body}) async {
    try {
      await ApiClient.instance.post("/api/carts/$cid", data: body);
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
      var response = await ApiClient.instance.get("/api/carts/pay",
          queryParameters: queryParams, cancelToken: token);

      // snackCtrl.close();

      if (response.data['data'] != null) {
        return PayResult.fromJson(response.data['data']);
      }
    } on DioError catch (_) {
      if(_.response != null) {
        print(_.response!.data);
      }
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
