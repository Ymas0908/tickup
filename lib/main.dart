
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickup/views/acccueil/home.dart';
import 'package:tickup/views/authentification/connexion_view.dart';
import 'package:tickup/views_models/evenements/evenement_viewmodel.dart';
import 'package:tickup/views_models/paiements/paiement_pro_view_model.dart';
import 'package:tickup/web_services/implementations/evenement_impl.dart';
import 'package:tickup/web_services/implementations/paiement_impl.dart';

import 'firebase_options.dart';
import 'ressources/utils/secure_storage.dart';

Future<void> main() async {
  await initializeSecureStorage();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  /**
   * Initialisation de Firebase Auth pour l'authentification
   *  ceci permet de vérifier si l'utilisateur est déjà connecté
   *  Si connecté, il sera redirigé vers la page d'accueil
   */
  User? user = FirebaseAuth.instance.currentUser;

  runApp(TickUpApp(isLoggedIn: user != null));
}
class TickUpApp extends StatelessWidget {
  final bool isLoggedIn;

  const TickUpApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Fournit EvenementsViewModel. Les données seront accessibles partout.
        ChangeNotifierProvider(
          create: (_) => EvenementViewModel(evenementService: EvenementImpl()),
        ),
        ChangeNotifierProvider(
          create: (_) => PaiementViewModel(paiementService: PaiementImpl()),
        ),
        // Ajoutez d'autres ViewModels ici si nécessaire (ex: AuthViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn
            ? Home()
            : ConnexionView(), // Redirige vers la page d'accueil si connecté, sinon vers la page de connexion
      ),    );  }
}

