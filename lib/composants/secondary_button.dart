import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tickup/ressources/const/app_colors.dart';


class SecondaryButton extends StatelessWidget {
  SecondaryButton({super.key, required this.title, this.onPressed});
  final String title;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // Récupère le thème du projet

    return FilledButton(
      // style: ButtonStyle(
      //   // textStyle: WidgetStatePropertyAll(Theme.of(context).textTheme.bodyMedium),
      //   // foregroundColor: WidgetStatePropertyAll(AppColors.white),
      //   // backgroundColor: WidgetStatePropertyAll(AppColors.primary),
      // ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:  Colors.white,
        foregroundColor: AppColors.secondaryBlue,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          side: BorderSide(color: AppColors.secondaryBlue, width: 2),

        ),
      ),
      onPressed:onPressed,
      child:  Text(title,

        style: theme.textTheme.titleLarge?.copyWith(
          fontSize: 16,
          color: AppColors.secondaryBlue,
        ),
      ),
    );
  }
}
