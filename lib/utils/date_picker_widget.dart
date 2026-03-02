import 'package:flutter/material.dart';

Future<DateTime> selectDate(BuildContext context) async {
  DateTime selectedDate = DateTime.now();
  var date =DateTime.now();
  final DateTime? picked = await showDatePicker(
    cancelText: 'Annuler',
    context: context,
    firstDate: DateTime(1900),
    lastDate: date.add(const Duration(days: 365)),
    initialDate: date,
  );

  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
  }
  return picked ?? DateTime.now();
}




