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
import 'package:tickup/views/menu/menu_view.dart';
import 'package:tickup/views/parametres/setting_view.dart';
import 'package:tickup/views_models/evenements/evenement_viewmodel.dart';

import '../../utils/theme_provider.dart';
import '../profil_view.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/utils/theme_provider.dart' hide ThemeProvider;
import 'package:tickup/views/profil_view.dart' hide ProfilView;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EvenementViewModel>(context, listen: false).getEvents();
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
      backgroundColor: isDarkMode ? AppColors.black: Colors.white,
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: isDarkMode ? AppColors.black : null,
        iconTheme: IconThemeData(color: isDarkMode ? Colors.white : null),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                // Naviguer vers l'écran des notifications
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const NotificationsView(),
                //   ),
                // );
              },
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    color: isDarkMode ? Colors.white : Colors.black87,
                    size: 24,
                  ),
                  // Badge
                  // Positioned(
                  //   right: -4,
                  //   top: -4,
                  //   child: Consumer<NotificationsViewModel>(
                  //     builder: (context, viewModel, child) {
                  //       final count = viewModel.notifNonLues;
                  //       if (count == 0) return const SizedBox.shrink();
                  //       return Container(
                  //         padding: const EdgeInsets.symmetric(
                  //           horizontal: 6,
                  //           vertical: 2,
                  //         ),
                  //         decoration: BoxDecoration(
                  //           color: Colors.red,
                  //           borderRadius: BorderRadius.circular(12),
                  //           border: Border.all(
                  //             color: isDarkMode ? Colors.white : Colors.white,
                  //             width: 1.5,
                  //           ),
                  //         ),
                  //         child: Text(
                  //           count > 9 ? '9+' : count.toString(),
                  //           style: const TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 10,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          // Autres actions...
        ],
      ),
      // Ici on met ton MenuView comme drawer
      drawer: Drawer(
        child: MenuView(), // ton widget MenuView
      ),
      body: SafeArea(
        child: Consumer<EvenementViewModel>(
          builder: (context, evenementVm, child) {
            return RefreshIndicator(
              onRefresh: () async {
                evenementVm.getEvents();
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// TITRE PAGE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Découvrez les événements",
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Trouvez et réservez vos tickets",
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// RECHERCHE
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                          )
                        ],
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: "Rechercher un événement",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        onChanged: (value) {
                          evenementVm.updateSearchQueryEvenement(value);
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// FILTRES
                  SizedBox(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _buildFilterChip("Tous", Icons.event, true, () {}),
                        const SizedBox(width: 10),
                        _buildFilterChip("Concert", Icons.music_note, false, () {}),
                        const SizedBox(width: 10),
                        _buildFilterChip("Théâtre", Icons.theater_comedy, false, () {}),
                        const SizedBox(width: 10),
                        _buildFilterChip("Festival", Icons.festival, false, () {}),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// COMPTEUR
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "${evenementVm.filteredEvenements.length} événement(s)",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// LISTE EVENEMENTS
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: evenementVm.filteredEvenements.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemBuilder: (context, index) {
                        final evenement =
                        evenementVm.filteredEvenements[index];

                        return InkWell(
                          onTap: () {
                            evenementVm.setSelectedEvenement(evenement);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                const DetailEvenements(),
                              ),
                            );
                          },
                          child: CardEvenement(
                            evenementModel: evenement,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFilterChip(
      String label, IconData icon, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryBlue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: selected ? Colors.white : Colors.black87,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}