import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickup/composants/input.dart';
import 'package:tickup/composants/primary_button.dart';
import 'package:tickup/composants/showLoadingSession.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views/authentification/connexion_view.dart';
import 'package:tickup/views/authentification/connexion_view2.dart';
import 'package:tickup/views_models/authentification/authentification_viewmodel.dart';
import '../../utils/app_utils.dart';
import '../../utils/theme_provider.dart';

class MiseAJourPasswordView extends StatefulWidget {
  const MiseAJourPasswordView({super.key});

  @override
  State<MiseAJourPasswordView> createState() => _MiseAJourPasswordViewState();
}

class _MiseAJourPasswordViewState extends State<MiseAJourPasswordView> {
  final formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final textTheme = Theme.of(context).textTheme;
    final authViewModel = Provider.of<AuthentificationViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ?  AppColors.black : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Mise à jour du mot de passe",
          style: textTheme.titleMedium?.copyWith(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),

                // Mot de passe actuel
                InputText(
                  controller: authViewModel.passwordController,
                  obscureText: _obscureText,
                  labelText: "Mot de passe actuel",
                  hintext: "Saisissez votre mot de passe actuel",
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: _togglePasswordView,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre mot de passe actuel';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Nouveau mot de passe
                InputText(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre mot de passe';
                    }
                    return validatePassword(value);
                  },
                  labelText: "Nouveau mot de passe",
                  hintext: "Saisissez votre nouveau mot de passe",
                  obscureText: _obscureText,
                  controller: authViewModel.nouveauPwdController,
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
                const SizedBox(height: 10),
                InputText(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez confirmer votre mot de passe';
                    }

                    if (value != authViewModel.nouveauPwdController.text) {
                      return 'Mot de passe non conforme.';
                    }
                    return validatePassword(value);
                  },
                  labelText: "Mot de passe de confirmation",
                  hintext: "Confirmez votre nouveau mot de passe",
                  obscureText: _obscureText,
                  controller: authViewModel.confirmerPwdController,
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
                const SizedBox(height: 30),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: PrimaryButton(
            title: "Valider",
            onPressed: () async {
              if (!formKey.currentState!.validate()) return;

              try {
                // Afficher loader
                showLoadingSession(context);


                // Appeler la fonction de changement de mot de passe
                await authViewModel.updatePassword();

                // Fermer le loader
                if (Navigator.canPop(context)) Navigator.pop(context);

                // Rediriger vers la page de connexion
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ConnexionView(),
                  ),
                      (route) => false,
                );
              } catch (e) {
                if (Navigator.canPop(context)) Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
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