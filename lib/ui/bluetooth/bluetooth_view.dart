import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:smart_garden/ui/bluetooth/bluetooth_view_model.dart';

import 'bluetooth_device_element.dart';
import 'detailpage.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  Future<void> checkPermissions() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.location,
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothAdvertise,
      Permission.bluetoothConnect,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<BluetoothViewModel>(context);
    return ChangeNotifierProvider<BluetoothViewModel>(
        create: (BuildContext context) => viewModel,
        builder: (context, provider) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("Smart Garden - Bluetooth"),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  SwitchListTile(
                    title: const Text("Enable Bluetooth"),
                    value: viewModel.bluetoothIsEnabled,
                    onChanged: (bool value) {
                      viewModel.toggleBluetoothStatus();
                    },
                  ),
                  Expanded(
                    child: ListView(
                        children: viewModel.bluetoothDevices
                            .map((device) => BluetoothDeviceElement(
                                  device: device,
                                  enabled: true,
                                  onTap: () {
                                    Navigator.pop(context, device);
                                  },
                                ))
                            .toList()),
                  )
                ],
              ));
        });
  }
}
