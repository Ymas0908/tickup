import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tickup/ressources/utils/base_url.dart';

import 'app_interceptors.dart';

/// Client Dio centralisé pour toutes les requêtes API
class DioClient {
  late Dio dio;

  DioClient() {
    // Configuration de base de Dio
    dio = Dio(
      BaseOptions(
        baseUrl: "$baseUrl/api/v1",
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    // Ajout des interceptors pour gérer token + erreurs
    dio.interceptors.add(
      AppInterceptors(dio, navigatorKey, FlutterSecureStorage()),
    );
  }

  /// Optionnel : méthode pour récupérer le token depuis SecureStorage
  Future<String?> getToken() async {
    String? token;
    token = await FlutterSecureStorage().read(key: 'auth_token');
    return token;
    // String  token = "eyJhbGciOiJIUzUxMiJ9.eyJyb2xlcyI6W3siYXV0aG9yaXR5IjoiQURNSU4ifV0sInVzZXJuYW1lIjoiYWRtaW4iLCJzdWIiOiJhZG1pbiIsImlhdCI6MTc2MjI2NzExNSwiZXhwIjoxNzY0ODU5MTE1fQ.UPV1YoC3h24AlC642E0uU85r_P_5xyoSuFXuPC8IvsK8sO5Vqkx3DNcEZSp4o1x3OLSQgk-JTpTPSN7BDO8Byg";
    // return "eyJhbGciOiJIUzUxMiJ9.eyJyb2xlcyI6W3siYXV0aG9yaXR5IjoiQURNSU4ifV0sInVzZXJuYW1lIjoiYWRtaW4iLCJzdWIiOiJhZG1pbiIsImlhdCI6MTc2MjI2Nzk1MiwiZXhwIjoxNzY0ODU5OTUyfQ.x0322tXmx6NJMthqsqTCWVbsHcwHdZFu6crm6h2mEugHuYerJ3Ebqnkolx0g-1bw_VEaWf9gAy08PL4PDVwwBQ";
  }
}

// Clés globales pour la navigation et les snackbars
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();
