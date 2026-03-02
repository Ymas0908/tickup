
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tickup/models/Request/refresh_token_request.dart';
import 'package:tickup/models/Request/update_password_request.dart';
import 'package:tickup/models/Request/update_user_password_forget_request.dart';
import 'package:tickup/models/auth_data.dart';
import 'package:tickup/models/user_connected.dart';
import 'package:tickup/ressources/utils/base_url.dart';
import 'package:tickup/ressources/utils/log_config.dart';
import 'package:tickup/utils/device_infos.dart';
import 'package:tickup/web_services/dio_client/api_error_handler.dart';
import 'package:tickup/web_services/dio_client/dio_client.dart';
import 'package:tickup/web_services/services/auth_service.dart';

class AuthServiceImpl implements AuthService {
  final dioClient = DioClient();

  @override
  Future<AuthData?> login(String login, String password) async {
    final body = {'login': login, 'password': password};
    try {
      Map<String, dynamic> headers = {
        'Content-Type': 'application/json',
        'X-Terminal-Id': deviceData['id'],
        'X-Terminal-Model': deviceData['model'],
        'X-Terminal-Marque': deviceData['brand'],
      };
      customLogger.f("header  ${headers}");
      final response = await dioClient.dio.post(
        '/auth/users/login',
        data: body,
        options: Options(headers: headers),
      );
      return AuthData.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserConnected> usagerConnected(String refUsager) async {
    try {
      final token = await const FlutterSecureStorage().read(key: 'auth_token');

      final response = await dioClient.dio.get(
        "/auth/users/userconnected",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      final body = response.data;
      return UserConnected.fromJson(body);
    } on DioException catch (error) {
      throw ApiErrorHandler.handle(error);
    }
  }

  @override
  Future<void> updatePassword(UpdatePasswordRequest updatePasswordRequest) async {
    final body = updatePasswordRequest.toJson();
    try {
      await dioClient.dio.post('/auth/users/update-password', data: body);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> resetPassword(UpdateUserPasswordForgetRequest updateUserPasswordForgeRequest) async {
    customLogger.f("resetPassword  ${updateUserPasswordForgeRequest.toJson()}");
    try {
      await dioClient.dio.post(
        '/auth/users/update-password-forget',
        data: updateUserPasswordForgeRequest.toJson(),
      );
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthData> refreshToken(RefreshTokenRequest refreshTokenRequest) async {
    try {
      final response = await dioClient.dio.post(
        '/auth/refresh',
        data: refreshTokenRequest.toJson(),
      );
      return AuthData.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    } catch (e) {
      rethrow;
    }
  }
}
