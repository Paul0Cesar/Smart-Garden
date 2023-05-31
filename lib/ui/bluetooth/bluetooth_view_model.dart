import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:smart_garden/repositories/bluetooth/BluetoothRepository.dart';

class BluetoothViewModel with ChangeNotifier {
  late BluetoothRepository bluetoothRepository;
  List<BluetoothDevice> bluetoothDevices = List.empty(growable: true);

  bool _bluetoothIsEnabled = false;

  get bluetoothIsEnabled => _bluetoothIsEnabled;

  BluetoothViewModel({
    required this.bluetoothRepository,
  }) {
    verifyBluetoothStatus();
  }

  Future<void> verifyBluetoothStatus() async {
    _bluetoothIsEnabled = await bluetoothRepository.getStatus();
    if (bluetoothIsEnabled) {
      await _listBluetoothDevices();
    }
    notifyListeners();
  }

  Future<void> toggleBluetoothStatus() async {
    var status = await bluetoothRepository.toggleStatus();
    if (bluetoothIsEnabled && !status) {
      bluetoothDevices.clear();
    } else if (!bluetoothIsEnabled && status) {
      await _listBluetoothDevices();
    }
    _bluetoothIsEnabled = status;
    notifyListeners();
  }

  Future<void> _listBluetoothDevices() async {
    bluetoothDevices = await bluetoothRepository.listBondedDevices();
  }
}
