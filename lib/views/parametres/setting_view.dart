import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/utils/langue_provider.dart';
import 'package:tickup/views/assistance/assistance_view.dart';
import '../../main.dart';
import '../../utils/theme_provider.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final List<String> _langues = ['Français', 'English'];

  String _getLanguageLabel(Locale locale) {
    switch (locale.languageCode) {
      case 'fr':
        return 'Français';
      case 'en':
        return 'English';
      default:
        return 'Français';
    }
  }

  Future<void> _initAppInfo() async {
    await appInfoService.init();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langueProvider = Provider.of<LanguageProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final isFrench = langueProvider.locale.languageCode == 'fr';
    final textTheme = Theme.of(context).textTheme;

    final cardColor = isDarkMode ? const Color(0xFF1E1E1E) : AppColors.fourthBlue;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? AppColors.black : null,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: isDarkMode ? Colors.white : Colors.black87,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isFrench ? "Paramètres" : "Settings",
          style: textTheme.titleMedium?.copyWith(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: isDarkMode ? AppColors.black : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ======================
              // SECTION : PRÉFÉRENCES
              // ======================
              Text(
                isFrench ? 'Préférences' : 'Preferences',
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // LANGUE
                    ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.language,
                          color: AppColors.primaryBlue,
                          size: 22,
                        ),
                      ),
                      title: Text(
                        isFrench ? 'Langue' : 'Language',
                        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        _getLanguageLabel(langueProvider.locale),
                        style: textTheme.bodyMedium?.copyWith(
                          color: isDarkMode ? Colors.grey[400] : textTheme.bodyMedium?.color,
                        ),
                      ),
                      children: _langues.map((lang) {
                        final isSelected = _getLanguageLabel(langueProvider.locale) == lang;
                        return SwitchListTile(
                          title: Text(lang, style: textTheme.bodyLarge),
                          value: isSelected,
                          activeColor: AppColors.primaryBlue,
                          onChanged: (value) {
                            if (value) langueProvider.changeLanguage(lang);
                          },
                        );
                      }).toList(),
                    ),
                    Divider(height: 1, indent: 56, color: isDarkMode ? Colors.grey[800] : null),

                    // MODE SOMBRE
                    SwitchListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      activeColor: AppColors.primaryBlue,
                      secondary: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          isDarkMode ? Icons.dark_mode : Icons.dark_mode_outlined,
                          color: AppColors.primaryBlue,
                          size: 22,
                        ),
                      ),
                      title: Text(
                        isFrench ? 'Mode sombre' : 'Dark mode',
                        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        isDarkMode
                            ? (isFrench ? 'Désactiver le thème sombre' : 'Disable dark theme')
                            : (isFrench ? 'Activer le thème sombre' : 'Enable dark theme'),
                        style: textTheme.bodyMedium?.copyWith(
                          color: isDarkMode ? Colors.grey[400] : textTheme.bodyMedium?.color,
                        ),
                      ),
                      value: isDarkMode,
                      onChanged: (value) => themeProvider.toggleTheme(value),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ======================
              // SECTION : SUPPORT
              // ======================
              Text(
                isFrench ? 'Support & Informations' : 'Support & Information',
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                elevation: 0,
                color: cardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    // CENTRE D'AIDE
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.help_outline, color: AppColors.primaryBlue, size: 22),
                      ),
                      title: Text(
                        isFrench ? 'Centre d\'aide' : 'Help Center',
                        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        isFrench ? 'FAQ et assistance' : 'FAQ and support',
                        style: textTheme.bodyMedium?.copyWith(
                          color: isDarkMode ? Colors.grey[400] : textTheme.bodyMedium?.color,
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right, color: isDarkMode ? Colors.grey[400] : null),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AssistanceView()),
                      ),
                    ),
                    Divider(height: 1, indent: 56, color: isDarkMode ? Colors.grey[800] : null),

                    // CONDITIONS D'UTILISATION
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.description_outlined, color: AppColors.primaryBlue, size: 22),
                      ),
                      title: Text(
                        isFrench ? 'Conditions d\'utilisation' : 'Terms of use',
                        style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        isFrench ? 'Lire les conditions' : 'Read terms',
                        style: textTheme.bodyMedium?.copyWith(
                          color: isDarkMode ? Colors.grey[400] : textTheme.bodyMedium?.color,
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right, color: isDarkMode ? Colors.grey[400] : null),
                    ),
                    Divider(height: 1, indent: 56, color: isDarkMode ? Colors.grey[800] : null),

                    // À PROPOS
                    // FutureBuilder(
                    //   future: _initAppInfo(),
                    //   builder: (context, snapshot) {
                    //     final isDone = snapshot.connectionState == ConnectionState.done;
                    //     final version = isDone ? appInfoService.version : '...';
                    //     final build = isDone ? appInfoService.build : '...';
                    //
                    //     return Column(
                    //       children: [
                    //         ListTile(
                    //           contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    //           leading: Container(
                    //             padding: const EdgeInsets.all(8),
                    //             decoration: BoxDecoration(
                    //               color: AppColors.primaryBlue.withOpacity(0.1),
                    //               borderRadius: BorderRadius.circular(10),
                    //             ),
                    //             child: Icon(Icons.info_outline, color: AppColors.primaryBlue, size: 22),
                    //           ),
                    //           title: Text(
                    //             isFrench ? 'À propos' : 'About',
                    //             style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                    //           ),
                    //           subtitle: Text(
                    //             "version $version build($build)",
                    //             style: textTheme.bodyMedium?.copyWith(
                    //               color: isDarkMode ? Colors.grey[400] : textTheme.bodyMedium?.color,
                    //             ),
                    //           ),
                    //           trailing: Icon(Icons.chevron_right, color: isDarkMode ? Colors.grey[400] : null),
                    //         ),
                    //       ],
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}