import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorageService {
  static const storage = FlutterSecureStorage();

  static const authTokenKey = 'auth_token';
  static const refreshTokenKey = 'refresh_token';

  Future<void> saveAuthData({
    required String? authToken,
    required String? refreshToken,
  }) async {
    if (authToken != null) {
      await storage.write(key: authTokenKey, value: authToken);
    }

    if (refreshToken != null) {
      await storage.write(key: refreshTokenKey, value: refreshToken);
    }


  }

  Future<String?> getAuthToken() => storage.read(key: authTokenKey);

  Future<String?> getRefreshToken() => storage.read(key: refreshTokenKey);


  Future<void> clearAuthData() async {
    await Future.wait([
      storage.delete(key: authTokenKey),
      storage.delete(key: refreshTokenKey),
    ]);
  }
}
