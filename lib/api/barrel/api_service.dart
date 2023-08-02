import 'package:dio/dio.dart';
import 'package:flutterbase/api/barrel/barrel.dart';
import 'package:flutterbase/helpers.dart';
import 'package:flutterbase/models/models.dart';

class ApiService extends ApiClient {
  Future<List<CartMatrix>> getMatrix(String serviceRefNo) async {
    if (serviceRefNo.isEmpty) {
      return Future.error(Exception('serviceRefNo is empty'));
    }

    List<CartMatrix> list = [];

    try {
      var response = await ApiClient.instance.get(
        "/api/services/$serviceRefNo",
        queryParameters: {'only_matrix': 1},
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
