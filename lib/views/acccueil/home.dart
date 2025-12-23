import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tickup/composants/card_evenement.dart';
import 'package:tickup/composants/search_evenements_component.dart';
import 'package:tickup/composants/showResponsiveBottomSheet.dart';
import 'package:tickup/models/evenement_model.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views/acccueil/detail_evenements.dart';
import 'package:tickup/views_models/evenements/evenement_viewmodel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<EvenementViewModel>(context, listen: false);
      viewModel.getEvents();
      print("Nombre d'événements : ${viewModel.filteredEvenements.length}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f8),

      // APPBAR
      appBar: AppBar(
        backgroundColor: const Color(0xfff6f6f8),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Événements",
          style: GoogleFonts.montserrat(
            fontSize: 21,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              size: 26,
              color: Colors.grey.shade800.withOpacity(.7),
            ),
            onPressed: () {
              // Action de recherche
            },
          ),
        ],
      ),

      // BODY
      body: Consumer<EvenementViewModel>(
        builder: (context, evenementVm, child) {
          return Column(
            children: [
              // Section de recherche et filtres
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SEARCH BAR
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Rechercher un événement...",
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.filter_list),
                          onPressed: () {
                            showResponsiveBottomSheet(
                              context,
                              const SearchEvenementsComponent(),
                            );
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: AppColors.primaryBlue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
                        ),
                      ),
                      onChanged: (value) {
                        // evenementVm.searchEvents(value);
                      },
                    ),
                    const SizedBox(height: 20),

                    // SECTION TITLE
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Événements à venir",
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.black,
                          ),
                        ),
                        if (evenementVm.selectedTypeEvenement != null)
                          GestureDetector(
                            onTap: () {
                              // evenementVm.clearFilters();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    evenementVm.selectedTypeEvenement?.name ?? '',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryBlue,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.close,
                                    size: 14,
                                    color: AppColors.primaryBlue,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Text(
                      evenementVm.filteredEvenements.isEmpty
                          ? "Aucun événement trouvé"
                          : "${evenementVm.filteredEvenements.length} événement(s) disponible(s)",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),

              // Liste des événements (avec Expanded pour prendre l'espace restant)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Skeleton(
                    isLoading: evenementVm.isEventLoading,
                    skeleton: SkeletonListView(
                      itemCount: 3,
                      padding: const EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 95,
                              height: 95,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 80,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    width: 120,
                                    height: 14,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    child: evenementVm.filteredEvenements.isEmpty && !evenementVm.isEventLoading
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_note,
                            size: 80,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Aucun événement disponible',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Text(
                              'Modifiez vos filtres ou revenez plus tard',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          if (evenementVm.selectedTypeEvenement != null)
                            ElevatedButton(
                              onPressed: () {
                                // evenementVm.clearFilters();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryBlue,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text("Réinitialiser les filtres"),
                            ),
                        ],
                      ),
                    )
                        : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: evenementVm.filteredEvenements.length,
                      itemBuilder: (context, index) {
                        final evenement = evenementVm.filteredEvenements[index];
                        return InkWell(
                          onTap: () {
                            evenementVm.setSelectedEvenement(evenement);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailEvenements(),
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
                ),
              ),
            ],
          );
        },
      ),

      // FOOTER NAVIGATION
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xfff6f6f8),
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: Colors.grey.shade500,
        currentIndex: 0,
        selectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: "Événements",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: "Mes Billets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }


}