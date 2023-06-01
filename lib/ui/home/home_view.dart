import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:smart_garden/ui/home/home_view_model.dart';
import 'package:smart_garden/ui/settings/settings_view.dart';
import '../../utils/Routes.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<HomeViewViewModel>(context);
    return ChangeNotifierProvider<HomeViewViewModel>(
        create: (BuildContext context) => viewModel,
        child: Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppBar(
              centerTitle: true,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
            floatingActionButton: FloatingActionButton(
              heroTag: "bluetooth_settings_btn",
              backgroundColor: Colors.lightGreen,
              shape: const CircleBorder(),
              onPressed: () async {
                final device =
                await Navigator.of(context).pushNamed(Routes.bluetooth);
                if (device is BluetoothDevice) {
                  viewModel.setDeviceConnected(device);
                }
              },
              child: const SizedBox(
                  child: Icon(
                    Icons.bluetooth_connected_rounded,
                    color: Colors.white,
                    size: 40.0,
                  )),
            ),
            body: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(30.0),
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
                      child: Text("Status:${viewModel.status}"),
                    )),
                const SizedBox(
                  height: 35.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 7.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(30.0),
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
                                          Lottie.asset(
                                              width: 30,
                                              height: 30,
                                              'assets/lottie/water.json'),
                                          Text(
                                              '${viewModel.humidity
                                                  .toStringAsFixed(2)} %'),
                                          const SizedBox(width: 5.0),
                                          Lottie.asset(
                                              width: 30,
                                              height: 30,
                                              'assets/lottie/light.json'),
                                          Text(
                                              '${viewModel.luminosity
                                                  .toStringAsFixed(2)} lx'),
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
                            child: Stack(
                              children: [
                                Center(
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Lottie.asset(
                                          width: 200,
                                          height: 200,
                                          repeat: false,
                                          'assets/lottie/flower.json'),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    bottom: 35,
                                    left: 105,
                                    child: Image.asset(
                                        'assets/images/bucket.png')),
                                Positioned(
                                    child: (viewModel.isWatering
                                        ? Lottie.asset(
                                        'assets/lottie/rain.json')
                                        : Lottie.asset(
                                        'assets/lottie/clouds.json'))),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
                surfaceTintColor: Colors.green,
                shape: const CircularNotchedRectangle(),
                notchMargin: 5,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        if (viewModel.deviceSelected != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SettingsScreen(
                                        connection: viewModel.connection),
                              ));
                        } else {
                          Fluttertoast.showToast(
                              msg: "Select the device in the Bluetooth list!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.water_drop,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        viewModel.forceWatering();
                      },
                    ),
                  ],
                ))));
  }
}
