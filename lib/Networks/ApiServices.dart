import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:new_project/Networks/BaseApiServices.dart';

class ApiServices extends ApiBaseModel {
  static final ApiServices instance = ApiServices._();
  factory ApiServices() => instance;
  ApiServices._() {
    dio = Dio();
    dio.interceptors.add(DioTokenInterceptor(dio));
    dio.interceptors.add(
        CurlLoggerDioInterceptor(printOnSuccess: true, convertFormData: true));
  }
}