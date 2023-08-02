import 'package:dio/dio.dart';
// import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';
import 'package:flutterbase/models/contents/bank.dart';

class ApiPayment extends ApiClient {
  Future<List<Bank>> paynetBanks() async {
    List<Bank> list = [];

    try {
      var response = await ApiClient.instance.get(
        "/api/payments/paynet-banks",
      );

      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(Bank.fromJson(item));
        }
      }
    } on DioError catch (_) {
    } catch (_) {
      xdd(_);
    }

    return list;
  }

  Future<List<PaymentGateway>> gateways() async {
    List<PaymentGateway> list = [];

    try {
      var response = await ApiClient.instance.get(
        "/api/payments/gateways",
      );

      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(PaymentGateway.fromJson(item));
        }
      }
    } on DioError catch (_) {
    } catch (_) {
      xdd(_);
    }

    return list;
  }
}
