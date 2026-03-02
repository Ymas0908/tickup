import 'package:intl/intl.dart';

String formatDate(var date) {
  // String dayOfWeek = DateFormat('EEEE', 'fr_FR').format(date).substring(0, 3);
  String formattedDate = DateFormat('dd/MM/yyyy').format(date);
  return formattedDate;
}

String formatDateTime(var date) {
  // String dayOfWeek = DateFormat('EEEE', 'fr_FR').format(date).substring(0, 3);
  String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(date);
  return formattedDate;
}

String formatRIB(String rib) {
  if (rib.length < 23) {
    return rib;
  }

  String codeBanque = rib.substring(0, 5);
  String codeGuichet = rib.substring(5, 10);
  String numeroCompte = rib.substring(10, 21);
  String cleRIB = rib.substring(21, 23);

  return "$codeBanque $codeGuichet $numeroCompte $cleRIB";
}
