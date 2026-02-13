import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();

    // ⏱️ Après 3 secondes, on redirige vers la page d’onboarding
    // Timer(const Duration(seconds: 3), () {
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
    //      return OnBoardingView();
    //   },));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fond blanc
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo du shop (sac souriant)
            Image.asset(
              'assets/images/myshop_logo.png',
              width: 192,
              height: 163,
            ),
            Text(
              'TickUp',
              style: TextStyle(
                fontSize: 24, // Taille du texte
                fontWeight: FontWeight.bold, // Gras (optionnel)
                color: Colors.black, // Couleur (optionnel)
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
