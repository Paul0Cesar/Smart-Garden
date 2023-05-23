import 'package:flutter/material.dart';
import 'package:smart_garden/repositories/bluetooth/BluetoothRepository.dart';

class HomeViewViewModel with ChangeNotifier {
  late BluetoothRepository? bluetoothRepository;
  int humidity = 15;
  int luminosity = 10;
  bool isWatering = true;

  HomeViewViewModel({
    required this.bluetoothRepository,
  });

  test() {
    print("test");
  }

  toggleWatering() {
    isWatering = !isWatering;
    notifyListeners();
  }
}
