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
    return Consumer<HomeViewViewModel>(builder: (context, viewModel, _) {
      return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          heroTag: "bluetooth_settings_btn",
          backgroundColor: Colors.lightGreen,
          shape: const CircleBorder(),
          onPressed: () => viewModel.test(),
          child: const SizedBox(
              child: Icon(
            Icons.bluetooth_connected_rounded,
            color: Colors.white,
            size: 40.0,
          )),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 35.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/images/cloud_background.png'),
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter),
                    borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20.0),
                        right: Radius.circular(20.0)),
                    border: Border.all(
                      color: Colors.black,
                      width: .5,
                      style: BorderStyle.solid,
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: .5,
                                        style: BorderStyle.solid,
                                      ),
                                      color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5.0,
                                          spreadRadius: 5.0,
                                          offset: Offset(0.0, 1.0),
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 2.0),
                                    child: Row(children: [
                                      Image.asset('assets/images/water.png'),
                                      Text(
                                          '${viewModel.humidity.toString()} %'),
                                      const SizedBox(width: 5.0),
                                      Image.asset('assets/images/light.png'),
                                      Text(
                                          '${viewModel.luminosity.toString()} lx'),
                                    ]),
                                  )),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              child: Image.asset('assets/images/sun.png'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: viewModel.isWatering
                                      ? const AssetImage(
                                          'assets/images/cloud_raining.png')
                                      : const AssetImage(
                                          'assets/images/plant.png'),
                                  alignment: viewModel.isWatering
                                      ? Alignment.topCenter
                                      : Alignment.center)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: viewModel.isWatering
                                    ? [
                                        Image.asset('assets/images/cloud1.png'),
                                        Image.asset('assets/images/cloud2.png'),
                                      ]
                                    : [],
                              ),
                              Container(
                                  padding: const EdgeInsets.only(
                                    left: 5.0,
                                  ),
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/flower.png'),
                                          alignment: Alignment.topCenter)),
                                  child:
                                      Image.asset('assets/images/bucket.png')),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Stack(
          alignment: const FractionalOffset(.5, 1.0),
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: FloatingActionButton(
                heroTag: "settings_btn",
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.settings);
                  // viewModel.toggleWatering();
                },
                backgroundColor: Colors.lightGreen,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
