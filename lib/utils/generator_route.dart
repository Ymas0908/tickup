import 'package:tickup/views/on_boarding.dart';
import 'package:tickup/views/splash_screen_view.dart';
import 'package:flutter/material.dart';


import 'app_route_name.dart';

class GeneratorRoute {
  static Route? onGenerate(RouteSettings settings) {
    final route = settings.name;

    switch (route) {
      case AppRouteName.initialRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreenView(),
        );



      case AppRouteName.onboarding:
        return MaterialPageRoute(
          builder: (context) => const OnboardingView(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('Page not found'),
            ),
          ),
        );
    }
  }
}
