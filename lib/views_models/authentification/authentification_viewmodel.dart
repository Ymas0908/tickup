import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tickup/ressources/utils/log_config.dart';
import 'package:tickup/web_services/services/auth_service.dart';


class AuthViewModel extends ChangeNotifier {
  final AuthService authService;

  User? get user => FirebaseAuth.instance.currentUser;

  AuthViewModel({required this.authService});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  bool isLoading = false;



  /***
   * Methode pour s'inscrire
   */
  // Future<void> signup({required String email, required String password, required String nom, required BuildContext context,}) async {
  //   try {
  //     await authService.signup(email: email, password: password, context: context, nom: nom);
  //     print("Inscription..."+ "Utilisateur inscrit "+  FirebaseAuth.instance.currentUser!.email.toString());
  //     emailController.clear();
  //     passwordController.clear();
  //   } on Exception catch (e) {
  //     // Gérer les erreurs d'inscription
  //     print("Une erreur s'est produite: $e");
  //     print(e);    }
  //   setLoading(false);
  // }
  Future<bool> inscription({required String email, required String password,}) async {
    try {
      UserCredential credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        await credential.user!.sendEmailVerification();
        // customLogger.i("📩 Email de vérification envoyé");
      }

      // customLogger.i(" Réponse Firebase reçue");
      // customLogger.i("User UID : ${credential.user?.uid}");
      // customLogger.i("Email vérifié ? : ${credential.user?.emailVerified}");
      // customLogger.i("Email vérifié ? : ${credential.user?.emailVerified}");
      // customLogger.i("Provider : ${credential.credential?.providerId}");
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code);
      return false;
    }
  }
  Future<bool> seConnecter(String email, String password) async {

    customLogger.i("📤 Tentative de connexion : $email");

    try {

      UserCredential credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      resetConnextionForm();

      customLogger.i(" Connexion réussie");
      customLogger.i("UID : ${credential.user?.uid}");
      customLogger.i("Email vérifié ? : ${credential.user?.emailVerified}");

      /// Vérification email confirmé
      if (credential.user != null &&
          !credential.user!.emailVerified) {

        customLogger.w(" Email non vérifié");
        return false;
      }

      return true;

    } on FirebaseAuthException catch (e, stackTrace) {

      customLogger.e(" FirebaseAuthException");
      customLogger.e("Code : ${e.code}");
      customLogger.e("Message : ${e.message}");
      customLogger.e("StackTrace : $stackTrace");

      return false;

    } catch (e, stackTrace) {

      customLogger.e(" Erreur inconnue");
      customLogger.e("Erreur : $e");
      customLogger.e("StackTrace : $stackTrace");

      return false;
    }
  }
  void resetConnextionForm() {
    emailController.clear();
    passwordController.clear();
  }



  /***
   * Methode pour se connecter
   */
  // Future<void> signin({required String email, required String password, required BuildContext context,}) async {
  //   try {
  //     await authService.signin(email: email, password: password, context: context,);
  //     emailController.clear();
  //     passwordController.clear();
  //   } on Exception catch (e) {
  //     print("Une erreur s'est produite: $e");
  //     print(e);
  //   }
  //   setLoading(false);
  // }





  /***
   * Methode pour se deconnecter
   */
  // Future<void> signout(BuildContext context) async {setLoading(true);
  //   try {
  //     print("Deconnexion."+ "Utilisateu  déconnecté");
  //     await authService.signout(context: context);
  //     emailController.clear();
  //     passwordController.clear();
  //   } on Exception catch (e) {
  //     print("Une erreur s'est produite: $e");
  //     print(e);
  //   }
  //   setLoading(false);
  // }



  /***
   * Methode pour réinitialiser le mot de passe par email
   */
  // Future<void> resetPassword({required String email, required BuildContext context,}) async {setLoading(true);
  //
  //   try {
  //     print("Mot de passe rénitiliasé. Email envoyé à l'adresse" + email);
  //     await authService.resetPassword(email: email, context: context,);
  //   } on Exception catch (e) {
  //     print("Une erreur s'est produite: $e");
  //     print(e);
  //   }
  //   setLoading(false);
  // }


}
