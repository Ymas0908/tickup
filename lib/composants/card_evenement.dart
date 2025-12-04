import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickup/models/evenement_model.dart';
import 'package:tickup/ressources/utils/format_date.dart';

class CardEvenement extends StatelessWidget {
 final EvenementModel evenementModel;

  const CardEvenement({
    Key? key,
    required this.evenementModel,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
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
          )
        ],
      ),
      child: Row(
        children: [
          // IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.network(
              evenementModel.urlImage ?? "",
              width: 95,
              height: 95,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),

          // TEXTES
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  evenementModel.typeEvenement.name,
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  evenementModel.nom ?? "",
                  style: GoogleFonts.montserrat(
                    fontSize: 17,
                    height: 1.3,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  formatDate(evenementModel.dateHeureEvenement),
                  style: GoogleFonts.montserrat(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
