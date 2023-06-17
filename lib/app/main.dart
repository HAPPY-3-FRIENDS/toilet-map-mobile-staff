import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap_staff/app/utils/Routes.dart';
import 'package:toiletmap_staff/app/utils/router.dart' as router;

late SharedPreferences sharedPreferences;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent)
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 900),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: "Nhà vệ sinh cộng đồng",
        theme: ThemeData(
          fontFamily: 'Roboto',
        ),
        debugShowCheckedModeBanner: false,
        home: Center(child: Text('Dự án Nhà vệ sinh cộng đồng')),
        //change to main to build apk
        initialRoute: Routes.loginMainScreen,
        onGenerateRoute: router.Router.generateRoute,
      ),
    );
  }
}
