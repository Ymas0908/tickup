import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('fr');

  Locale get locale => _locale;

  void changeLanguage(String language) {
    switch (language) {
      case 'Français':
        _locale = const Locale('fr');
        break;
      case 'English':
        _locale = const Locale('en');
        break;
      default:
        _locale = const Locale('fr');
    }
    notifyListeners();
  }
}