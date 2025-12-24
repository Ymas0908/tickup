// Fonction utilitaire pour afficher un loader
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ressources/const/app_colors.dart';

void showLoadingSession(BuildContext context, {String message = "Chargement en cours..."}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             CircularProgressIndicator(
              color: AppColors.primaryBlue,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
