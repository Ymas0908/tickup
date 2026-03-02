import 'package:flutter/material.dart';

Future<DateTime?> selectDate2(BuildContext context) async {
  DateTime now = DateTime.now();

  // Sélecteur de date
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    cancelText: 'Annuler',
    initialDate: now,
    firstDate: DateTime(1900),
    lastDate: now.add(const Duration(days: 365)),
  );

  if (pickedDate == null) return null;

  // Sélecteur d'heure
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    cancelText: 'Annuler',
    initialTime: TimeOfDay.now(),
  );

  if (pickedTime == null) return null;

  return DateTime(
    pickedDate.year,
    pickedDate.month,
    pickedDate.day,
    pickedTime.hour,
    pickedTime.minute,
  );
}
