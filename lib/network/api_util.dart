import 'package:dio/dio.dart';

import '../common/app_config.dart';
import '../configs/app_constants.dart';
import 'api_interceptors.dart';
import 'app_api.dart';

class ApiUtil {
  late final Dio dio;
  late final AppApi apiClient;

  ApiUtil._privateConstructor() {
    dio = Dio();
    dio.options.connectTimeout = Duration(milliseconds: AppConstant.connectTimeout);
    dio.interceptors.add(ApiInterceptors());
    apiClient = AppApi(dio, baseUrl: AppConfig.baseUrl);
  }

  static final ApiUtil instance = ApiUtil._privateConstructor();
}
