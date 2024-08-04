import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';

class AppUrl {
  static var baseUrl = 'https://api.hamrokk.com';
  static var loginUrl = '$baseUrl/user/login/';
  static var registerUrl = '$baseUrl/user/register/';
}


class ApiConstant{
    static const httpBase = 'https://';
    static const apiBaseUrl = 'api.hamrokk.com';
    static const apiBase = '/api/app';
    static const String baseUrl = 'https://hamrokk.com';
    static const googleAPIKey = 'AIzaSyABwaq9dIoPMYwXnuu9mKOl3NgkBERj4eo';

    static dio.Options options = dio.Options(headers: <String, String>{
    dio.Headers.contentTypeHeader: dio.Headers.jsonContentType,
  });
}


