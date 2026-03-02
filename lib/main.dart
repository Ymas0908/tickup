
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickup/ressources/const/app_theme.dart';
import 'package:tickup/utils/app_route_name.dart';
import 'package:tickup/utils/generator_route.dart';
import 'package:tickup/utils/theme_provider.dart';
import 'package:tickup/views/acccueil/home.dart';
import 'package:tickup/views/authentification/connexion_view.dart';
import 'package:tickup/views/on_boarding.dart';
import 'package:tickup/views_models/authentification/authentification_viewmodel.dart';
import 'package:tickup/views_models/evenements/evenement_viewmodel.dart';
import 'package:tickup/views_models/paiements/paiement_view_model.dart';
import 'package:tickup/views_models/session_manager_view_model.dart';
import 'package:tickup/web_services/implementations/authentification/auth_service_impl.dart';
import 'package:tickup/web_services/implementations/authentification/usager_impl.dart';
import 'package:tickup/web_services/implementations/evenement_impl.dart';
import 'package:tickup/web_services/implementations/paiement_impl.dart';
import 'package:tickup/web_services/services/auth_service.dart';
import 'package:tickup/web_services/services/local_auth_service.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('fr');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider<LocalAuthService>(create: (_) => LocalAuthService()),
        ChangeNotifierProvider(create: (_) => SessionManagerViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthentificationViewmodel(authService: AuthServiceImpl(), usagerService: UsagerImpl()),
        ),
        ChangeNotifierProvider(
          create: (_) => EvenementViewModel(evenementService: EvenementImpl()),
        ),
        ChangeNotifierProvider(
          create: (_) => PaiementViewModel(paiementService: PaiementImpl()),
        ),
        // Ajoutez d'autres ViewModels ici si nécessaire (ex: AuthViewModel())
      ],
      child: MaterialApp(
        theme: AppTheme.defaultTheme,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: GeneratorRoute.onGenerate,
        initialRoute: AppRouteName.initialRoute,
        // Redirige vers la page d'accueil si connecté, sinon vers la page de connexion
      ),
    );
  }
}

