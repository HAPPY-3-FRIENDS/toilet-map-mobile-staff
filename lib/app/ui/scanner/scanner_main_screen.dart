
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.h),
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 20.h),
              child: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_rounded,
                    color: AppColor.primaryColor1,
                  ),
                ),

                title: Text('Quét mã thanh toán'),
                titleTextStyle: AppText.appbarTitleText2,
                centerTitle: true,
                toolbarHeight: 100.h,
                backgroundColor: Colors.white,
                elevation: 0,

                iconTheme: IconThemeData(
                    color: AppColor.primaryColor1
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: 800.h,
              child: QRView(
                overlay: QrScannerOverlayShape(
                    borderRadius: 20.r,
                    borderLength: 40.w,
                    borderWidth: 5.r,
                    borderColor: AppColor.primaryColor1,
                    cutOutHeight: 400.w,
                    cutOutWidth: 300.w,
                  cutOutBottomOffset: 70.h
                ),
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
                                        alignment: Alignment.center,
                                        title: Text('Đang xử lý'),
                                        content: SingleChildScrollView(
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                  color: AppColor.primaryColor1,
                                                  strokeWidth: 2.0
                                              ),
                                            )
                                        ),
                                      );
                                    }

                                    if (snapshot.hasData) {
                                      _timer = Timer(Duration(seconds: 2), () {
                                        Navigator.of(context).pop();
                                        controller.resumeCamera();
                                      });

                                      if (snapshot!.data!.accountId == 0) {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: Text('Lỗi'),
                                          content: SingleChildScrollView(
                                            child: Text(snapshot!.data!.fullName!),
                                          ),
                                        );
                                      } else {
                                        return AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: Text('Thông tin khách hàng'),
                                          content: SingleChildScrollView(
                                              child: Container(
                                                width: 300.w,
                                                height: 300.h,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                        flex: 1,
                                                        child: SizedBox()
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text("Khách hàng: " + snapshot!.data!.fullName!, maxLines: 2, overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text("Sđt: " + snapshot!.data!.username!),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text("Phương thức thanh toán: " + snapshot!.data!.defaultPayment!, maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20.sp
                                                      ),),
                                                    ),

                                                    (snapshot!.data!.defaultPayment! == "Số lượt") ?
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text("Số lượt còn: " + snapshot!.data!.accountTurn!.toString(),
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20.sp
                                                        ),
                                                      ),
                                                    )
                                                        :
                                                    Expanded(
                                                      flex: 1,
                                                      child:  Text("Số tiền còn: " +
                                                          NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data!.accountBalance!) + " VNĐ",
                                                        style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 20.sp
                                                        ),),
                                                    ),

                                                    (snapshot!.data!.defaultPayment! == "Số lượt") ?
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text("Số tiền còn: " + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data!.accountBalance!) + " VNĐ",),
                                                    )
                                                        :
                                                    Expanded(
                                                      flex: 1,
                                                      child:  Text("Số lượt còn: " + snapshot!.data!.accountBalance!.toString(),),
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ),
                                        );
                                      }
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
                        try {
                          int test = int.parse(content[0]);
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
                                              child: Center(
                                                child: CircularProgressIndicator(
                                                    color: AppColor.primaryColor1,
                                                    strokeWidth: 2.0
                                                ),
                                              )
                                          ),
                                        );
                                      }

                                      if (snapshot.hasData) {

                                        _timer = Timer(Duration(seconds: 2), () {
                                          Navigator.of(context).pop();
                                          controller.resumeCamera();
                                        });

                                        if (snapshot!.data!.accountId == 0) {
                                          return AlertDialog(
                                            backgroundColor: Colors.white,
                                            title: Text('Lỗi'),
                                            content: SingleChildScrollView(
                                              child: Text(snapshot!.data!.fullName!),
                                            ),
                                          );
                                        } else {
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
                                                        child: Text("Khách hàng: " + snapshot!.data!.fullName!, maxLines: 2, overflow: TextOverflow.ellipsis,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text("Sđt: " + snapshot!.data!.username!),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text("Phương thức thanh toán: " + snapshot!.data!.defaultPayment!, maxLines: 2, overflow: TextOverflow.ellipsis,style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: AppSize.heightScreen/40
                                                        ),),
                                                      ),

                                                      (snapshot!.data!.defaultPayment! == "Số lượt") ?
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text("Số lượt còn: " + snapshot!.data!.accountTurn!.toString(),
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: AppSize.heightScreen/40
                                                          ),
                                                        ),
                                                      )
                                                          :
                                                      Expanded(
                                                        flex: 1,
                                                        child:  Text("Số tiền còn: " + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data!.accountBalance!) + " VNĐ",
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: AppSize.heightScreen/40
                                                          ),),
                                                      ),

                                                      (snapshot!.data!.defaultPayment! == "Số lượt") ?
                                                      Expanded(
                                                        flex: 1,
                                                        child: Text("Số tiền còn: " + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data!.accountBalance!) + " VNĐ",),
                                                      )
                                                          :
                                                      Expanded(
                                                        flex: 1,
                                                        child:  Text("Số lượt còn: " + snapshot!.data!.accountBalance!.toString(),),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            ),
                                          );
                                        }
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
                        } catch (e) {
                          showDialog<void>(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              _timer = Timer(Duration(seconds: 2), () {
                                Navigator.of(context).pop();
                                controller.resumeCamera();
                              });
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text('Lỗi'),
                                content: SingleChildScrollView(
                                  child: Text('Mã QR không đúng!'),
                                ),
                              );
                            },
                          ).then((val){
                            if (_timer.isActive) {
                              _timer.cancel();
                            }
                          });
                          data = null;
                        }
                      }
                      else {
                        showDialog<void>(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) {
                            _timer = Timer(Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                              controller.resumeCamera();
                            });
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              title: Text('Lỗi'),
                              content: SingleChildScrollView(
                                child: Text('Mã QR không đúng!'),
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
          ),
        ),
      )
      );
  }
}

