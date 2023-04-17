import 'package:flutter/material.dart';
import 'package:toiletmap_staff/app/ui/scanner/scanner_main_screen.dart';

import '../ui/home/home_main_screen.dart';
import '../ui/login/login_main_screen.dart';
import '../ui/passerby/passerby_main_screen.dart';
import '../ui/topup/topup_main_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'LoginMainScreen':
        return MaterialPageRoute(builder: (_) => const LoginMainScreen());
      case 'HomeMainScreen':
        return MaterialPageRoute(builder: (_) => const HomeMainScreen());
      case 'ScannerMainScreen':
        return MaterialPageRoute(builder: (_) => const ScannerMainScreen());
      case 'PasserbyMainScreen':
        return MaterialPageRoute(builder: (_) => const PasserbyMainScreen());
      case 'TopupMainScreen':
        return MaterialPageRoute(builder: (_) => const TopupMainScreen());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}