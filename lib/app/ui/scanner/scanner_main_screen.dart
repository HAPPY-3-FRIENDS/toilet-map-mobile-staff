
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rate_limiter/rate_limiter.dart';
import 'package:toiletmap_staff/app/repositories/checkin_repository.dart';
import 'package:toiletmap_staff/app/utils/constants.dart';
import 'package:string_splitter/string_splitter.dart';

class ScannerMainScreen extends StatefulWidget {
  const ScannerMainScreen({Key? key}) : super(key: key);

  @override
  State<ScannerMainScreen> createState() => _ScannerMainScreenState();
}

class _ScannerMainScreenState extends State<ScannerMainScreen> {
/*String data="";
  Future _qrScanner() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      String? qrdata = await scanner.scan();
      print('look at me ' + qrdata!);
      data = qrdata;
    } else {
      var isGrant = await Permission.camera.request();

      if(isGrant.isGranted) {
        String? qrdata = await scanner.scan();
        print('look at me ' + qrdata!);
        data = qrdata;
      }
    }
  }*/

  final GlobalKey _globalKey = GlobalKey();
  QRViewController? controller;
  Barcode? data;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => CheckinRepository(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Quét mã'),
            centerTitle: true,
          ),
          body: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColor.primaryColor2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 350,
                          width: 270,
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
                                        context: context,
                                        builder: (BuildContext builderContext) {
                                          return FutureBuilder<int?> (
                                              future: CheckinRepository().postCheckinFake(
                                                  int.parse(content[0]), content[1], content[2]
                                              ),
                                              builder: (context, snapshot)  {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return AlertDialog(
                                                    backgroundColor: Colors.white,
                                                    title: Text('Đang xử lý'),
                                                    content: SingleChildScrollView(
                                                      child: CircularProgressIndicator(
                                                          color: AppColor.primaryColor1,
                                                          strokeWidth: 2.0
                                                      ),
                                                    ),
                                                  );
                                                }
                                                if (snapshot.hasData) {

                                                  _timer = Timer(Duration(seconds: 200), () {
                                                    Navigator.of(context).pop();
                                                    controller.resumeCamera();
                                                  });

                                                  return AlertDialog(
                                                          backgroundColor: Colors.white,
                                                          title: Text('Thông tin khách hàng'),
                                                          content: SingleChildScrollView(
                                                            child: Text('Content'),
                                                          ),
                                                        );
                                                };

                                                return AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  title: Text('Lỗi'),
                                                  content: SingleChildScrollView(
                                                    child: Text('Đã xảy ra lỗi!'),
                                                  ),
                                                );
                                              });
                                        }
                                    ).then((val){
                                      if (_timer.isActive) {
                                        _timer.cancel();
                                      }
                                    });
                                    data = null;
                                  }
                                });
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 40,),
                        Center(
                          child: (data != null) ? Text('${data!.code}', style: TextStyle(fontSize: 16),) : Text('Scan a code'),
                        ),
                        SizedBox(height: 40,),
                      ],
                    ),

                    /*BlocBuilder <CheckinBloc, CheckinState>(
                        builder: (context, state) {
                          if (state is CheckinErrorState) {
                            return Column(
                              children: [
                                Container(
                                  height: 220,
                                  width: 220,
                                  child: QRView(
                                    key: _globalKey,
                                    onQRViewCreated: (QRViewController controller) {
                                      this.controller = controller;
                                      controller.scannedDataStream.listen((event) {
                                        setState(() {
                                          data = event;
                                          List<String> content = StringSplitter.split(data!.code!, splitters: [' - ']);
                                          if (content.length == 3) {
                                                context.read<CheckinBloc>().add(CreateCheckinEvent(1, int.parse(content.elementAt(0)), content.elementAt(1), DateTime.parse(content.elementAt(2))));
                                            data = null;
                                          }
                                        });
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 40,),
                                Center(
                                  child: (data != null) ? Text('${data!.code}', style: TextStyle(fontSize: 16),) : Text('Scan a code'),
                                ),
                                SizedBox(height: 40,),
                                Text(state.message, style: TextStyle(fontSize: 16, color: Colors.red),),
                              ],
                            );
                          } else if (state is CheckinCreatedState) {
                            return Column(
                              children: [
                                Container(
                                  height: 220,
                                  width: 220,
                                  child: QRView(
                                    key: _globalKey,
                                    onQRViewCreated: (QRViewController controller) {
                                      this.controller = controller;
                                      controller.scannedDataStream.listen((event) {
                                        setState(() {
                                          data = event;
                                          List<String> content = StringSplitter.split(data!.code!, splitters: [' - ']);
                                          if (content.length == 3) {
                                            context.read<CheckinBloc>().add(CreateCheckinEvent(1, int.parse(content.elementAt(0)), content.elementAt(1), DateTime.parse(content.elementAt(2))));
                                            data = null;
                                          }
                                        });
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 40,),
                                Center(
                                  child: (data != null) ? Text('${data!.code}', style: TextStyle(fontSize: 16),) : Text('Scan a code'),
                                ),
                                SizedBox(height: 40,),
                              ],
                            );
                          }
                        }
                    ),*/
                  ],
                ),
              ),
            ),
          )
      );
  }
}

