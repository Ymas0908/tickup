

import 'package:tickup/models/Request/refresh_token_request.dart';
import 'package:tickup/models/Request/update_password_request.dart';
import 'package:tickup/models/Request/update_user_password_forget_request.dart';
import 'package:tickup/models/auth_data.dart';
import 'package:tickup/models/user_connected.dart';

abstract class AuthService {
  Future<AuthData?> login(String login, String password);
  Future<UserConnected> usagerConnected(String refUsager);

  Future<void> updatePassword(UpdatePasswordRequest updatePasswordRequest);

  Future<void> resetPassword(UpdateUserPasswordForgetRequest updateUserPasswordForgeRequest,);

  Future<AuthData> refreshToken(RefreshTokenRequest refreshTokenRequest);
}
