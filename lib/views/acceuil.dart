// dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/utils/theme_provider.dart';
import 'package:tickup/views/acccueil/home.dart';
import 'package:tickup/views/profil_view.dart';
import 'package:tickup/views/tickets_view.dart';
import 'package:tickup/views_models/authentification/authentification_viewmodel.dart';

class AcceuilView extends StatefulWidget {
  const AcceuilView({super.key});

  @override
  State<AcceuilView> createState() => _AcceuilViewState();
}

class _AcceuilViewState extends State<AcceuilView> {
  int _currentIndex = 0;

  @override
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authViewModel = Provider.of<AuthentificationViewmodel>(context, listen: false);

      // //  Récupérer les infos d'authentification stockées
      // final AuthData? authData = await authViewModel.seConnecter();
      // if (authData?.isFisrtConnection == true) {
      //   _showGarderLeControleBottomSheet();
      //   return;
      // }

    });
  }

  // void _showGarderLeControleBottomSheet() {
  //   showResponsiveBottomSheet(context, MessageAcceuil());
  // }

  // Les différentes pages correspondant à chaque onglet
  final List<Widget> _pages = [
    const Home(),
    const TicketsView(),
    // const ClientsView(),
    // const CompteView(),
    // const InstrumentsPaimentView(),
    const ProfilView(),
    // const TransactionsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: _pages[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Onglet Accueil
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 0),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _currentIndex == 0
                        ? AppColors.primaryBlue.withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color: _currentIndex == 0
                            ? AppColors.primaryBlue
                            : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade500),
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Accueil",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _currentIndex == 0
                              ? AppColors.primaryBlue
                              : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
                          fontWeight: _currentIndex == 0 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Onglet Paramètres
              GestureDetector(
                onTap: () => setState(() => _currentIndex = 1),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _currentIndex == 1
                        ? AppColors.primaryBlue.withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.settings,
                        color: _currentIndex == 1
                            ? AppColors.primaryBlue
                            : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade500),
                        size: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Paramètres",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _currentIndex == 1
                              ? AppColors.primaryBlue
                              : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
                          fontWeight: _currentIndex == 1 ? FontWeight.w600 : FontWeight.normal,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Les autres onglets sont commentés mais si vous les décommentez,
              // ils devront aussi être adaptés au mode sombre
            ],
          ),
        ),
      ),
    );
  }
}