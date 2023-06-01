import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:smart_garden/repositories/bluetooth/BluetoothRepository.dart';

class HomeViewViewModel with ChangeNotifier {
  late BluetoothRepository bluetoothRepository;

  BluetoothDevice? _deviceSelected;

  get deviceSelected => _deviceSelected;

  String _status = "Offline";

  get status => _status;

  bool _isWatering = false;

  get isWatering => _isWatering;

  double _luminosity = 0.0;

  get luminosity => _luminosity;

  double _humidity = 0.0;

  get humidity => _humidity;

  BluetoothConnection? _connection;

  get connection => _connection;

  HomeViewViewModel({
    required this.bluetoothRepository,
  });

  Future<void> setDeviceConnected(BluetoothDevice device) async {
    _deviceSelected = device;
    _connection = await bluetoothRepository.connect(device);
    if (_connection?.isConnected == false) {
      _status = "Offline";
      notifyListeners();
      return;
    }
    _status = "Online";
    notifyListeners();
    _connection?.input!.listen(_onDataReceived).onDone(() {
      _status = "Offline";
      notifyListeners();
    });
  }

  void _onDataReceived(Uint8List data) {
    if (data.isNotEmpty) {
      String s = String.fromCharCodes(data);
      if (s.trim().isNotEmpty) {
        var payload = json.decode(s.trim());
        _onDecodeData(payload);
      }
    }
  }

  void _onDecodeData(Map<String, dynamic> json) {
    print("_onDecodeData JSON:$json");

    if (json.containsKey("percent")) {
      _humidity = double.parse(json["percent"].toString()).abs();
    }

    if (json.containsKey("lux")) {
      _luminosity = double.parse(json["lux"].toString()).abs();
    }

    if (json.containsKey("wateringStatus")) {
      _isWatering = json["wateringStatus"].toString() == "true";
    }
    notifyListeners();
  }

  Future<void> forceWatering() async {
    Map<String, dynamic> json = <String, dynamic>{};
    Map<String, dynamic> body = <String, dynamic>{};
    json["route"] = "forceWatering";
    body["forceWatering"] = true;
    json["body"] = body;
    await bluetoothRepository.send(_connection!, json);
  }
}
