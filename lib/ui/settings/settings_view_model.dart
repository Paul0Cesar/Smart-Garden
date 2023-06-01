import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import '../../repositories/bluetooth/BluetoothRepository.dart';

class SettingsViewModel with ChangeNotifier {
  late BluetoothRepository bluetoothRepository;
  List<String> options = ['INTERVAL', 'AUTO'];
  String? selectedOption = 'AUTO';
  int period = 0;
  BluetoothConnection? _connection;
  bool isUpdated = false;

  SettingsViewModel({
    required this.bluetoothRepository,
  });

  setDevice(BluetoothConnection connection) {
    _connection = connection;
  }

  // void _onDecodeData(Map<String, dynamic> json) { TODO create a global listener
  //   print("_onDecodeData JSON:$json");
  //   if (!isUpdated &&
  //       json.containsKey("wateringType") &&
  //       json.containsKey("interval")) {
  //     isUpdated = true;
  //     selectedOption = json["wateringType"].toString();
  //     period = int.parse(json["interval"].toString());
  //     notifyListeners();
  //   }
  // }

  changeOption(String? option) {
    selectedOption = option;
    notifyListeners();
  }

  Future<void> save() async {
    if (_connection == null) {
      return;
    }
    Map<String, dynamic> json = <String, dynamic>{};
    Map<String, dynamic> body = <String, dynamic>{};
    json["route"] = "setConfig";
    body["wateringType"] = selectedOption;
    body["interval"] = period*3600;
    json["body"] = body;
    await bluetoothRepository.send(_connection!, json);
  }
}
