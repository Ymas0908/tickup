import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tickup/composants/input.dart';
import 'package:tickup/composants/primary_button.dart';
import 'package:tickup/composants/showLoadingSession.dart';
import 'package:tickup/exception/app_exception.dart';
import 'package:tickup/models/auth_data.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views/acccueil/home.dart';
import 'package:tickup/views/acceuil.dart';
import 'package:tickup/views/authentification/mise_a_jour_password_view.dart';
import 'package:tickup/views_models/authentification/authentification_viewmodel.dart';
import 'package:tickup/views_models/session_manager_view_model.dart';

class ConnexionView2 extends StatefulWidget {
  const ConnexionView2({Key? key}) : super(key: key);

  @override
  State<ConnexionView2> createState() => _ConnexionView2State();
}

class _ConnexionView2State extends State<ConnexionView2> {
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }






  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.fourthBlue,
        title: const Text("Se connecter"),
      ),
      backgroundColor: AppColors.fourthBlue,
      body: Consumer<AuthentificationViewmodel>(
        builder: (context, authVm, child) {
          return Form(
            key : formKey,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // Titre principal
                      Text(
                        "Se connecter",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: AppColors.primaryBlue,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Sous texte
                      Text(
                        "Entrez vos informations pour accéder à votre compte",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Email
                      InputText(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre login';
                          }

                        },
                        controller: authVm.loginController,
                        labelText: "Login",
                        hintext: "Saisissez votre login",
                        obscureText: false,
                      ),

                      const SizedBox(height: 20),

                      // Mot de passe
                      InputText(
                        controller: authVm.passwordController,
                        labelText: "Mot de passe",
                        hintext: "Saisissez votre mot de passe",
                        obscureText: _obscureText,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: _togglePasswordView,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Mot de passe oublié
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Mot de passe oublié ?',
                            style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 13,
                              color: AppColors.primaryBlue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: PrimaryButton(
            title: "Se connecter",
            onPressed: () async {
              final authViewModel = Provider.of<AuthentificationViewmodel>(context, listen: false);
              final sessionManagerViewModel = Provider.of<SessionManagerViewModel>(context, listen: false);
              if (authViewModel.loginController.text.trim().isEmpty || authViewModel.passwordController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Le login et le mot de passe sont requis"),
                    backgroundColor: Colors.red,
                  ),
                );
                return;              }
              if (!formKey.currentState!.validate()) return;

              try {
                //  Afficher loader
                showLoadingSession(context);

                final AuthData? authData = await authViewModel.seConnecter();

                if (!mounted) return;
                Navigator.of(context, rootNavigator: true).pop();
                if (authData == null) return;

                //  Première connexion → rediriger vers changement de mot de passe
                if (authData.isFisrtConnection == true) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MiseAJourPasswordView(
                        // login: authViewModel.loginController.text,
                        // refMarchand: authData.refMarchent, // si nécessaire pour la mise à jour
                      ),
                    ),
                  );
                  return; // ne pas continuer vers l'accueil
                }

                //  Connexion normale
                sessionManagerViewModel.authenticated();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Home(),
                  ),
                );
              } on AppException catch (e) {
                if (mounted && Navigator.canPop(context)) {
                  Navigator.pop(context);
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.message),
                    backgroundColor: Colors.red,
                  ),
                );
              } catch (e) {
                if (mounted && Navigator.canPop(context)) {
                  Navigator.pop(context);
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Une erreur est survenue"),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
