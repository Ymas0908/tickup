import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tickup/ressources/utils/log_config.dart';
import 'package:tickup/views/acccueil/home.dart';
import 'package:tickup/views/authentification/connexion_view.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// ===============================
  /// 🔹 Récupérer utilisateur connecté
  /// ===============================
  User? get currentUser => _auth.currentUser;

  /// ===============================
  /// 🔹 Inscription
  /// ===============================
  Future<bool?> seInscrire({required String email, required String password, required BuildContext context,}) async {
    try {
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        await credential.user!.sendEmailVerification();
        customLogger.i("📩 Email de vérification envoyé");
      }

      customLogger.i(" Réponse Firebase reçue");
      customLogger.i("User UID : ${credential.user?.uid}");
      customLogger.i("Email vérifié ? : ${credential.user?.emailVerified}");
      customLogger.i("Email vérifié ? : ${credential.user?.emailVerified}");
      customLogger.i("Provider : ${credential.credential?.providerId}");
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return false;
    }
  }

  /// ===============================
  /// 🔹 Connexion
  /// ===============================
  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  /// ===============================
  /// 🔹 Déconnexion
  /// ===============================
  Future<void> signout({required BuildContext context}) async {
    await _auth.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const ConnexionView()),
    );
  }

  /// ===============================
  /// 🔹 Reset Password
  /// ===============================
  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showToast("Email de réinitialisation envoyé.");
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  /// ===============================
  /// 🔹 Vérifier email
  /// ===============================
  Future<void> sendEmailVerification() async {
    try {
      await currentUser?.sendEmailVerification();
      _showToast("Email de vérification envoyé.");
    } catch (e) {
      _showToast("Erreur lors de l'envoi de l'email.");
    }
  }

  /// ===============================
  /// 🔹 Mettre à jour le nom
  /// ===============================
  Future<void> updateDisplayName(String name) async {
    try {
      await currentUser?.updateDisplayName(name);
      await currentUser?.reload();
      _showToast("Nom mis à jour.");
    } catch (e) {
      _showToast("Erreur mise à jour nom.");
    }
  }

  /// ===============================
  /// 🔹 Mettre à jour email
  /// ===============================
  Future<void> updateEmail(String newEmail) async {
    try {
      await currentUser?.verifyBeforeUpdateEmail(newEmail);
      _showToast("Email mis à jour.");
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  /// ===============================
  /// 🔹 Mettre à jour mot de passe
  /// ===============================
  Future<void> updatePassword(String newPassword) async {
    try {
      await currentUser?.updatePassword(newPassword);
      _showToast("Mot de passe mis à jour.");
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    }
  }

  /// ===============================
  /// 🔹 Supprimer compte
  /// ===============================
  Future<void> deleteAccount(BuildContext context) async {
    try {
      await currentUser?.delete();
      _showToast("Compte supprimé.");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ConnexionView()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        _showToast("Reconnectez-vous pour supprimer le compte.");
      } else {
        _handleAuthError(e);
      }
    }
  }

  /// ===============================
  /// 🔹 Reload utilisateur
  /// ===============================
  Future<void> reloadUser() async {
    await currentUser?.reload();
  }

  /// ===============================
  /// 🔹 Gestion centralisée erreurs
  /// ===============================
  void _handleAuthError(FirebaseAuthException e) {
    String message;

    switch (e.code) {
      case 'weak-password':
        message = "Mot de passe trop faible.";
        break;
      case 'email-already-in-use':
        message = "Email déjà utilisé.";
        break;
      case 'user-not-found':
        message = "Utilisateur non trouvé.";
        break;
      case 'wrong-password':
        message = "Mot de passe incorrect.";
        break;
      case 'invalid-email':
        message = "Email invalide.";
        break;
      default:
        message = "Erreur : ${e.message}";
    }

    _showToast(message);
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      backgroundColor: Colors.black54,
      textColor: Colors.white,
      fontSize: 14.0,
    );
  }
}
