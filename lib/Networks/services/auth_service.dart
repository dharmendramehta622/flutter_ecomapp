import 'package:new_project/Networks/BaseApiServices.dart';
import 'package:new_project/Networks/StorageServices.dart';
import 'package:new_project/Networks/models/login_model.dart';
import 'package:new_project/Networks/models/register_model.dart';

class AuthService {
  Future<bool> checkLoggedIn() async {
    // Retrieve stored email and password
    final email =
        await LocalStorageService.instance.get(LocalStorageServiceItems.email);
    final password = await LocalStorageService.instance
        .get(LocalStorageServiceItems.password);

    // Compare the provided credentials with the stored ones
    if (email != null && password != null) {
      // Credentials match, login successful
      return true;
    } else {
      // Credentials do not match, login failed
      return false;
    }
  }

  Future<ApiResponse> loginWithEmail(LoginModel model) async {
    // Retrieve stored email and password
    final email =
        await LocalStorageService.instance.get(LocalStorageServiceItems.email);
    final password = await LocalStorageService.instance
        .get(LocalStorageServiceItems.password);

    // Compare the provided credentials with the stored ones
    if (email == model.email && password == model.password) {
      // Credentials match, login successful
      return ApiResponse(status: true, msg: null);
    } else {
      // Credentials do not match, login failed
      return ApiResponse(status: false, msg: null);
    }
  }

  Future<void> logout() async {
    await LocalStorageService.instance
        .delete(LocalStorageServiceItems.userToken);
    await LocalStorageService.instance.delete(LocalStorageServiceItems.email);
    await LocalStorageService.instance
        .delete(LocalStorageServiceItems.password);
    await LocalStorageService.instance.delete(LocalStorageServiceItems.userID);
  }

  Future<ApiResponse> registerWithEmailPassword(
      {required RegisterModel model}) async {
    try {
      await LocalStorageService.instance
          .set(key: LocalStorageServiceItems.email, value: model.email);
      await LocalStorageService.instance
          .set(key: LocalStorageServiceItems.password, value: model.password);
      return ApiResponse(status: true, msg: null);
    } catch (e) {
      return ApiResponse(status: false, msg: null);
    }
  }
}
