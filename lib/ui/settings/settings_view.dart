import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:smart_garden/ui/settings/settings_view_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key, required this.connection}) : super(key: key);

  final BluetoothConnection connection;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(builder: (context, viewModel, _) {
      viewModel.setDevice(widget.connection);
      return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Tipo de Rega",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        DropdownButton(
                          value: viewModel.selectedOption,
                          items: viewModel.options.map((String option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: viewModel.changeOption,
                        ),
                        ((viewModel.selectedOption == "INTERVAL")
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      labelText: "Valor em horas",
                                      hintText: "Ex:3"),
                                  onChanged: (value) {
                                    print(value);
                                    viewModel.period = int.parse(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  autofocus: true,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                ))
                            : Container())
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5.0, vertical: 60.0),
                        child: ElevatedButton(
                          onPressed: () {
                            viewModel.save();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                            fixedSize:
                                MaterialStateProperty.all(const Size(300, 50)),
                          ),
                          child: const Text('Atualizar',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white)),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
