import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  BluetoothState? _bluetoothState;
  BluetoothDevice? _currentDevice;
  late List<BluetoothDevice> _devices = [];
  bool _isSwitchedOn = false;
  bool _isSearching = false;

  Future<void> _getBluetoothState() async {
    _bluetoothState = await FlutterBluetoothSerial.instance.state;
    if (_bluetoothState == BluetoothState.STATE_ON) {
      setState(() {
        _isSwitchedOn = true;
      });
      _searchDevices();
    }
  }

  void _searchDevices() {
    if (_isSwitchedOn) {
      setState(() {
        _isSearching = true;
      });
      _devices.clear();

      FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
        setState(() {
          if (!_devices.contains(result.device)) _devices.add(result.device);
        });
      }, onDone: () {
        setState(() {
          _isSearching = false;
        });
      }, onError: (error) {
        print(error);
      });
    }
  }

  Future<void> _toggleBluetooth(bool value) async {
    if (value) {
      await FlutterBluetoothSerial.instance.requestEnable();
      setState(() {
        _isSwitchedOn = true;
      });
      _searchDevices();
    } else {
      await FlutterBluetoothSerial.instance.requestDisable();
      setState(() {
        _isSwitchedOn = false;
      });
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      bool isBonded = device.isBonded;
      if (!isBonded) {
        await FlutterBluetoothSerial.instance
            .bondDeviceAtAddress(device.address)
            .then((value) => {if (value == true) isBonded = true});
      }
      if (isBonded) {
        await FlutterBluetoothSerial.instance.connect(device);
        print('conectou');
        setState(() {
          _currentDevice = device;
        });
      }
    } catch (error) {
      print(error);
      _searchDevices();
    }
  }

  @override
  void initState() {
    super.initState();
    _getBluetoothState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Garden - Bluetooth"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Bluetooth: "),
                Switch(
                  value: _isSwitchedOn,
                  onChanged: _toggleBluetooth,
                ),
              ],
            ),
            _isSwitchedOn
                ? _isSearching
                    ? const CircularProgressIndicator()
                    : _devices.isEmpty
                        ? const Text("Nenhum dispositivo encontrado.")
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: _devices.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_devices[index].name ?? 'unknown'),
                                subtitle: Text(_devices[index].address),
                                onTap: () {
                                  _connectToDevice(_devices[index]);
                                },
                              );
                            },
                          )
                : Container(),
            _currentDevice != null
                ? Text("Dispositivo conectado: ${_currentDevice!.name}")
                : Container(),
          ],
        ),
      ),
    );
  }
}
