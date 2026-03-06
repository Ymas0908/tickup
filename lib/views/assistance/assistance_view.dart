import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/utils/langue_provider.dart';
import '../../utils/theme_provider.dart';

class AssistanceView extends StatefulWidget {
  const AssistanceView({super.key});

  @override
  State<AssistanceView> createState() => _AssistanceViewState();
}

class _AssistanceViewState extends State<AssistanceView> {
  // Liste FAQ avec traduction
  List<Map<String, dynamic>> _getFaqItems(bool isFrench) {
    return [
      {
        'question': isFrench ? 'Comment activer mon compte marchand ?' : 'How to activate my merchant account?',
        'reponse': isFrench
            ? 'Rendez-vous dans Profil > Activation compte. Pièce d\'identité et RCCM requis.'
            : 'Go to Profile > Account Activation. ID and business registration required.',
      },
      {
        'question': isFrench ? 'Quels sont les frais de transaction ?' : 'What are the transaction fees?',
        'reponse': isFrench
            ? '1.5% par carte bancaire, 1% par mobile money.'
            : '1.5% per card, 1% per mobile money transaction.',
      },
      {
        'question': isFrench ? 'Comment recevoir un paiement ?' : 'How to receive a payment?',
        'reponse': isFrench
            ? 'Scannez le QR code client ou saisissez son numéro dans "Recevoir".'
            : 'Scan the client QR code or enter their number in "Receive".',
      },
      {
        'question': isFrench ? 'Délai de remboursement ?' : 'Refund time?',
        'reponse': isFrench
            ? '24 à 48h ouvrés selon la banque.'
            : '24 to 48 business hours depending on the bank.',
      },
      {
        'question': isFrench ? 'Configurer mon terminal ?' : 'How to set up my terminal?',
        'reponse': isFrench
            ? 'Connectez au WiFi, allumez, suivez les instructions. Code d\'activation par SMS.'
            : 'Connect to WiFi, turn on, follow instructions. Activation code by SMS.',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final langueProvider = Provider.of<LanguageProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final isFrench = langueProvider.locale.languageCode == 'fr';
    final textTheme = Theme.of(context).textTheme;
    final faqItems = _getFaqItems(isFrench);

    return Scaffold(
      backgroundColor: isDarkMode ?  AppColors.black : Colors.white,
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
          isFrench ? "Assistance" : "Support",
          style: textTheme.titleMedium?.copyWith(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Bannière d'assistance
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF1E1E1E) : AppColors.secondaryBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.headset_mic_outlined,
                      color: AppColors.primaryBlue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isFrench ? "Besoin d'aide ?" : "Need help ?",
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : null,
                          ),
                        ),
                        Text(
                          isFrench
                              ? "Contactez notre support 24/7 pour toute assistance."
                              : "Contact our 24/7 support for any assistance.",
                          style: textTheme.bodySmall?.copyWith(
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Titre FAQ
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  isFrench ? "Foire aux questions" : "Frequently Asked Questions",
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : null,
                  ),
                ),
              ],
            ),
          ),

          // Liste FAQ
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: faqItems.length,
              separatorBuilder: (_, index) => Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Divider(
                  height: 1,
                  color: index < faqItems.length - 1
                      ? (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200)
                      : Colors.transparent,
                ),
              ),
              itemBuilder: (context, index) {
                final faq = faqItems[index];
                return Theme(
                  data: Theme.of(context).copyWith(
                    dividerColor: Colors.transparent,
                    expansionTileTheme: ExpansionTileThemeData(
                      iconColor: AppColors.primaryBlue,
                      collapsedIconColor: isDarkMode ? Colors.grey.shade400 : Colors.grey,
                      textColor: isDarkMode ? Colors.white : null,
                      collapsedTextColor: isDarkMode ? Colors.white : null,
                    ),
                  ),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    childrenPadding: const EdgeInsets.only(bottom: 12),
                    title: Text(
                      faq['question'],
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isDarkMode ? Colors.white : Colors.black87,
                      ),
                    ),
                    children: [
                      Text(
                        faq['reponse'],
                        style: textTheme.bodyMedium?.copyWith(
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action d'appel
        },
        backgroundColor: AppColors.primaryBlue,
        child: const Icon(Icons.call, color: Colors.white),
      ),
    );
  }
}