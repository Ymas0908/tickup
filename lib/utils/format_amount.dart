import 'package:intl/intl.dart';

final formatter = NumberFormat("#,###", "fr_FR");

String formatAmount(double? amount) {
  return amount == null ? "0 F CFA" : "${formatter.format(amount)} FCFA";
}
