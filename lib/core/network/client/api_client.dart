import 'package:memmatch/core/package_loader/load_modules.dart';
import 'package:memmatch/routes/route_provider.dart';
import 'package:dio/dio.dart';
import 'package:memmatch/core/network/constants/network_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static var dio = Dio(BaseOptions(
      baseUrl: NetworkConstants.baseUrl,
      connectTimeout: NetworkConstants.CONNECTION_TIMEOUT,
      receiveTimeout: NetworkConstants.READ_TIMEOUT,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      }))
    // ..interceptors.add(TokenInterceptor(AppRouter.navigatorKey))
    ..interceptors.add(PrettyDioLogger(
      requestHeader: false,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: false,
      compact: true,
      enabled: kDebugMode,
      filter: (options, args) {
        if (options.path.contains('api.ipify.org')) {
          return false;
        }
        if (options.path.contains("filtered-product")) {
          return false;
        }
        return true;
      },
    ));
}
