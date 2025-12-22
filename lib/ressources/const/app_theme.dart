import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Importation de Google Fonts

import 'app_colors.dart'; // Supposons que AppColors est défini ailleurs

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get defaultTheme {
    const Color primaryColor = AppColors.primaryBlue;
    const Color secondaryColor = AppColors.secondaryBlue;
    const Color backgroundColor = Colors.white;
    const Color textColor = AppColors.black;
    const Color surfaceColor = Colors.white;

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        background: backgroundColor,
        surface: surfaceColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: textColor,
        onSurface: textColor,
        error: Colors.red,
        outline: Colors.grey.shade300,
      ),

      // --- Typographie avec Montserrat ---
      textTheme: GoogleFonts.montserratTextTheme(
        ThemeData.light().textTheme,
      ).copyWith(
        // Display - Grands titres
        displayLarge: GoogleFonts.montserrat(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          color: textColor,
          letterSpacing: -0.25,
        ),
        displayMedium: GoogleFonts.montserrat(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
        displaySmall: GoogleFonts.montserrat(
          fontSize: 36,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),

        // Headline - Titres principaux
        headlineLarge: GoogleFonts.montserrat(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
        headlineMedium: GoogleFonts.montserrat(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        headlineSmall: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),

        // Title - Sous-titres
        titleLarge: GoogleFonts.montserrat(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleMedium: GoogleFonts.montserrat(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        titleSmall: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),

        // Body - Texte courant
        bodyLarge: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textColor,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor,
          height: 1.5,
        ),
        bodySmall: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textColor.withOpacity(0.7),
        ),

        // Label - Boutons, labels
        labelLarge: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: primaryColor,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: textColor.withOpacity(0.6),
        ),
      ),

      // --- AppBar Theme ---
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: textColor,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
        iconTheme: const IconThemeData(color: textColor, size: 24),
        actionsIconTheme: const IconThemeData(color: textColor, size: 24),
      ),

      // --- Bottom Navigation Bar ---
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey.shade600,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: GoogleFonts.montserrat(
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
      ),

      // --- Elevated Button Theme ---
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: primaryColor.withOpacity(0.3),
          disabledForegroundColor: Colors.white.withOpacity(0.5),
          textStyle: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
      ),

      // --- Outlined Button Theme ---
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          side: BorderSide(color: primaryColor, width: 1.5),
          textStyle: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // --- Text Button Theme ---
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
          textStyle: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        ),
      ),

      // --- Input Decoration Theme ---
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        labelStyle: GoogleFonts.montserrat(
          color: Colors.grey.shade600,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: GoogleFonts.montserrat(
          color: Colors.grey.shade500,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: GoogleFonts.montserrat(
          color: Colors.red,
          fontSize: 12,
        ),
      ),

      // --- Card Theme ---

      // --- Divider Theme ---
      dividerTheme: DividerThemeData(
        color: Colors.grey.shade200,
        thickness: 1,
        space: 0,
      ),

      // --- SnackBar Theme ---
      snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey.shade900,
        contentTextStyle: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 6,
      ),

      // --- Chip Theme ---
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey.shade100,
        selectedColor: primaryColor,
        labelStyle: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        secondaryLabelStyle: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),

      // --- Radio Theme ---
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return Colors.grey.shade400;
        }),
        overlayColor: MaterialStateProperty.all(primaryColor.withOpacity(0.1)),
        splashRadius: 20,
      ),

      // --- Checkbox Theme ---
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(Colors.white),
        side: BorderSide(color: Colors.grey.shade400, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // --- List Tile Theme ---
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        subtitleTextStyle: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor.withOpacity(0.6),
        ),
        leadingAndTrailingTextStyle: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textColor,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        minLeadingWidth: 40,
        iconColor: primaryColor,
      ),

      // --- Progress Indicator Theme ---
      progressIndicatorTheme: ProgressIndicatorThemeData(
        linearTrackColor: Colors.grey.shade200,
        color: primaryColor,
      ),
    );
  }

  // --- Thème sombre optionnel ---
  static ThemeData get darkTheme {
    const Color primaryColor = AppColors.primaryBlue;
    const Color backgroundColor = Color(0xFF121212);
    const Color surfaceColor = Color(0xFF1E1E1E);
    const Color textColor = Colors.white;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        secondary: AppColors.secondaryBlue,
        background: backgroundColor,
        surface: surfaceColor,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onBackground: textColor,
        onSurface: textColor,
      ),

      textTheme: GoogleFonts.montserratTextTheme(
        ThemeData.dark().textTheme,
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        elevation: 0,
        titleTextStyle: GoogleFonts.montserrat(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),



      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
      ),
    );
  }
}