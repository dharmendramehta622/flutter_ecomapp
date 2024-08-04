import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:new_project/Networks/StorageServices.dart';
import 'package:new_project/Networks/logger_service.dart';

import '../resources/app_url.dart';

abstract class BaseApiServices {

  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url, dynamic data);
}


class ApiResponse {
  bool status = false;
  dio.Response? msg;
  Map<String, dynamic>? extra;

  ApiResponse({required this.status, this.msg, this.extra});

  @override
  String toString() => 'Status: $status, Msg: $msg, Extra:$extra';

  ApiResponse copyWith({
    bool? status,
    dio.Response? msg,
    Map<String, dynamic>? extra,
  }) {
    return ApiResponse(
      status: status ?? this.status,
      msg: msg ?? this.msg,
      extra: extra ?? this.extra,
    );
  }
}

abstract class ApiBaseModel {
  late Dio dio;

  _errorLogger(Map<String, dynamic>? variables, error) {
    String errorString = '''
    Variables: $variables
    Error: ${error!.error}
    Error Message: ${error.message}
    Status Code: ${error.response?.statusCode}
    Status Message: ${error.response?.statusMessage}
    ''';
    LoggerService.instance.errorLogger(errorString);
  }

  _successLogger(Map<String, dynamic>? variables, response) {
    String errorString = '''
    Variables: $variables
    Status Code: ${response!.statusCode}
    Status Message: ${response.statusMessage}
    Response Data: ${response.data}
    ''';
    LoggerService.instance.infoLogger(errorString);
  }

  Future<ApiResponse> get(
      {required String url, Map<String, dynamic>? variables}) async {
    try {
      final response =
          await dio.get('${ApiConstant.httpBase + ApiConstant.apiBaseUrl}$url');
      _successLogger(
        variables,
        response,
      );
      return ApiResponse(status: true, msg: response);
    } on DioError catch (error) {
      _errorLogger(
        variables,
        error,
      );
      return ApiResponse(status: false, msg: error.response);
    }
  }

  Future<ApiResponse> post(
      {required String url,
      FormData? formData,
      required Map<String, dynamic> variables}) async {
    try {
      final response = await dio.post(
          '${ApiConstant.httpBase + ApiConstant.apiBaseUrl}$url',
          options: ApiConstant.options,
          data: formData ?? json.encode(variables));
      _successLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        response,
      );
      return ApiResponse(status: true, msg: response);
    } on DioError catch (error) {
      _errorLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        error,
      );
      return ApiResponse(status: false, msg: error.response);
    }
  }

  Future<ApiResponse> patch(
      {required String url,
      FormData? formData,
      Map<String, dynamic>? variables}) async {
    try {
      final response = await dio.patch(
        '${ApiConstant.httpBase + ApiConstant.apiBaseUrl}$url',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: formData ?? json.encode(variables),
      );
      _successLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        response,
      );
      return ApiResponse(status: true, msg: response);
    } on DioError catch (error) {
      _errorLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        error,
      );
      return ApiResponse(status: false, msg: error.response);
    }
  }

  Future<ApiResponse> put(
      {required String url,
      FormData? formData,
      required Map<String, dynamic> variables}) async {
    try {
      final response = await dio.put(
        '${ApiConstant.httpBase + ApiConstant.apiBaseUrl}$url',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: formData ?? json.encode(variables),
      );
      _successLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        response,
      );
      return ApiResponse(status: true, msg: response);
    } on DioError catch (error) {
      _errorLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        error,
      );
      return ApiResponse(status: false, msg: error.response);
    }
  }

  Future<ApiResponse> delete(
      {required String url, Map<String, dynamic>? variables}) async {
    try {
      final response = await dio.delete(
        '${ApiConstant.httpBase + ApiConstant.apiBaseUrl}$url',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: json.encode(variables),
      );
      _successLogger(
        variables,
        response,
      );
      return ApiResponse(status: true, msg: response);
    } on DioError catch (error) {
      _errorLogger(
        variables,
        error,
      );
      return ApiResponse(status: false, msg: error.response);
    }
  }
}

abstract class NodeBaseModel {
  late Dio dio;
  late String baseUrl;

