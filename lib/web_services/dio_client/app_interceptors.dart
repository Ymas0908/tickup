import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Importation de Firebase Auth

// Dépendances supposées de votre projet (à adapter)
// import 'package:FusionSuperApp/utils/const.dart';
// import 'package:tickup/ressources/utils/base_url.dart';

class AppInterceptors extends Interceptor {
  final Dio dio;
  final GlobalKey<NavigatorState> navigatorKey;
  final FlutterSecureStorage storage; // Peut être conservé pour d'autres données
  final Logger _logger = Logger();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Instance de Firebase Auth

  AppInterceptors(this.dio, this.navigatorKey, this.storage);

  // Variable pour gérer les requêtes concurrentes de rafraîchissement
  bool _isRefreshing = false;

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    try {
      // 1. Utiliser le token ID actuel de Firebase si l'utilisateur est connecté
      final User? user = _auth.currentUser;
      if (user != null) {
        // NOTE: getIdToken() retourne le token actuel. Firebase s'occupe de le rafraîchir
        // en arrière-plan si nécessaire (si non expiré ou proche de l'expiration).
        final String? token = await user.getIdToken();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      } else {
        // Si pas d'utilisateur connecté, ne rien ajouter et laisser passer
      }
    } catch (e) {
      _logger.e("Erreur lors de la récupération du token Firebase : $e");
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Si 401 (Unauthorized), nous supposons que le token ID a expiré
    // et que la requête de rafraîchissement automatique de Firebase a échoué
    // ou que le token ID n'a pas été rafraîchi par l'appel getIdToken précédent.
    // Dans le cas de Firebase, le 401 signifie souvent que le Refresh Token est aussi invalide,
    // ou que l'utilisateur n'est plus valide sur votre backend personnalisé.

    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;
      _logger.w("Erreur 401 détectée. Tentative de rafraîchissement du token Firebase.");

      try {
        // Tente de forcer l'obtention d'un nouveau token ID
        final newToken = await _refreshToken();

        if (newToken != null) {
          _logger.i("Nouveau token Firebase obtenu. Rejoue la requête.");

          // Rejouer la requête qui a échoué
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';

          // Utilisez 'dio.fetch' pour relancer la requête avec les mêmes options
          final cloneReq = await dio.fetch(options);
          handler.resolve(cloneReq);
        } else {
          // Si le refresh échoue (utilisateur déconnecté ou session expirée)
          _logger.e("Échec du rafraîchissement du token. Redirection vers la connexion.");
          _redirectToLogin();
          handler.reject(err);
        }
      } catch (e) {
        // Gérer toute exception survenue pendant le refresh ou le rejeu
        _logger.e("Exception lors du rafraîchissement/rejeu : $e");
        _redirectToLogin();
        handler.reject(err);
      } finally {
        _isRefreshing = false;
      }
      return;
    }

    // Pour toutes les autres erreurs ou si _isRefreshing est true (pour éviter la boucle)
    super.onError(err, handler);
  }

  /// Méthode de rafraîchissement du token utilisant Firebase Auth
  Future<String?> _refreshToken() async {
    final User? user = _auth.currentUser;

    if (user == null) {
      // Pas d'utilisateur connecté, impossible de rafraîchir
      return null;
    }

    try {
      // Force le rafraîchissement: passe 'true' pour s'assurer que le SDK
      // contacte les serveurs Firebase pour obtenir un nouveau token ID
      final String? newToken = await user.getIdToken(true);
      return newToken;
    } catch (e) {
      _logger.e("Erreur lors du refresh token Firebase: $e");
      // Si une erreur se produit (ex: refresh token expiré), Firebase peut
      // déconnecter l'utilisateur. Il faut gérer cela en déconnectant l'utilisateur localement.
      await _auth.signOut();
      return null;
    }
  }

  /// Redirige l’utilisateur vers la page de login
  void _redirectToLogin() {
    // S'assurer que Firebase déconnecte l'utilisateur si ce n'est pas déjà fait
    _auth.signOut();

    // Redirection
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      '/connexion', // J'utilise '/connexion' car c'est la route définie dans main.dart
          (route) => false,
    );
  }
}