import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_garden/repositories/bluetooth/BluetoothRepositoryImpl.dart';
import 'package:smart_garden/ui/home/home_view.dart';
import 'package:smart_garden/ui/home/home_view_model.dart';
import 'package:smart_garden/ui/settings/settings_view_model.dart';
import 'package:smart_garden/utils/Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              HomeViewViewModel(bluetoothRepository: BluetoothRepositoryImpl()),
        ),
        ChangeNotifierProvider(create: (_) => SettingsViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: Routes.home,
        onGenerateRoute: Routes.generateRoute,
        //    home: const HomeScreen()
      ),
    );
  }
}
