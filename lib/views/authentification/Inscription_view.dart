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
import 'package:tickup/views/authentification/connexion_view2.dart';
import 'package:tickup/views_models/authentification/authentification_viewmodel.dart';

class InscriptionView extends StatefulWidget {
  const InscriptionView({Key? key}) : super(key: key);

  @override
  State<InscriptionView> createState() => _InscriptionViewState();
}

class _InscriptionViewState extends State<InscriptionView> {
  bool _obscureText = true;
  final formKey = GlobalKey<FormState>();

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fourthBlue,
      body: Consumer<AuthentificationViewmodel>(
        builder: (context, authVm, child) {
          return Form(
            key: formKey,
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
                        "Inscription",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: AppColors.primaryBlue,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Sous texte
                      Text(
                        "Entrez vos informations pour créer votre compte",
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
                            return 'Veuillez entrer votre nom';
                          }
                        },
                        controller: authVm.nomController,
                        labelText: "Nom",
                        hintext: "Saisissez votre nom",
                        obscureText: false,
                      ),

                      const SizedBox(height: 20),

                      // Mot de passe
                      InputText(
                        controller: authVm.prenomController,
                        labelText: "Prénom",
                        hintext: "Saisissez votre prénom",
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),

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
                        controller: authVm.adresseEmailController,
                        labelText: "Email",
                        hintext: "Saisissez votre email",
                        obscureText: false,
                      ),
                      const SizedBox(height: 20),

                      InputText(
                        labelText: "N° de téléphone",
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,],
                        hintext: "Saisissez le numéro de téléphone",
                        controller: authVm.telephoneController,
                        prefixStyle: Theme.of(context).textTheme.bodyMedium
                            ?.copyWith(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
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
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
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
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButton(
            title: "S'inscrire",
            onPressed: () async {
              final viewModel = Provider.of<AuthentificationViewmodel>(
                context,
                listen: false,
              );

              if (viewModel.nomController.text.isEmpty ||
                  viewModel.prenomController.text.isEmpty ||
                  viewModel.telephoneController.text.isEmpty ||
                  viewModel.adresseEmailController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Veuillez remplir tous les champs obligatoires",
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              // if (!viewModel.emailRegex.hasMatch(email)) {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     const SnackBar(
              //       content: Text("Adresse email invalide"),
              //       backgroundColor: Colors.red,
              //     ),
              //   );
              //   return;
              // }

              showLoadingSession(context);

              try {
                await viewModel.seInscrire();

                Navigator.pop(context);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConnexionView2(
                        // login: authViewModel.loginController.text,
                        // refMarchand: authData.refMarchent, // si nécessaire pour la mise à jour
                      ),
                    ),
                  );
            } catch (e) {
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Une erreur est survenue lors de l'inscription.",
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                debugPrint("Erreur lors de l'inscription : $e");
              }
            },
          ),
        ),
      ),
    );
  }
}
