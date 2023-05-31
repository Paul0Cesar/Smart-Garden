import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

abstract class BluetoothRepository {
  Future<bool> getStatus();

  Future<bool> toggleStatus();

  Future<List<BluetoothDevice>> listBondedDevices();

  Future<BluetoothConnection> connect(BluetoothDevice device);

  Future<bool> send(BluetoothConnection connection, Map<String, dynamic> json);
}
