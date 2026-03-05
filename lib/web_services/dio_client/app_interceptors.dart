import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:tickup/ressources/utils/base_url.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;
  final GlobalKey<NavigatorState> navigatorKey;
  final FlutterSecureStorage storage;
  final Logger _logger = Logger();

  AppInterceptors(this.dio, this.navigatorKey, this.storage);

  bool _isRefreshing = false;

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    try {
      //  Récupérer le token JWT depuis le stockage sécurisé
      String? token = await storage.read(key: 'auth_token');

      if (token != null && token.isNotEmpty && !options.path.contains("/auth/users/login")) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      _logger.e("Erreur lors de la récupération du token : $e");
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Si 401 (token expiré), essayer de rafraîchir le token
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      try {
        final newToken = await _refreshToken();

        if (newToken != null) {
          // Stocker le nouveau token
          await storage.write(key: 'auth_token', value: newToken);

          // Rejouer la requête qui a échoué
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';

          final cloneReq = await dio.fetch(options);
          handler.resolve(cloneReq);
        } else {
          _redirectToLogin();
          handler.reject(err);
        }
      } catch (e) {
        _redirectToLogin();
        handler.reject(err);
      } finally {
        _isRefreshing = false;
      }
      return;
    }

    super.onError(err, handler);
  }

  ///  Méthode pour rafraîchir le token
  Future<String?> _refreshToken() async {
    try {
      // ️  récupérer login/mdp depuis stockage sécurisé
      final login = await storage.read(key: 'login');
      final password = await storage.read(key: 'password');

      if (login == null || password == null) return null;

      final response = await dio.post(
        baseUrlbackend + '/auth/users/login',
        data: {'login': login, 'password': password},
      );

      if (response.statusCode == 200) {
        final newToken = response.data['accessToken'];
        // Stocker le nouveau token
        await storage.write(key: 'auth_token', value: newToken);
        return newToken;
      }

      return null;
    } catch (e) {
      print("Erreur lors du refresh token : $e");
      return null;
    }
  }

  /// Redirige l’utilisateur vers la page de login
  void _redirectToLogin() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/login',
          (route) => false,
    );
  }
}
