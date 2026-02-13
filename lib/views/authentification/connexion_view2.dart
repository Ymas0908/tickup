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
            onPressed: () async {
              final viewModel = Provider.of<AuthViewModel>(
                context,
                listen: false,
              );

              final email = viewModel.emailController.text.trim();
              final password = viewModel.passwordController.text.trim();

              if (viewModel.emailController.text.isEmpty || viewModel.passwordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Veuillez remplir tous les champs obligatoires"),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              if (!viewModel.emailRegex.hasMatch(email)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Adresse email invalide"),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              showLoadingSession(context);

              try {
                await viewModel.seConnecter(email, password);

                Navigator.pop(context);

                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Acceuil(),
                  ),
                );
              } catch (e) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Une erreur est survenue lors de l'enrôlement."),
                    backgroundColor: Colors.red,
                  ),
                );
                debugPrint("Erreur lors de le connexion : $e");
              }
            },
          ),
        ),
      ),
    );
  }
}
