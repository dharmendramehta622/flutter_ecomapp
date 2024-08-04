import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:new_project/Networks/ApiServices.dart';
import 'package:new_project/Networks/BaseApiServices.dart';
import 'package:new_project/Networks/StorageServices.dart';
import 'package:new_project/Networks/models/login_model.dart';
import 'package:new_project/Networks/models/register_model.dart';
import 'package:new_project/Networks/models/session_info.dart';

class AuthService {
  final String _registerUrl = '/user/register/';
  final String _loginUrl = '/user/login/';
  final String _deleteAccountUrl = '/customer/delete-account';
  late SessionInfo _sessionInfo;
  Map<String, dynamic>? _userData;

  Future<dynamic> getProfileId() async {
    final token = await LocalStorageService.instance
        .get(LocalStorageServiceItems.userToken);
    if (token != null) {
      final data = JwtDecoder.decode(token);
      return data["user_id"];
    }
  }

  Future<ApiResponse> loginWithEmail(LoginModel model) async {
    final response = await ApiServices.instance
        .post(url: _loginUrl, variables: model.toMap());
    if (response.status) {
      if (model.remember) {
        final access = response.msg?.data['data']['access'];
        final refresh = response.msg?.data['data']['refresh'];

        await LocalStorageService()
            .set(key: LocalStorageServiceItems.userToken, value: access);
        await LocalStorageService()
            .set(key: LocalStorageServiceItems.refreshToken, value: refresh);
      }
    }
    return response;
  }

  Future<void> logout() async {
    await LocalStorageService.instance
        .delete(LocalStorageServiceItems.userToken);
    await LocalStorageService.instance
        .delete(LocalStorageServiceItems.refreshToken);
    await LocalStorageService.instance.delete(LocalStorageServiceItems.userID);
  }

  Future<ApiResponse> registerWithEmailPassword(
      {required RegisterModel model}) async {
    final response = await ApiServices.instance
        .post(url: _registerUrl, variables: model.toMap());
    // try {
    bool success = (response.status &&
        response.msg?.data['signup']['access'] != null &&
        response.msg?.data['signup']['refresh'] != null &&
        response.msg?.data['signup']['message'] != "Email already exists.");

    if (success) {
      final access = response.msg?.data?.data['signup']['access'];
      final refresh = response.msg?.data['signup']['refresh'];
      await LocalStorageService.instance
          .set(key: LocalStorageServiceItems.userToken, value: access);
      await LocalStorageService.instance
          .set(key: LocalStorageServiceItems.refreshToken, value: refresh);
      return response;
    } else {
      return ApiResponse(status: false, msg: response.msg?.data);
    }
  }
}
