import 'package:intl/intl.dart';


final formatter = NumberFormat("#,###", "fr_FR");

String formatAmount(double? amount) {
  return amount == null ? "0 F CFA" : "${formatter.format(amount)} F CFA";
}

/// Masquer les chiffres du pan de carte en laissant les 4 derniers
/// ex. 1234 5678 9012 3456 -> **** **** **** 3456
/// ex. 1234 -> **** **** **** 1234, etc..
String formatCardPan(String? pan) {
  if (pan == null || pan.isEmpty) return "";

  const int panLength = 16;

  // Garde les 4 derniers caractères
  final last4 = pan.length >= 4 ? pan.substring(pan.length - 4) : pan;

  // Calcule la longueur à masquer
  final maskedLength = panLength - last4.length;
  final maskedPart = '*' * maskedLength;

  // Concatène et formate en groupes de 4
  final fullPan = maskedPart + last4;

  final buffer = StringBuffer();
  for (int i = 0; i < fullPan.length; i += 4) {
    if (i > 0) buffer.write(' ');
    final end = (i + 4 < fullPan.length) ? i + 4 : fullPan.length;
    buffer.write(fullPan.substring(i, end));
  }

  return buffer.toString();
}
String? validatePassword(String? pw) {
  if (pw == null || pw.isEmpty) return 'Mot de passe requis';
  if (pw.length < 8) return 'Au moins 8 caractères';
  if (!RegExp(r'[A-Z]').hasMatch(pw)) return 'Une majuscule requise';
  if (!RegExp(r'[a-z]').hasMatch(pw)) return 'Une minuscule requise';
  if (!RegExp(r'\d').hasMatch(pw)) return 'Un chiffre requis';
  if (!RegExp(r'[@$!%*?&.#_+-]').hasMatch(pw)) {
    return 'Un caractère spécial requis';
  }
  return null;
}

// Future<bool> demanderPermissionCamera() async {
//   var status = await Permission.camera.status;
//
//   if (status.isGranted) {
//     return true;
//   } else if (status.isDenied) {
//     status = await Permission.camera.request();
//     return status.isGranted;
//   } else if (status.isPermanentlyDenied) {
//     // Diriger l'utilisateur vers les paramètres
//     await openAppSettings();
//     return false;
//   }
//
//   return false;
// }
