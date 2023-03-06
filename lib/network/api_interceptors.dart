import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../common/app_enums.dart';
import '../main.dart';
import '../utils/app_flush_bar.dart';

class ApiInterceptors extends InterceptorsWrapper {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // final method = options.method;
    // final uri = options.uri;
    // final data = options.data;

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;
    final data = jsonEncode(response.data);
    logger.d("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data");
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;
    // final uri = err.requestOptions.uri;
    // final RequestOptions request = err.requestOptions;

    logger.d("⚠️ ERROR[$statusCode] => PATH: $path");

    switch (statusCode) {
      case 401:
        return super.onError(err, handler);
      case 404:
        AppFlushBar.showFlushBar(
          navigatorKey.currentContext!,
          type: FlushType.error,
          message: 'A system error has occurred, please try again later!',
        );
        return super.onError(err, handler);
      default:
        return super.onError(err, handler);
    }
  }
}