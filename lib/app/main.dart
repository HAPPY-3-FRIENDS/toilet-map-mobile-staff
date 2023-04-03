import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap_staff/app/utils/Routes.dart';
import 'package:toiletmap_staff/app/utils/router.dart' as router;

late SharedPreferences sharedPreferences;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Nhà vệ sinh công cộng - Nhân viên",
      debugShowCheckedModeBanner: false,
      home: Center(child: Text('Dự án Nhà vệ sinh công cộng')),
      initialRoute: Routes.homeMainScreen,
      onGenerateRoute: router.Router.generateRoute,
    );
  }
}
