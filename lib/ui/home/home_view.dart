import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_garden/ui/home/home_view_model.dart';

import '../../utils/Routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    HomeViewViewModel viewModel = context.watch<HomeViewViewModel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        heroTag:"bluetooth_settings_btn",
        mini: true,
        onPressed: () => viewModel.test(),
        child: const Icon(Icons.bluetooth),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [Text("Smart Garden")],
        ),
      ),
      bottomNavigationBar: Stack(
        alignment: const FractionalOffset(.5, 1.0),
        children: [
          Container(
            height: 40.0,
            color: Colors.red,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: FloatingActionButton(
              heroTag:"settings_btn",
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.settings);
              },
              child: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
    );
  }
}
