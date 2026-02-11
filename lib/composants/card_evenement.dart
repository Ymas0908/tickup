import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickup/models/evenement_model.dart';
import 'package:tickup/ressources/utils/format_date.dart';

class CardEvenement extends StatelessWidget {
  final EvenementModel evenementModel;
  final VoidCallback? onTap;

  const CardEvenement({
    super.key,
    required this.evenementModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE
            Container(
              width: double.infinity,
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // réduit le margin vertical
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.shade100,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  "",
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade200,
                      child: const Icon(
                        Icons.image_not_supported,
                        color: Colors.grey,
                        size: 50,
                      ),
                    );
                  },
                ),
              ),
            ),

            // TEXTS
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 14), // réduit le padding top
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITRE (juste en bas de l'image)
                  AutoSizeText(
                    evenementModel.title ?? "",
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// DATE + LIEU
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          "${evenementModel.date} • ${evenementModel.venue?.name ?? ''}",
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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