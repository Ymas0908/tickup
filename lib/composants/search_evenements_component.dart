import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tickup/composants/primary_button.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/views_models/evenements/evenement_viewmodel.dart';





class SearchEvenementsComponent extends StatefulWidget {
  const SearchEvenementsComponent({super.key});

  @override
  State<SearchEvenementsComponent> createState() =>
      _SearchEvenementsComponentState();
}

class _SearchEvenementsComponentState extends State<SearchEvenementsComponent> {
  @override
  Widget build(BuildContext context) {

    return Consumer<EvenementViewModel>(
      builder: (context, evenementVM, child) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: AppColors.primaryBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Filtrer les évènements',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filtrez selon un type',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 50,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal, // scroll horizontal
                      itemCount: evenementVM.listTypeEvenement.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final type = evenementVM.listTypeEvenement[index];
                        final isSelected =
                            evenementVM.selectedTypeEvenement == type;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              evenementVM.selectedTypeEvenement = type;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primaryBlue
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.secondaryBlue
                                    : Colors.grey.shade400,
                                width: 1.5,
                              ),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: AppColors.primaryBlue.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                type.name,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey.shade800,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Bouton de réinitialisation
              // if (selection) ...[
              //   SizedBox(
              //     width: double.infinity,
              //     child: SecondaryButton(
              //       onPressed: () {
              //         demandesVm.setSelectedTypeDemande(null);
              //         demandesVm.setSelectedStatutDemande(null);
              //       },
              //       child:  Text('Réinitialiser les filtres'),
              //     ),
              //   ),
              //   const SizedBox(height: 12),
              // ],

              // Bouton de confirmation
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  title: "Appliquer les filtres",
                  onPressed: () {
                    // evenementVM.filterEvenementByType();
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// child: Container(
// padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
// decoration: BoxDecoration(
// color: isSelected ? AppColors.gimpPayBlue100 : Colors.white,
// borderRadius: BorderRadius.circular(20),
// border: Border.all(
// color: isSelected ? AppColors.gimpPayBlue100 : Colors.grey.shade400,
// width: 1.5,
// ),
// boxShadow: [
// if (isSelected)
// BoxShadow(
// color: AppColors.gimpPayBlue100.withOpacity(0.3),
// blurRadius: 4,
// offset: const Offset(0, 2),
// ),
// ],
// ),
// child: Center(
// child: Text(
// typeDemande.name,
// style: TextStyle(
// color: isSelected ? Colors.white : Colors.grey.shade800,
// fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
// fontSize: 14,
// ),
// ),
// ),
// ),
