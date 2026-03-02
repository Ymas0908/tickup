import 'package:flutter/material.dart';
import 'package:tickup/composants/primary_button.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views/authentification/Inscription_view.dart';
import 'package:tickup/views/authentification/connexion_view.dart';
import 'package:tickup/views/authentification/connexion_view2.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fourthBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              /// =========================
              /// SECTION HAUTE (Logo + Texte)
              /// =========================
              Column(
                children: [
                  const SizedBox(height: 60),

                  /// LOGO (à remplacer par ton asset)
                  Icon(
                    Icons.account_balance_wallet_rounded,
                    size: 100,
                    color: AppColors.primaryBlue,
                  ),

                  const SizedBox(height: 40),

                  Text(
                    "Bienvenue sur TickUp",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    "Gérez vos paiements, suivez vos transactions et profitez d'une expérience sécurisée.",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

              /// =========================
              /// SECTION BASSE (Boutons)
              /// =========================
              Column(
                children: [

                  /// BOUTON CONNEXION
                  PrimaryButton(
                    title: "Se connecter",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const ConnexionView(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 15),

                  /// BOUTON INSCRIPTION
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 55),
                      side: BorderSide(
                        color: AppColors.primaryBlue,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InscriptionView(),
                        ),
                      );
                    },
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
