import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tickup/composants/input.dart';
import 'package:tickup/composants/primary_button.dart';
import 'package:tickup/composants/showLoadingSession.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views/acccueil/home.dart';
import 'package:tickup/views/acceuil.dart';
import 'package:tickup/views_models/authentification/authentification_viewmodel.dart';

class ConnexionView extends StatefulWidget {
  const ConnexionView({Key? key}) : super(key: key);

  @override
  State<ConnexionView> createState() => _ConnexionViewState();
}

class _ConnexionViewState extends State<ConnexionView> {
  bool _obscureText = true;

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }






  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fourthBlue,
      body: Consumer<AuthViewModel>(
        builder: (context, authVm, child) {
          return Center(
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
                          return 'Veuillez entrer votre email';
                        }
                        final emailRegex =
                        RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Veuillez entrer un email valide';
                        }
                        return null;
                      },
                      controller: authVm.emailController,
                      labelText: "Email",
                      hintext: "exemple@email.com",
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
          );
        },
      ),

      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: PrimaryButton(
            title: "Se connecter",
            onPressed: () {
              final authVm =
              Provider.of<AuthViewModel>(context, listen: false);

              final login = authVm.emailController.text.trim();
              final password =
              authVm.passwordController.text.trim();

              if (login.isEmpty || password.isEmpty) {
                HapticFeedback.vibrate();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                    Text("Veuillez remplir tous les champs"),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }

              showLoadingSession(context);

              authVm.signin(
                email: login,
                password: password,
                context: context,
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Acceuil(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
