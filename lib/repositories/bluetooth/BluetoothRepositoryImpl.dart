import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'BluetoothRepository.dart';

class BluetoothRepositoryImpl implements BluetoothRepository {
  @override
  Future<bool> getStatus() async {
    var state = await FlutterBluetoothSerial.instance.state;
    return state.isEnabled;
  }

  @override
  Future<List<BluetoothDevice>> listBondedDevices() {
    return FlutterBluetoothSerial.instance.getBondedDevices();
  }

  @override
  Future<BluetoothConnection> connect(BluetoothDevice device) {
    return BluetoothConnection.toAddress(device.address);
  }

  @override
  Future<bool> toggleStatus() async {
    var status = await getStatus();
    if (status) {
      await FlutterBluetoothSerial.instance.requestDisable();
      return false;
    }
    await FlutterBluetoothSerial.instance.requestEnable();
    return true;
  }

  @override
  Future<bool> send(
      BluetoothConnection connection, Map<String, dynamic> json) async {
    String text = json.toString().trim();
    if (text.isNotEmpty) {
      try {
        connection.output.add(Uint8List.fromList(utf8.encode(text)));
        await connection.output.allSent;
        return true;
      } catch (e) {
        return false;
      }
    }
    return false;
  }
}
