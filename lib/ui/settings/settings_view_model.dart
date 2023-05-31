import 'package:flutter/material.dart';

class SettingsViewModel with ChangeNotifier {
  List<String> options = ['Período', 'Automático'];
  String? selectedOption = 'Automático';

  changeOption(String? option) {
    selectedOption = option;
    notifyListeners();
  }
}
