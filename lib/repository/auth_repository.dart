import 'package:new_project/Networks/BaseApiServices.dart';
import 'package:new_project/Networks/NetworkApiServices.dart';
import 'package:new_project/resources/app_url.dart';

class AuthRepository {
  
  final BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    dynamic response =
        await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);

    return response;
  }

  Future<dynamic> registerApi(dynamic data) async {
    dynamic response =
        await _apiServices.getPostApiResponse(AppUrl.registerUrl, data);

    return response;
  }
  
}
