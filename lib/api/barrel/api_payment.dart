import 'package:dio/dio.dart';
// import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/bills/bills.dart';

class ApiPayment extends ApiClient {
  Future<List<Bank>> paynetBanks() async {
    List<Bank> list = [];

    try {
      var response = await ApiClient.instance.get(
        "/api/payments/paynet-banks",
      );

      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          if(item['redirectUrls'] != null) {
            for(var url in response.data['data']['redirectUrls']) {
              if(url['type'] != null && url['url'] != null)
              list.add(Bank.fromJson(url['type'], url['url'], item));
            }
          }
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
