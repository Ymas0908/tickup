import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tickup/composants/card_evenement.dart';
import 'package:tickup/composants/search_evenements_component.dart';
import 'package:tickup/composants/showResponsiveBottomSheet.dart';
import 'package:tickup/models/enum/type_evenement.dart';
import 'package:tickup/models/evenement_model.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views/acccueil/detail_evenements.dart';
import 'package:tickup/views_models/evenements/evenement_viewmodel.dart';

import '../../utils/theme_provider.dart';
import '../profil_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<EvenementViewModel>(context, listen: false);
      viewModel.getEvents();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: const Color(0xfff6f6f8),
      drawer: const ProfilView(),
      body: SafeArea(
        child: Consumer<EvenementViewModel>(
          builder: (context, evenementVm, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER SIMPLE ET JOLI
                /// HEADER + BARRE DE RECHERCHE + FILTRES
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Titre principal
                      Text(
                        "Découvrez les événements",
                        style: GoogleFonts.montserrat(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Sous-texte descriptif
                      Text(
                        "Trouvez et réservez vos tickets en quelques clics",
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Barre de recherche
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Rechercher un événement...",
                            hintStyle: GoogleFonts.montserrat(
                              color: Colors.grey.shade500,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: AppColors.primaryBlue,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          onChanged: (value) {
                            evenementVm.updateSearchQueryEvenement(value);
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      // FILTRES EN LIGNE
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterChip(
                              "Toutes",
                              Icons.all_inclusive,
                              true,
                              () {
                                // evenementVm.filterByType(null);
                              },
                            ),
                            const SizedBox(width: 10),
                            _buildFilterChip(
                              "Concerts",
                              Icons.music_note,
                              false,
                              () {
                                // evenementVm.filterByType("CONCERT");
                              },
                            ),
                            const SizedBox(width: 10),
                            _buildFilterChip(
                              "Théâtre",
                              Icons.theater_comedy,
                              false,
                              () {
                                // evenementVm.filterByType("THEATRE");
                              },
                            ),
                            const SizedBox(width: 10),
                            _buildFilterChip(
                              "Festivals",
                              Icons.local_activity,
                              false,
                              () {
                                // evenementVm.filterByType("FESTIVAL");
                              },
                            ),
                            const SizedBox(width: 10),
                            _buildFilterChip("Cinéma", Icons.movie, false, () {
                              // evenementVm.filterByType("CINEMA");
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Fonction pour créer un badge filtre
                const SizedBox(height: 4),

                /// COMPTEUR
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    evenementVm.filteredEvenements.isEmpty
                        ? "Aucun événement trouvé"
                        : "${evenementVm.filteredEvenements.length} événement(s)",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                /// GRID 2 PAR 2
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Skeleton(
                      isLoading: evenementVm.isEventLoading,
                      skeleton: SkeletonListView(),
                      child: evenementVm.filteredEvenements.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Image.asset(
                                  //   'assets/images/panier.png',
                                  //   width: 114,
                                  //   height: 114,
                                  // ),
                                  const SizedBox(height: 16),
                                  Text(
                                    "Aucun évènement disponible.",
                                    style: Theme.of(context).textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                 evenementVm.getEvents();
                              },
                              child: GridView.builder(
                                padding: const EdgeInsets.only(bottom: 20),
                                itemCount:
                                    evenementVm.filteredEvenements.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 0.0,
                                      childAspectRatio: 0.72,
                                    ),
                                itemBuilder: (context, index) {
                                  final evenement =
                                      evenementVm.filteredEvenements[index];

                                  return InkWell(
                                    onTap: () {
                                      evenementVm.setSelectedEvenement(
                                        evenement,
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const DetailEvenements(),
                                        ),
                                      );
                                    },
                                    borderRadius: BorderRadius.circular(16),
                                    child: CardEvenement(
                                      evenementModel: evenement,
                                    ),
                                  );
                                },
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ProfilView();
                  },));
                },
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

  // Widget _buildFilterChip({
  //   required String label,
  //   required bool isSelected,
  //   required VoidCallback onTap,
  // }) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //       decoration: BoxDecoration(
  //         color: isSelected ? AppColors.primaryBlue : Colors.white,
  //         borderRadius: BorderRadius.circular(25),
  //         border: Border.all(
  //           color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
  //           width: 1,
  //         ),
  //         boxShadow: isSelected
  //             ? [
  //           BoxShadow(
  //             color: AppColors.primaryBlue.withOpacity(0.3),
  //             blurRadius: 8,
  //             offset: const Offset(0, 2),
  //           ),
  //         ]
  //             : null,
  //       ),
  //       child: Text(
  //         label,
  //         style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //           fontSize: 14,
  //           fontWeight: FontWeight.w600,
  //           color: isSelected ? Colors.white : Colors.grey.shade700,
  //         ),
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget _buildSkeletonLoader() {
  //   return ListView.builder(
  //     padding: const EdgeInsets.only(bottom: 20),
  //     itemCount: 4,
  //     itemBuilder: (context, index) {
  //       return Container(
  //         margin: const EdgeInsets.only(bottom: 16),
  //         padding: const EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(16),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withOpacity(0.05),
  //               blurRadius: 8,
  //               offset: const Offset(0, 2),
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           children: [
  //             Row(
  //               children: [
  //                 Container(
  //                   width: 80,
  //                   height: 80,
  //                   decoration: BoxDecoration(
  //                     color: Colors.grey.shade200,
  //                     borderRadius: BorderRadius.circular(12),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 16),
  //                 Expanded(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         width: 120,
  //                         height: 16,
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey.shade200,
  //                           borderRadius: BorderRadius.circular(4),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 8),
  //                       Container(
  //                         width: double.infinity,
  //                         height: 14,
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey.shade200,
  //                           borderRadius: BorderRadius.circular(4),
  //                         ),
  //                       ),
  //                       const SizedBox(height: 8),
  //                       Container(
  //                         width: 80,
  //                         height: 12,
  //                         decoration: BoxDecoration(
  //                           color: Colors.grey.shade200,
  //                           borderRadius: BorderRadius.circular(4),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 12),
  //             Container(
  //               width: double.infinity,
  //               height: 40,
  //               decoration: BoxDecoration(
  //                 color: Colors.grey.shade200,
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildEmptyState(EvenementViewModel evenementVm) {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 40),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Icon(
  //             Icons.event_busy_outlined,
  //             size: 80,
  //             color: Colors.grey.shade400,
  //           ),
  //           const SizedBox(height: 20),
  //           Text(
  //             evenementVm.selectedTypeEvenement != null
  //                 ? 'Aucun ${_getTypeName(evenementVm.selectedTypeEvenement)} disponible'
  //                 : 'Aucun événement disponible',
  //             textAlign: TextAlign.center,
  //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //               fontSize: 18,
  //               fontWeight: FontWeight.w600,
  //               color: Colors.grey.shade700,
  //             ),
  //           ),
  //           const SizedBox(height: 12),
  //           Text(
  //             evenementVm.selectedTypeEvenement != null
  //                 ? 'Essayez un autre type d\'événement'
  //                 : 'De nouveaux événements arrivent bientôt',
  //             textAlign: TextAlign.center,
  //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //               fontSize: 14,
  //               color: Colors.grey.shade500,
  //             ),
  //           ),
  //           const SizedBox(height: 24),
  //           if (evenementVm.selectedTypeEvenement != null)
  //             ElevatedButton(
  //               onPressed: () {
  //                 // evenementVm.clearTypeFilter();
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: AppColors.primaryBlue,
  //                 foregroundColor: Colors.white,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(12),
  //                 ),
  //                 padding: const EdgeInsets.symmetric(
  //                   horizontal: 32,
  //                   vertical: 14,
  //                 ),
  //               ),
  //               child: Text(
  //                 "Voir tous les événements",
  //                 style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //             ),
  //           const SizedBox(height: 8),
  //           TextButton(
  //             onPressed: () {
  //               // Recharger les événements
  //               evenementVm.getAllEvenements();
  //             },
  //             child: Text(
  //               "Recharger",
  //               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
  //                 color: AppColors.primaryBlue,
  //                 fontWeight: FontWeight.w600,
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  //
  // String _getTypeName(TypeEvenement? type) {
  //   switch (type) {
  //     case TypeEvenement.CONCERT:
  //       return 'concert';
  //     case TypeEvenement.MATCH:
  //       return 'match';
  //     case TypeEvenement.THEATRE:
  //       return 'spectacle de théâtre';
  //     case TypeEvenement.FESTIVAL:
  //       return 'festival';
  //     case TypeEvenement.CINEMA:
  //       return 'film';
  //     case TypeEvenement.EXPOSITION:
  //       return 'exposition';
  //     default:
  //       return 'événement';
  //   }
  // }
}
Widget _buildFilterChip(String label, IconData icon, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryBlue : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: isSelected ? Colors.white : Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.montserrat(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.grey.shade700,
            ),
          ),
        ],
      ),
    ),
  );
}
