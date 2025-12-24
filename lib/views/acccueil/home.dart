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
    return Scaffold(
      backgroundColor: const Color(0xfff6f6f8),
      body: SafeArea(
        child: Consumer<EvenementViewModel>(
          builder: (context, evenementVm, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER AVEC TITRE
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Découvrez",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        "les événements",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primaryBlue,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Trouvez votre prochaine expérience",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // BARRE DE RECHERCHE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Rechercher un événement...",
                        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade500,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.primaryBlue,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                      ),
                      onChanged: (value) {
                        // evenementVm.searchEvents(value);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // FILTRES RAPIDES
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Filtres rapides",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 45,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            _buildFilterChip(
                              label: 'Tous',
                              isSelected: evenementVm.selectedTypeEvenement == null,
                              onTap: () => evenementVm.clearFilters(),
                            ),
                            const SizedBox(width: 8),
                            _buildFilterChip(
                              label: '🎵 Concerts',
                              isSelected: evenementVm.selectedTypeEvenement == TypeEvenement.CONCERT,
                              onTap: () => evenementVm.filterByType(TypeEvenement.CONCERT),
                            ),
                            const SizedBox(width: 8),
                            _buildFilterChip(
                              label: '⚽ Matchs',
                              isSelected: evenementVm.selectedTypeEvenement == TypeEvenement.MATCH,
                              onTap: () => evenementVm.filterByType(TypeEvenement.MATCH),
                            ),
                            const SizedBox(width: 8),
                            _buildFilterChip(
                              label: '🎭 Théâtre',
                              isSelected: evenementVm.selectedTypeEvenement == TypeEvenement.THEATRE,
                              onTap: () => evenementVm.filterByType(TypeEvenement.THEATRE),
                            ),
                            const SizedBox(width: 8),
                            _buildFilterChip(
                              label: '🎪 Festivals',
                              isSelected: evenementVm.selectedTypeEvenement == TypeEvenement.FESTIVAL,
                              onTap: () => evenementVm.filterByType(TypeEvenement.FESTIVAL),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // TITRE SECTION ÉVÉNEMENTS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Événements à venir",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          showResponsiveBottomSheet(
                            context,
                            const SearchEvenementsComponent(),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.filter_alt_outlined,
                                size: 16,
                                color: AppColors.primaryBlue,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "Filtres",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                // COMPTEUR D'ÉVÉNEMENTS
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

                // LISTE DES ÉVÉNEMENTS
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Skeleton(
                      isLoading: evenementVm.isEventLoading,
                      skeleton: _buildSkeletonLoader(),
                      child: evenementVm.filteredEvenements.isEmpty && !evenementVm.isEventLoading
                          ? _buildEmptyState(evenementVm)
                          : RefreshIndicator(
                        onRefresh: () async {
                          await evenementVm.getAllEvenements();
                        },
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          itemCount: evenementVm.filteredEvenements.length,
                          itemBuilder: (context, index) {
                            final evenement = evenementVm.filteredEvenements[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: InkWell(
                                onTap: () {
                                  evenementVm.setSelectedEvenement(evenement);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const DetailEvenements(),
                                    ),
                                  );
                                },
                                borderRadius: BorderRadius.circular(16),
                                child: CardEvenement(
                                  evenementModel: evenement,
                                ),
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
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
            width: 1,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.primaryBlue.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ]
              : null,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey.shade700,
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonLoader() {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 80,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(EvenementViewModel evenementVm) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy_outlined,
              size: 80,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              evenementVm.selectedTypeEvenement != null
                  ? 'Aucun ${_getTypeName(evenementVm.selectedTypeEvenement)} disponible'
                  : 'Aucun événement disponible',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              evenementVm.selectedTypeEvenement != null
                  ? 'Essayez un autre type d\'événement'
                  : 'De nouveaux événements arrivent bientôt',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 24),
            if (evenementVm.selectedTypeEvenement != null)
              ElevatedButton(
                onPressed: () {
                  // evenementVm.clearTypeFilter();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                ),
                child: Text(
                  "Voir tous les événements",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                // Recharger les événements
                evenementVm.getEvents();
              },
              child: Text(
                "Recharger",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getTypeName(TypeEvenement? type) {
    switch (type) {
      case TypeEvenement.CONCERT:
        return 'concert';
      case TypeEvenement.MATCH:
        return 'match';
      case TypeEvenement.THEATRE:
        return 'spectacle de théâtre';
      case TypeEvenement.FESTIVAL:
        return 'festival';
      case TypeEvenement.CINEMA:
        return 'film';
      case TypeEvenement.EXPOSITION:
        return 'exposition';
      default:
        return 'événement';
    }
  }
}