import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views/authentification/connexion_view2.dart';
import 'package:tickup/views/parametres/setting_view.dart';
import 'package:tickup/views/profil_view.dart';
import 'package:tickup/views/tickets_view.dart';
import 'package:tickup/views_models/authentification/authentification_viewmodel.dart';
import '../../utils/langue_provider.dart';
import '../../utils/theme_provider.dart';
import '../authentification/connexion_view.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langueProvider = Provider.of<LanguageProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final isFrench = langueProvider.locale.languageCode == 'fr';

    return Scaffold(
      backgroundColor: isDarkMode ? AppColors.black : AppColors.white,
      body: Consumer<AuthentificationViewmodel>(
        builder: (context, authVm, child) {
          return SafeArea(
            child: Column(
              children: [
                // HEADER FIXE
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: AppColors.primaryBlue,
                        child: Text(
                          getUserInitials(
                            "${authVm.userConnected?.nom ?? ""} ${authVm.userConnected?.prenom ?? ""}",
                          ),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${authVm.userConnected?.nom ?? ""} ${authVm.userConnected?.prenom ?? ""}",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),

                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ConnexionView2(),
                            ),
                            (route) => false,
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: AppColors.primaryBlue.withOpacity(
                            0.1,
                          ),
                          child: const Icon(Icons.logout, color: AppColors.red),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // CONTENU SCROLLABLE
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // Mon profil
                        Card(
                          elevation: 0,
                          color: isDarkMode
                              ? AppColors.black
                              : AppColors.fourthBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  isFrench ? "Mon profil" : "My profile",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                ),
                                subtitle: Text(
                                  isFrench
                                      ? "Gérez vos informations"
                                      : "Manage your info",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                ),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const ProfilView(),
                                    ),
                                  );
                                },
                              ),
                              const Divider(height: 1),
                              ListTile(
                                title: Text(
                                  isFrench ? "Paramètres" : "Settings",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                ),
                                subtitle: Text(
                                  isFrench
                                      ? "Gérez vos préférences"
                                      : "Manage your preferences",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                ),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SettingView(),
                                    ),
                                  );
                                },
                              ),
                              const Divider(height: 1),
                              ListTile(
                                title: Text(
                                  isFrench ? "Mes tickets" : "My tickets",
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                ),
                                subtitle: Text(
                                  isFrench
                                      ? "Consultez vos tickets"
                                      : "View your tickets",
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: isDarkMode
                                            ? AppColors.white
                                            : AppColors.black,
                                      ),
                                ),
                                trailing: const Icon(Icons.chevron_right),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const TicketsView(),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        // Mes tickets
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

String getUserInitials(String? userConnectedName) {
  if (userConnectedName == null || userConnectedName.isEmpty) return "";

  // Découper le nom par les espaces
  final words = userConnectedName.split(' ');

  // Prendre la première lettre de chaque mot
  final initials = words
      .map((word) => word.isNotEmpty ? word[0].toUpperCase() : '')
      .join();

  // Si tu veux seulement les deux premières lettres (deux premiers mots)
  return initials.length > 2 ? initials.substring(0, 2) : initials;
}
