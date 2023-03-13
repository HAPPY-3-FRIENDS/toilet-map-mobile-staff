import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:rate_limiter/rate_limiter.dart';
import 'package:toiletmap_staff/app/blocs/checkin/checkin_bloc.dart';
import 'package:toiletmap_staff/app/blocs/checkin/checkin_event.dart';
import 'package:toiletmap_staff/app/blocs/checkin/checkin_state.dart';
import 'package:toiletmap_staff/app/repositories/checkin_repository.dart';
import 'package:toiletmap_staff/app/utils/constants.dart';
import 'package:string_splitter/string_splitter.dart';

class ScannerMainScreen extends StatefulWidget {
  const ScannerMainScreen({Key? key}) : super(key: key);

  @override
  State<ScannerMainScreen> createState() => _ScannerMainScreenState();
}

class _ScannerMainScreenState extends State<ScannerMainScreen> {
  /*
  String data="";
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

/*  void qr*/

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => CheckinRepository(),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Quét mã'),
            centerTitle: true,
          ),
          body: BlocProvider<CheckinBloc>(
            create: (context) =>
                CheckinBloc(RepositoryProvider.of<CheckinRepository>(context)),
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColor.primaryColor2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocBuilder<CheckinBloc, CheckinState>(
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
                                            throttle(
                                                  () {
                                                context.read<CheckinBloc>().add(CreateCheckinEvent(1, int.parse(content.elementAt(0)), content.elementAt(1), DateTime.parse(content.elementAt(2))));
                                              },
                                              const Duration(seconds: 1),
                                            );
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
                                            throttle(
                                                  () {
                                                    context.read<CheckinBloc>().add(CreateCheckinEvent(1, int.parse(content.elementAt(0)), content.elementAt(1), DateTime.parse(content.elementAt(2))));
                                                    },
                                              const Duration(seconds: 1),
                                            );
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
                                          throttle(
                                                () {
                                              context.read<CheckinBloc>().add(CreateCheckinEvent(1, int.parse(content.elementAt(0)), content.elementAt(1), DateTime.parse(content.elementAt(2))));
                                            },
                                            const Duration(seconds: 1),
                                          );
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
                              CircularProgressIndicator(),
                            ],
                          );
                        }
                    ),
                  ],
                ),
              ),
            ),
          )
      )
    );
  }
}
