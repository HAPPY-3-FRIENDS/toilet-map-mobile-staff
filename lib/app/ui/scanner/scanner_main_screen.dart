
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rate_limiter/rate_limiter.dart';
import 'package:toiletmap_staff/app/repositories/checkin_repository.dart';
import 'package:toiletmap_staff/app/utils/constants.dart';
import 'package:string_splitter/string_splitter.dart';

import '../../models/userInfo/user_info.dart';

class ScannerMainScreen extends StatefulWidget {
  const ScannerMainScreen({Key? key}) : super(key: key);

  @override
  State<ScannerMainScreen> createState() => _ScannerMainScreenState();
}

class _ScannerMainScreenState extends State<ScannerMainScreen> {
  final GlobalKey _globalKey = GlobalKey();
  QRViewController? controller;
  Barcode? data;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => CheckinRepository(),
      child: SafeArea(
        top: true,
        bottom: true,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Scan mã thanh toán'),
            titleTextStyle: AppText.appbarTitleText1,
            centerTitle: true,
            toolbarHeight: AppSize.heightScreen / 12,
            backgroundColor: Colors.transparent,

            flexibleSpace: Container(
              height: AppSize.heightScreen / 12,
              decoration: AppBoxDecoration.boxDecorationWithGradientNoBorder1,
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(AppSize.widthScreen / 40),
            decoration: BoxDecoration(
              color: AppColor.primaryColor2,
              borderRadius: BorderRadius.circular(AppSize.widthScreen / 40),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: AppSize.heightScreen / 1.5,
                        width: AppSize.widthScreen / 1.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(AppSize.widthScreen / 20),
                        ),

                        child: QRView(
                          key: _globalKey,
                          onQRViewCreated: (QRViewController controller) {
                            this.controller = controller;
                            controller.scannedDataStream.listen((event) {
                              setState(() {
                                data = event;
                                controller.pauseCamera();
                                List<String> content = StringSplitter.split(data!.code!, splitters: [' - ']);
                                if (content.length == 3) {
                                  showDialog(
                                    barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext builderContext) {
                                        return FutureBuilder<UserInfo?> (
                                            future: CheckinRepository().postCheckin(
                                                int.parse(content[0]), content[1], content[2]
                                            ),
                                            builder: (context, snapshot)  {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Text('Đang xử lý'),
                                                  content: SingleChildScrollView(
                                                    child: Container(
                                                      height: AppSize.widthScreen /10,
                                                      width: AppSize.widthScreen /10,
                                                      child: CircularProgressIndicator(
                                                          color: AppColor.primaryColor1,
                                                          strokeWidth: 2.0
                                                      ),
                                                    )
                                                  ),
                                                );
                                              }

                                              if (snapshot.hasData) {

                                                _timer = Timer(Duration(seconds: 3), () {
                                                  Navigator.of(context).pop();
                                                  controller.resumeCamera();
                                                });

                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Text('Thông tin khách hàng'),
                                                  content: SingleChildScrollView(
                                                    child: Container(
                                                      width: AppSize.widthScreen / 1.2,
                                                      height: AppSize.heightScreen / 3,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: SizedBox()
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text("Khách hàng: " + snapshot!.data!.fullName!, maxLines: 2, overflow: TextOverflow.ellipsis),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text("Sđt: " + snapshot!.data!.username!),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text("Phương thức thanh toán: " + snapshot!.data!.paymentMethod!, maxLines: 2, overflow: TextOverflow.ellipsis),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text("Số lượt còn: " + snapshot!.data!.turn!.toString()),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child:  Text("Số tiền còn: " + snapshot!.data!.balance!.toString()),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ),
                                                );
                                              } else {
                                                _timer = Timer(Duration(seconds: 2), () {
                                                  Navigator.of(context).pop();
                                                  controller.resumeCamera();
                                                });
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Text('Lỗi'),
                                                  content: SingleChildScrollView(
                                                    child: Text('Đã xảy ra lỗi!'),
                                                  ),
                                                );
                                              }
                                            });
                                      }
                                  ).then((val){
                                    if (_timer.isActive) {
                                      _timer.cancel();
                                    }
                                  });
                                  data = null;
                                }
                                else if (content.length == 1) {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext builderContext) {
                                        return FutureBuilder<UserInfo?> (
                                            future: CheckinRepository().postCheckinWithStaticQR(
                                                int.parse(content[0])
                                            ),
                                            builder: (context, snapshot)  {
                                              if (snapshot.connectionState == ConnectionState.waiting) {
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Text('Đang xử lý'),
                                                  content: SingleChildScrollView(
                                                      child: Container(
                                                        height: AppSize.widthScreen /10,
                                                        width: AppSize.widthScreen /10,
                                                        child: CircularProgressIndicator(
                                                            color: AppColor.primaryColor1,
                                                            strokeWidth: 2.0
                                                        ),
                                                      )
                                                  ),
                                                );
                                              }

                                              if (snapshot.hasData) {

                                                _timer = Timer(Duration(seconds: 3), () {
                                                  Navigator.of(context).pop();
                                                  controller.resumeCamera();
                                                });

                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Text('Thông tin khách hàng'),
                                                  content: SingleChildScrollView(
                                                      child: Container(
                                                        width: AppSize.widthScreen / 1.2,
                                                        height: AppSize.heightScreen / 3,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Expanded(
                                                                flex: 1,
                                                                child: SizedBox()
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text("Khách hàng: " + snapshot!.data!.fullName!, maxLines: 2, overflow: TextOverflow.ellipsis),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text("Sđt: " + snapshot!.data!.username!),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text("Phương thức thanh toán: " + snapshot!.data!.paymentMethod!, maxLines: 2, overflow: TextOverflow.ellipsis),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child: Text("Số lượt còn: " + snapshot!.data!.turn!.toString()),
                                                            ),
                                                            Expanded(
                                                              flex: 1,
                                                              child:  Text("Số tiền còn: " + snapshot!.data!.balance!.toString()),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                  ),
                                                );
                                              } else {
                                                _timer = Timer(Duration(seconds: 2), () {
                                                  Navigator.of(context).pop();
                                                  controller.resumeCamera();
                                                });
                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Text('Lỗi'),
                                                  content: SingleChildScrollView(
                                                    child: Text('Đã xảy ra lỗi!'),
                                                  ),
                                                );
                                              }
                                            });
                                      }
                                  ).then((val){
                                    if (_timer.isActive) {
                                      _timer.cancel();
                                    }
                                  });
                                  data = null;
                                }
                                else {
                                  showDialog<void>(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      _timer = Timer(Duration(seconds: 3), () {
                                        Navigator.of(context).pop();
                                        controller.resumeCamera();
                                      });
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        title: Text('Lỗi'),
                                        content: SingleChildScrollView(
                                          child: Text('Đã xảy ra lỗi!'),
                                        ),
                                      );
                                    },
                                  ).then((val){
                                    if (_timer.isActive) {
                                      _timer.cancel();
                                    }
                                  });
                                }
                              });
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 40,),
                      Center(
                        child: Text('Quét mã thanh toán'),
                      ),
                      SizedBox(height: 40,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      )
      );
  }
}

