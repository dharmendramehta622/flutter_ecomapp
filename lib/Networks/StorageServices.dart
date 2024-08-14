
import 'package:shared_preferences/shared_preferences.dart';

enum LocalStorageServiceItems {
  userID,
  userToken,
  email,
  password,
  refreshToken,
  logo,
  currentLocation,
  favouriteItems,
}

extension LocalStorageServiceItemsConfig on LocalStorageServiceItems {
  String get value {
    switch (this) {
      case LocalStorageServiceItems.userToken:
        return 'user-token';
      case LocalStorageServiceItems.refreshToken:
        return 'refresh';
      case LocalStorageServiceItems.email:
        return 'email';
      case LocalStorageServiceItems.password:
        return 'password';
      case LocalStorageServiceItems.userID:
        return 'user-id';
      case LocalStorageServiceItems.logo:
        return 'logo';
      case LocalStorageServiceItems.favouriteItems:
        return 'favourite-items';
      case LocalStorageServiceItems.currentLocation:
        return 'current-location';
    }
  }
}

class LocalStorageService {
  static final LocalStorageService instance = LocalStorageService._();
  factory LocalStorageService() => instance;
  LocalStorageService._();

  Future<SharedPreferences> get _getInstance async =>
      await SharedPreferences.getInstance();

  Future<bool> set(
      {required LocalStorageServiceItems key, required String value}) async {
    SharedPreferences storage = await _getInstance;
    await storage.setString(key.value, value);
    return true;
  }


  Future<bool> delete(LocalStorageServiceItems key) async {
    SharedPreferences storage = await _getInstance;
    return await storage.remove(key.value);
  }

  Future<String?> get(LocalStorageServiceItems key) async {
    SharedPreferences storage = await _getInstance;
    return storage.getString(key.value);
  }

    Future<bool> setDynamic(
      {required String key, required String value}) async {
    SharedPreferences storage = await _getInstance;
    await storage.setString(key, value);
    return true;
  }

  Future<String?> getDynamic(String key) async {
    SharedPreferences storage = await _getInstance;
    return storage.getString(key);
  }
}
