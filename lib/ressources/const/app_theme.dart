import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Importation de Google Fonts

import 'app_colors.dart'; // Supposons que AppColors est défini ailleurs

class AppTheme {
  // Définition d'un thème sombre pour la démo, en supposant que vous voulez un thème clair par défaut.
  // J'ai utilisé AppColors.white pour le fond, mais j'ai gardé le Colors.grey[200] original pour la cohérence.

  static ThemeData get defaultTheme {
    // Les couleurs primaires et d'arrière-plan du Scaffold
    const Color primaryColor = AppColors.primaryBlue;
    const Color textColor = AppColors.black;
    const Color backgroundColor = AppColors.white; // Utiliser une couleur claire

    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: Colors.grey[200], // Garde la couleur de fond originale

      // --- Utilisation de GoogleFonts.montserrat pour tout le TextTheme ---
      textTheme: GoogleFonts.montserratTextTheme().copyWith(
        // Grandes Têtes d'Affiches
        headlineLarge: GoogleFonts.montserrat(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        headlineMedium: GoogleFonts.montserrat(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        headlineSmall: GoogleFonts.montserrat(
          fontSize: 24,
          color: textColor,
        ),

        // Corps de Texte
        bodyLarge: GoogleFonts.montserrat(
          fontSize: 24,
          color: textColor,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 16,
          color: textColor,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: 12,
          color: textColor,
        ),

        // Titres (utilisés dans ListTile, Dialogues, etc.)
        titleLarge: GoogleFonts.montserrat(
          fontSize: 24,
          color: textColor,
        ),
        titleMedium: GoogleFonts.montserrat(
          fontSize: 18,
          color: textColor,
        ),
        titleSmall: GoogleFonts.montserrat(
          fontSize: 16,
          color: textColor,
        ),

        // Étiquettes (utilisées dans les boutons, les champs de texte, etc.)
        labelLarge: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w600, // Souvent un peu plus gras pour les labels
          color: textColor,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: 12,
          color: textColor,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: 10,
          color: textColor,
        ),
      ),

      // Thème de la Barre d'Application
      appBarTheme: AppBarTheme(
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 18,
          color: textColor,
          fontWeight: FontWeight.bold, // Ajout d'un poids pour le titre de l'AppBar
        ),
        backgroundColor: AppColors.white,
        foregroundColor: textColor,
        elevation: 1, // Une légère ombre pour la séparation
      ),

      // Thème des Boutons Remplis (FilledButton)
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.disabled)) {
              return primaryColor.withOpacity(0.5); // Couleur désactivée
            }
            return primaryColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            return Colors.white; // Texte toujours blanc sur fond bleu primaire
          }),
          textStyle: WidgetStatePropertyAll(
            GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
      ),



      // Thème du Menu Déroulant (DropdownMenu)
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: GoogleFonts.montserrat(color: textColor, fontSize: 16),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: backgroundColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        menuStyle: MenuStyle(
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          elevation: WidgetStatePropertyAll(4),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
      ),

      // Thème de la Radio (Radio)
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return textColor;
        }),
        overlayColor: WidgetStateProperty.all(primaryColor.withOpacity(0.1)),
        splashRadius: 22,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),

      // Thème de la Barre de Snackbar (SnackBar)
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.black.withOpacity(0.9),
        contentTextStyle: GoogleFonts.montserrat(color: Colors.white),
      ),

      // Thème de la Boîte de Saisie (InputDecorationTheme)
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        labelStyle: GoogleFonts.montserrat(color: textColor.withOpacity(0.8)),
        hintStyle: GoogleFonts.montserrat(color: Colors.grey),
      ),

      // Thème des Icônes
      iconTheme: IconThemeData(color: textColor, size: 24),
    );
  }
}