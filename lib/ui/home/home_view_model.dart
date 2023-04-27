import 'package:flutter/material.dart';
import 'package:smart_garden/repositories/bluetooth/BluetoothRepository.dart';

class HomeViewViewModel with ChangeNotifier {

  late BluetoothRepository bluetoothRepository;

  HomeViewViewModel({
    required this.bluetoothRepository,
  });

  test(){
    print("test");
  }

}
