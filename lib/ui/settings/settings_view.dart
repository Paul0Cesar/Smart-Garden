import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_garden/ui/settings/settings_view_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(builder: (context, viewModel, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Smart Garden - Settings"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Expanded(
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
                        "Tipo de rega",
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
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Atualizar',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    fixedSize: MaterialStateProperty.all(Size(300, 50)),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
