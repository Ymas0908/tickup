// import 'package:flutter/material.dart';
//
// // Cette vue utilise le thème configuré (GoogleFonts.montserrat, couleurs primaires)
// // via Theme.of(context).
// class GetStartedScreen extends StatelessWidget {
//   const GetStartedScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Récupération du thème et de la palette de couleurs
//     final ThemeData theme = Theme.of(context);
//     final Color primaryColor = theme.primaryColor;
//     final Color textColor = theme.textTheme.bodyMedium!.color!;
//
//     return Scaffold(
//       // Le ScaffoldBackground est Colors.grey[200] selon AppTheme.dart
//       body: Container(
//         // Décoration de fond similaire à celle fournie, mais avec une couleur de départ plus claire
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             // Utilise la couleur de fond du Scaffold et le Blanc pour un effet subtil
//             colors: [
//               theme.scaffoldBackgroundColor ?? Colors.white,
//               Colors.white,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // En-tête (Simulate l'heure ou un élément d'information)
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 12, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: textColor.withOpacity(0.05),
//                             blurRadius: 10,
//                             offset: const Offset(0, 2),
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         '9:41',
//                         style: theme.textTheme.bodySmall!.copyWith(
//                           fontWeight: FontWeight.w600,
//                           color: textColor.withOpacity(0.8),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 60),
//
//                 // Logo/Nom de l'application (Ticket App)
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.confirmation_number_rounded, // Icône de ticket
//                       color: primaryColor,
//                       size: 32,
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'TICKET.IT', // Nom de l'app de tickets
//                       style: theme.textTheme.headlineSmall!.copyWith(
//                         fontWeight: FontWeight.w800,
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 const SizedBox(height: 40),
//
//                 // Titre principal
//                 Text(
//                   "Discover and Manage Your Events",
//                   // Utilisation du style headlineLarge du thème
//                   style: theme.textTheme.headlineLarge!.copyWith(
//                     fontSize: 36, // Force la taille 36 pour l'impact visuel
//                     height: 1.2,
//                     color: textColor,
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Description
//                 Text(
//                   "Find, purchase, and securely store all your event tickets\nwith ease and peace of mind.",
//                   // Utilisation du style bodyMedium du thème
//                   style: theme.textTheme.bodyMedium!.copyWith(
//                     color: textColor.withOpacity(0.6),
//                     height: 1.5,
//                   ),
//                 ),
//
//                 const SizedBox(height: 60),
//
//                 // Illustration (Placeholder)
//                 Expanded(
//                   child: Center(
//                     child: Container(
//                       width: 280,
//                       height: 280,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           // Utilisation de la couleur primaire pour le gradient
//                           colors: [
//                             primaryColor,
//                             primaryColor.withOpacity(0.7),
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(140),
//                         boxShadow: [
//                           BoxShadow(
//                             color: primaryColor.withOpacity(0.3),
//                             blurRadius: 40,
//                             offset: const Offset(0, 20),
//                           ),
//                         ],
//                       ),
//                       child: const Icon(
//                         Icons.calendar_month_rounded, // Icône d'illustration
//                         color: Colors.white,
//                         size: 120,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 // Bouton Get Started (Utilise FilledButton pour le thème défini)
//                 SizedBox(
//                   width: double.infinity,
//                   height: 56,
//                   child: FilledButton(
//                     onPressed: () {
//                       // Remplacez par votre navigation
//                       // Navigator.pushNamed(context, '/login');
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Get Started',
//                           // Le style du texte est déjà géré par filledButtonTheme
//                         ),
//                         const SizedBox(width: 8),
//                         const Icon(Icons.arrow_forward_ios_rounded, size: 16),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 20),
//
//                 // Texte optionnel (Login)
//                 Center(
//                   child: TextButton(
//                     onPressed: () {
//                       // Remplacez par votre navigation
//                       // Navigator.pushNamed(context, '/login');
//                     },
//                     child: Text(
//                       'Already have an account? Log in',
//                       style: theme.textTheme.bodyMedium!.copyWith(
//                         color: textColor.withOpacity(0.6),
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }