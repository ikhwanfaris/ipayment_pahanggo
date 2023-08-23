// import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

import 'package:flutterbase/api/api.dart';

class ApiClient {
  static Dio get instance {
    var client = api.client();

    // if (kDebugMode) {
    //   client.interceptors.add(
    //     CurlLoggerDioInterceptor(
    //       printOnSuccess: true,
    //     ),
    //   );
    // }

    return client;
  }
}
