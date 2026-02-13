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

class InscriptionView extends StatefulWidget {
  const InscriptionView({Key? key}) : super(key: key);

  @override
  State<InscriptionView> createState() => _InscriptionViewState();
}

class _InscriptionViewState extends State<InscriptionView> {
  bool _obscureText = true;

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }






  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.fourthBlue,
      body: Consumer<AuthViewModel>(builder: (context, authVm, child) {
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                // Image.asset(
                //   'assets/images/logo_horizontal_1.png',
                //   width: 171,
                //   height: 50,
                // ),

                const SizedBox(height: 50),

                // Texte juste en dessous
                Text(
                  "Se connecter",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),

                // Champ login
                InputText(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    }
                    // Expression régulière pour valider le format de l'email
                    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Veuillez entrer un email valide';
                    }
                    return null;
                  },
                  controller: authVm.emailController,
                  labelText: "email",
                  hintext: "Saisissez votre email",
                  obscureText: false,
                ),
                const SizedBox(height: 20),

                // Champ mot de passe
                InputText(
                  controller: authVm.passwordController,
                  labelText: "Mot de passe",
                  hintext: "Saisissez votre mot de passe",
                  obscureText: _obscureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: _togglePasswordView,
                  ),
                ),
                const SizedBox(height: 10),

                // Mot de passe oublié
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const MotDePasseOublieView(),
                        //   ),
                        // );
                      },
                      child: Text(
                        'Mot de passe oublié ?',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                // Bouton connexion

                // Option inscription
              ],
            ),
          ),
        );
      },),
      bottomNavigationBar:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                // await viewModel.seConnecter(email, password, context);

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
