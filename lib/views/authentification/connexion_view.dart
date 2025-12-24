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
            onPressed: () {
              final authVm = Provider.of<AuthViewModel>(context, listen: false);

              final login = authVm.emailController.text.trim();
              final password = authVm.passwordController.text.trim();
              //
              if (login.isEmpty || password.isEmpty) {
                HapticFeedback.vibrate();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Veuillez remplir tous les champs",
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              }
              //
              // // Afficher le loader personnalisé
              showLoadingSession(context);
              authVm.signin(email: authVm.emailController.text.trim(), password: authVm.passwordController.text.trim(), context: context,);

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
