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

  final List<Widget> _pages = [
    const Home(),
    const TicketsView(),
    const ProfilView(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: Column(
        children: [
          /// PAGE
          Expanded(
            child: _pages[_currentIndex],
          ),

          /// BARRE DE NAVIGATION
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    index: 0,
                    icon: Icons.home_outlined,
                    label: "Accueil",
                    isDarkMode: isDarkMode,
                  ),
                  _buildNavItem(
                    index: 1,
                    icon: Icons.confirmation_number_outlined,
                    label: "Tickets",
                    isDarkMode: isDarkMode,
                  ),
                  _buildNavItem(
                    index: 2,
                    icon: Icons.person_outline,
                    label: "Profil",
                    isDarkMode: isDarkMode,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
    required bool isDarkMode,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: _currentIndex == index
                ? AppColors.primaryBlue
                : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade500),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight:
              _currentIndex == index ? FontWeight.w600 : FontWeight.normal,
              color: _currentIndex == index
                  ? AppColors.primaryBlue
                  : (isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600),
            ),
          ),
        ],
      ),
    );
  }
}