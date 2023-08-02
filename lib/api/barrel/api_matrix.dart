import 'package:dio/dio.dart';
// import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/models.dart';

class ApiMatrix extends ApiClient {
  Future<List<CartMatrix>> getService(int serviceId) async {
    if (serviceId == 0) {
      return Future.error(Exception('serviceId is invalid'));
    }

    List<CartMatrix> list = [];

    try {
      var response = await ApiClient.instance.get(
        "/api/matrix/service/$serviceId",
      );

      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(CartMatrix.fromJson(item));
        }
      }
    } on DioError catch (_) {
    } catch (_) {
      xdd(_);
    }

    return list;
  }
}
