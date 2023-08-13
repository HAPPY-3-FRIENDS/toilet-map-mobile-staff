import 'package:flutter/material.dart';
import 'package:toiletmap_staff/app/models/roomAll/room_all.dart';
import 'package:toiletmap_staff/app/models/roomStatus/room_status.dart';
import 'package:toiletmap_staff/app/ui/scanner/scanner_main_screen.dart';

import '../models/room/room.dart';
import '../ui/config/config_screen.dart';
import '../ui/home/home_main_screen.dart';
import '../ui/login/login_main_screen.dart';
import '../ui/passerby/passerby_main_screen.dart';
import '../ui/roommanage/room_lock_screen.dart';
import '../ui/roommanage/room_manage_main_screen.dart';
import '../ui/roommanage/room_status_screen.dart';
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
      case 'RoomManageMainScreen':
        final index = settings.arguments as RoomAll;
        return MaterialPageRoute(builder: (_) => RoomManageMainScreen(roomAll: index,));
      case 'ConfigScreen':
        return MaterialPageRoute(builder: (_) => const ConfigScreen());
      case 'RoomLockScreen':
        final index = settings.arguments as Room;
        return MaterialPageRoute(builder: (_) => RoomLockScreen(room: index,));
      case 'RoomStatusScreen':
        final index = settings.arguments as RoomStatus;
        return MaterialPageRoute(builder: (_) => RoomStatusScreen(roomStatus: index,));
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