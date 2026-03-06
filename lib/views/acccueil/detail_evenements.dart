import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tickup/composants/primary_button.dart';
import 'package:tickup/composants/showDetailTicket.dart';
import 'package:tickup/models/enum/type_evenement.dart';
import 'package:tickup/ressources/const/app_colors.dart';
import 'package:tickup/ressources/utils/format_date.dart';
import 'package:tickup/views_models/evenements/evenement_viewmodel.dart';

class DetailEvenements extends StatefulWidget {
  const DetailEvenements({super.key});

  @override
  State<DetailEvenements> createState() => _DetailEvenementsState();
}

class _DetailEvenementsState extends State<DetailEvenements> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EvenementViewModel>(
      builder: (context, viewModel, child) {
        final evenement = viewModel.selectedEvenement;

        if (evenement == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              evenement.nom ?? '',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold
              ),
            ),
            backgroundColor: AppColors.primaryBlue,
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    // Image.network(
                    //   evenement.urlImage.toString(),
                    //   width: double.infinity,
                    //   height: 300,
                    //   fit: BoxFit.cover,
                    // ),
                    Image.network(
                      evenement.urlImage.toString(),
                      height: 300,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: const Icon(Icons.image_not_supported, size: 300),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Date & Genre
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formatDateTime(evenement.dateHeureEvenement),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Genre",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Container(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 10,
                          //     vertical: 4,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     color: AppColors.secondaryBlue.withOpacity(0.2),
                          //     borderRadius: BorderRadius.circular(16),
                          //   ),
                          //   child: Text(
                          //     getTypeEvenement(evenement?.category!.name as TypeEvenement ) ?? "",
                          //     style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          //       fontSize: 12,
                          //       fontWeight: FontWeight.bold,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Lieu
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lieu",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        evenement.lieu ?? "",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                Divider(thickness: 1, color: Colors.grey.shade300),

                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        evenement.description ?? "",
                        maxLines: 10,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: PrimaryButton(
                title: "Réserver un ticket",
                onPressed: () {
                  _showTicketBottomSheet(context);

                },
              ),
            ),
          ),

        );
      },
    );
  }

  void _showTicketBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) => const ShowDetailTicket(),
    );
  }

  // String? getTypeEvenement(TypeEvenement typeEvenement) {
  //   switch (typeEvenement) {
  //     case TypeEvenement.MATCH:
  //       return "Match";
  //     case TypeEvenement.RELEASE_PARTY:
  //       return "Release Party";
  //     case TypeEvenement.THEATRE:
  //       return "Theatre";
  //     case TypeEvenement.CINEMA:
  //       return "Cinema";
  //     case TypeEvenement.CONCERT:
  //       return "Concert";
  //     case TypeEvenement.FESTIVAL:
  //       return "Festival";
  //     case TypeEvenement.EXPOSITION:
  //       return "Exposition";
  //     default:
  //       return null;
  //   }
  // }
}
