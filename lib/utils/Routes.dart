import 'package:flutter/material.dart';
import 'package:smart_garden/ui/home/home_view.dart';
import 'package:smart_garden/ui/settings/settings_view.dart';

class Routes {
  static const String settings = 'settings_screen';
  static const String home = 'home_screen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      case Routes.settings:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SettingsScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text('No route defined')),
          );
        });
    }
  }
}
