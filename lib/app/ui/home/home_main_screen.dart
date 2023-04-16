import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toiletmap_staff/app/repositories/toilet_repository.dart';
import 'package:toiletmap_staff/app/ui/home/widgets/home_main_button_widget.dart';

import '../../models/toilet/toilet.dart';
import '../../utils/Routes.dart';
import '../../utils/constants.dart';
import '../login/login_main_screen.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({Key? key}) : super(key: key);

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  var getResult = 'QR Code Result';
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSize.widthScreen /20),
                bottomRight: Radius.circular(AppSize.widthScreen /20)),
        ),
        elevation: 0,
        titleSpacing: 0,

        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(AppSize.widthScreen /20),
                bottomRight: Radius.circular(AppSize.widthScreen /20)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[AppColor.gradientColor1, AppColor.gradientColor2]),
          ),
        ),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(AppSize.heightScreen / 4),
          child: FutureBuilder<Toilet?> (
              future: ToiletRepository().getToiletInformation(),
              builder: (context, snapshot)  {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                          color: AppColor.primaryColor1,
                          strokeWidth: 2.0
                      )
                  );
                }
                if (snapshot.hasData) {
                  print(snapshot!.data!.toiletImageSources[0]);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: AppSize.widthScreen / 3.5,
                        height: AppSize.widthScreen / 3.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(snapshot!.data!.toiletImageSources[0]),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all( Radius.circular(50.0)),
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSize.heightScreen / 40,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 20),
                        child: Text(snapshot!.data!.toiletName, style: AppText.titleText1,),
                      ),
                      SizedBox(height: AppSize.heightScreen / 15,),
                    ],
                  );
                }
                return Center(child: Text('Lỗi'));
              }),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(AppSize.widthScreen / 20),
          child: GridView(
            children: [
              HomeMainButtonWidget(
                  icon: Icons.qr_code_2,
                  text: "Scan mã QR",
                  function: () => {
                    Navigator.pushNamed(context, Routes.scannerMainScreen)
                  }
              ),
              HomeMainButtonWidget(
                  icon: Icons.person,
                  text: "Khách vãng lai",
                  function: () => {}
              ),
              HomeMainButtonWidget(
                  icon: Icons.login_outlined,
                  text: "Nạp số dư",
                  function: () => {
                  }
              ),
              HomeMainButtonWidget(
                  icon: Icons.logout,
                  text: "Đăng xuất",
                  function: () async {
                    try {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('accessToken');
                      await prefs.remove('accountId');
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => const LoginMainScreen()), (
                          route) => false);
                    } catch (error) {
                      print(error);
                    }
                  },
              ),
            ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: AppSize.widthScreen / 20, crossAxisSpacing: AppSize.widthScreen / 40),
          ),
        )
      )
    );
  }

  Future<String?> scanQRCode() async {
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.QR);
      print("QRCode_Result:--");
      print(qrCode);
      return qrCode;
    } on PlatformException {
      getResult = 'Failed to scan QR Code.';
    }
  }
}