  _errorLogger(Map<String, dynamic>? variables, DioError? error) {
    String errorString = '''
    Variables: $variables
    Error: ${error!.error}
    Error Message: ${error.message}
    Status Code: ${error.response?.statusCode}
    Status Message: ${error.response?.statusMessage}
    ''';
    LoggerService.instance.errorLogger(errorString);
  }

  _successLogger(Map<String, dynamic>? variables, response) {
    String errorString = '''
    Variables: $variables
    Status Code: ${response!.statusCode}
    Status Message: ${response.statusMessage}
    Response Data: ${response.data}
    ''';
    LoggerService.instance.infoLogger(errorString);
  }

  Future<ApiResponse> get(
      {required String url, Map<String, dynamic>? variables}) async {
    try {
      final response = await dio.get('$baseUrl$url');
      _successLogger(
        variables,
        response,
      );
      return ApiResponse(status: true, msg: response);
    } on DioError catch (error) {
      _errorLogger(
        variables,
        error,
      );
      return ApiResponse(status: false, msg: error.response);
    }
  }

  Future<ApiResponse> post(
      {required String url,
      FormData? formData,
      required Map<String, dynamic> variables}) async {
    try {
      final response = await dio.post('$baseUrl$url',
          options: ApiConstant.options,
          data: formData ?? json.encode(variables));
      _successLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        response,
      );
      return ApiResponse(status: true, msg: response);
    } on DioError catch (error) {
      _errorLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        error,
      );
      return ApiResponse(status: false, msg: error.response);
    }
  }

  Future<ApiResponse> patch(
      {required String url,
      FormData? formData,
      Map<String, dynamic>? variables}) async {
    try {
      final response = await dio.patch(
        '$baseUrl$url',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: formData ?? json.encode(variables),
      );
      _successLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        response,
      );
      return ApiResponse(status: true, msg: response);
    } on DioError catch (error) {
      _errorLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        error,
      );
      return ApiResponse(status: false, msg: error.response);
    }
  }

  Future<ApiResponse> put(
      {required String url,
      FormData? formData,
      required Map<String, dynamic> variables}) async {
    try {
      final response = await dio.put(
        '$baseUrl$url',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: formData ?? json.encode(variables),
      );
      _successLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        response,
      );
      return ApiResponse(status: true, msg: response);
    } on DioError catch (error) {
      _errorLogger(
        formData != null
            ? {
                "FormData Fields": formData.fields,
                "FormData Files": formData.files
              }
            : variables,
        error,
      );
      return ApiResponse(status: false, msg: error.response);
    }
  }

  Future<ApiResponse> delete(
      {required String url, Map<String, dynamic>? variables}) async {
    try {
      final response = await dio.delete(
        '$baseUrl$url',
        options: Options(contentType: Headers.formUrlEncodedContentType),
        data: json.encode(variables),
      );
      _successLogger(
        variables,
        response,
      );
      return ApiResponse(status: true, msg: response);
    } on DioError catch (error) {
      _errorLogger(
        variables,
        error,
      );
      return ApiResponse(status: false, msg: error.response);
    }
  }
}

class DioTokenInterceptor extends Interceptor {
  DioTokenInterceptor(Dio dio) {
    _dio = dio;
  }
  late Dio _dio;
  _infoLogger(RequestOptions options) {
    LoggerService.instance.infoLogger('''
    URL: ${options.path}
    METHOD: ${options.method}
    VALIDATE STATUS: ${options.validateStatus}

    Headers: ${options.headers}
    Follow Redirects: ${options.followRedirects}
    Extra: ${options.extra}
    List Format: ${options.listFormat}

    Query Parameters: ${options.queryParameters}
    ''');
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll(await _getHeaders());
    _infoLogger(options);
    return super.onRequest(options, handler);
  }


  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async { 
    return super.onError(error, handler);
  }

  Future<Map<String, String>> _getHeaders() async {
    final accessToken = await LocalStorageService.instance
        .get(LocalStorageServiceItems.userToken);
    Map<String, String> headers = {};
    if (accessToken != null) {
      headers['Authorization'] = 'Bearer $accessToken';
    }
    return headers;
  }

 
}
 