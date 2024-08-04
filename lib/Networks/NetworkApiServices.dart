import 'dart:convert';

import 'package:http/http.dart';
import 'package:new_project/Networks/BaseApiServices.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;

    final response =
        await http.get(Uri.parse(url)).timeout( const Duration(seconds: 10));

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    Response response =
        await post(Uri.parse(url), body: data).timeout( const Duration(seconds: 10));

    responseJson = returnResponse(response);
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
    }
  }
}
