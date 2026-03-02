import 'package:flutter/material.dart';
import 'package:tickup/composants/primary_button.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views/authentification/connexion_view2.dart';
import 'package:tickup/views/authentification/inscription_view.dart';
import 'package:tickup/views/authentification/connexion_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final List<Map<String, dynamic>> features = [
    {
      'icon': Icons.security_rounded,
      'title': 'Sécurisé',
      'description': 'Paiements 100% sécurisés',
      'color': Colors.blue,
    },
    {
      'icon': Icons.flash_on_rounded,
      'title': 'Rapide',
      'description': 'Achat instantané de tickets',
      'color': Colors.amber,
    },
    {
      'icon': Icons.people_rounded,
      'title': 'Communauté',
      'description': 'Rejoignez des milliers d\'utilisateurs',
      'color': Colors.green,
    },
    {
      'icon': Icons.qr_code_scanner_rounded,
      'title': 'QR Code',
      'description': 'Scan facile et rapide des tickets',
      'color': Colors.purple,
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..forward();

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.4, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.5, curve: Curves.easeOutBack),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fourthBlue,
      body: SafeArea(
        child: Column(
          children: [
            /// =========================
            /// HEADER AVEC INDICATEUR
            /// =========================
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TickUp',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue,
                      letterSpacing: 1,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'v1.0.0',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 12,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// =========================
            /// CONTENU PRINCIPAL
            /// =========================
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      /// ILLUSTRATION PRINCIPALE
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primaryBlue.withOpacity(0.2),
                                AppColors.fourthBlue,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Cercle animé
                                TweenAnimationBuilder(
                                  tween: Tween<double>(begin: 0, end: 2 * 3.14),
                                  duration: const Duration(seconds: 3),
                                  curve: Curves.linear,
                                  builder: (context, double value, child) {
                                    return Transform.rotate(
                                      angle: value,
                                      child: Container(
                                        width: 160,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.primaryBlue.withOpacity(0.3),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                // Icône principale
                                Icon(
                                  Icons.confirmation_number_rounded,
                                  size: 100,
                                  color: AppColors.primaryBlue,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// TITRE ET DESCRIPTION
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            children: [
                              ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [AppColors.primaryBlue, Colors.blue.shade300],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(bounds),
                                child: Text(
                                  "Bienvenue sur TickUp",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                "La solution tout-en-un pour gérer vos événements et tickets en toute simplicité",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: AppColors.black.withOpacity(0.7),
                                  height: 1.5,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      /// GRILLE DES FONCTIONNALITÉS
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: features.length,
                        itemBuilder: (context, index) {
                          return TweenAnimationBuilder(
                            tween: Tween<double>(begin: 0, end: 1),
                            duration: Duration(milliseconds: 600 + (index * 100)),
                            curve: Curves.easeOutCubic,
                            builder: (context, double value, child) {
                              return Opacity(
                                opacity: value,
                                child: Transform.translate(
                                  offset: Offset(0, 20 * (1 - value)),
                                  child: child,
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: features[index]['color'].withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Icon(
                                      features[index]['icon'],
                                      color: features[index]['color'],
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    features[index]['title'],
                                    style:  Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    features[index]['description'],
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      fontSize: 11,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// =========================
            /// BOUTONS D'ACTION
            /// =========================
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          title: "Connexion",
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const ConnexionView2()),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PrimaryButton(
                          title: "Inscription",
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const InscriptionView()),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}