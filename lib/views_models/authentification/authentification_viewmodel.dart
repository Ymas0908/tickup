

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tickup/models/Request/update_password_request.dart';
import 'package:tickup/models/Request/update_user_password_forget_request.dart';
import 'package:tickup/models/Request/usager_request.dart';
import 'package:tickup/models/auth_data.dart';
import 'package:tickup/models/user_connected.dart';
import 'package:tickup/ressources/utils/log_config.dart';
import 'package:tickup/web_services/implementations/authentification/auth_service_impl.dart';
import 'package:tickup/web_services/services/merchant_services.dart';

class AuthentificationViewmodel extends ChangeNotifier {
  final AuthServiceImpl authService;
  final UsagerService usagerService;

  AuthentificationViewmodel({
    required this.authService,
    required this.usagerService,
  });

  // Controllers pour s'inscrire
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController telephoneController = TextEditingController();


  // Controllers pour login
  TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Controllers pour mot de passe (1ere connexion)
  final TextEditingController pwdRecuController = TextEditingController();
  final TextEditingController nouveauPwdController = TextEditingController();
  final TextEditingController confirmerPwdController = TextEditingController();

  // Controllers pour renitialisation mot de passe
  final TextEditingController adresseEmailController = TextEditingController();
  bool isLoading = false;
  String? errorMessage;
  bool isAuthenticated = false;
  UserConnected? userConnected;

  Future<AuthData?> seConnecter() async {
    final login = loginController.text.trim();
    final pwd = passwordController.text.trim();

    if (login.isEmpty || pwd.isEmpty) {
      errorMessage = "Veuillez remplir tous les champs.";
      notifyListeners();
      return null;
    }

    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final AuthData? authData = await authService.login(login, pwd);

      // Stocker le token et le refUsager (clé uniforme)
      await const FlutterSecureStorage().write(
        key: 'auth_token',
        value: authData?.accessToken,
      );
      await const FlutterSecureStorage().write(
        key: 'auth_refUsager',
        value: authData?.refUsager,
      );
      passwordController.clear();

      // Récupérer les infos du marchand après login
      await getUserMarchand();
      customLogger.i(
        "Connexion réussie pour l'utilisateur: ${userConnected?.prenom ?? ''} ${userConnected?.nom ?? ''}",      );

      return authData;
    } catch (e) {
      customLogger.e("Erreur lors de la connexion : ${e.toString()}");
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<UsagerRequest?> seInscrire() async {
    try {
      final usagerRequest = UsagerRequest(
        prenom: prenomController.text.trim(),
        nom: nomController.text.trim(),
        email: adresseEmailController.text.trim(),
        telephone: telephoneController.text.trim(),
        dateNaissance: adresseEmailController.text.trim(),
      );
      final response = await usagerService.saveUsager(usagerRequest);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getUserMarchand() async {
    try {
      final String? refUsager = await const FlutterSecureStorage().read(
        key: 'auth_refUsager',
      );
      if (refUsager == null) return;
      userConnected = await authService.usagerConnected(refUsager);
      notifyListeners();
    } catch (e) {
      customLogger.e("Erreur lors de la récupération du marchand: $e");
    }
  }

  Future<void> updatePassword() async {
    try {
      UpdatePasswordRequest updatePasswordRequest = UpdatePasswordRequest(
        login: loginController.text.trim(),
        oldPassword: passwordController.text.trim(),
        newPassword: nouveauPwdController.text.trim(),
        confirmNewPassword: confirmerPwdController.text.trim(),
      );
      await authService.updatePassword(updatePasswordRequest);
      loginController.clear();
      passwordController.clear();
      nouveauPwdController.clear();
      confirmerPwdController.clear();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword() async {
    try {
      UpdateUserPasswordForgetRequest updateUserPasswordForgetRequest =
      UpdateUserPasswordForgetRequest(
        login: adresseEmailController.text.trim(),
        newPassword: nouveauPwdController.text.trim(),
        confirmNewPassword: confirmerPwdController.text.trim(),
      );
      await authService.resetPassword(updateUserPasswordForgetRequest);
      loginController.clear();
      adresseEmailController.clear();
      passwordController.clear();
      nouveauPwdController.clear();
      confirmerPwdController.clear();
    } catch (e) {
      rethrow;
    }
  }

  void resetForm() {
    loginController.clear();
    passwordController.clear();
    nouveauPwdController.clear();
    confirmerPwdController.clear();
    adresseEmailController.clear();
    errorMessage = null;
    notifyListeners();
  }

  void logout() async {
    await const FlutterSecureStorage().deleteAll();
    isAuthenticated = false;
    notifyListeners();
  }

  void resetToken() async {
    await const FlutterSecureStorage().delete(key: 'auth_token');
    await const FlutterSecureStorage().delete(key: 'auth_refUsager');
    userConnected = null;
    notifyListeners();
  }
}
