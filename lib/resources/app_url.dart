import 'package:dio/dio.dart' as dio;

class AppUrl {
  static var baseUrl = 'https://fakestoreapi.com';
  static var loginUrl = '$baseUrl/user/login/';
  static var registerUrl = '$baseUrl/user/register/';
}


class ApiConstant{
    static const httpBase = 'https://';
    static const apiBaseUrl = 'fakestoreapi.com';
    static const apiBase = '/api/app';
    static const String baseUrl = 'https://fakestoreapi.com';
    static const googleAPIKey = 'your_api_key';

    static dio.Options options = dio.Options(headers: <String, String>{
    dio.Headers.contentTypeHeader: dio.Headers.jsonContentType,
  });
}


