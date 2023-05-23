import 'package:flutter/material.dart';

class SettingsViewModel with ChangeNotifier {
  List<String> options = ['Manual', 'Automático'];
  String? selectedOption = 'Manual';

  changeOption(String? option) {
    selectedOption = option;
    notifyListeners();
  }
}
