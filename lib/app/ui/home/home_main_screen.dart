import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:toiletmap_staff/app/models/roomAll/room_all.dart';
import 'package:toiletmap_staff/app/models/roomStatus/room_status.dart';
import 'package:toiletmap_staff/app/repositories/checkin_repository.dart';
import 'package:toiletmap_staff/app/repositories/room_repository.dart';
import 'package:toiletmap_staff/app/repositories/toilet_repository.dart';
import 'package:toiletmap_staff/app/ui/home/widgets/home_main_button_widget.dart';
import 'package:toiletmap_staff/app/ui/toilet/toilet_widget.dart';
import 'package:toiletmap_staff/app/utils/routes.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../models/room/room.dart';
import '../../models/toilet/toilet.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        bottom: true,
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              appBar: AppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r)),
                ),
                elevation: 0,
                titleSpacing: 0,

                automaticallyImplyLeading: false,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r)),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[AppColor.gradientColor1, AppColor.gradientColor2]),
                  ),
                ),

                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(230.h),
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
                                width: 140.w,
                                height: 140.w,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot!.data!.toiletImageSources[0]),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all( Radius.circular(70.w)),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Text(snapshot!.data!.toiletName, style: AppText.titleText1,),
                              ),
                              SizedBox(height: 20.h,),
                            ],
                          );
                        }
                        return Center(child: Text('Lỗi'));
                      }),
                ),
              ),
              body: Container(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
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
                            function: () => {
                              Navigator.pushNamed(context, Routes.passerbyMainScreen)
                            }
                        ),
                        HomeMainButtonWidget(
                            icon: Icons.login_outlined,
                            text: "Nạp tiền",
                            function: () => {
                              Navigator.pushNamed(context, Routes.topupMainScreen)
                            }
                        ),
                        //Hide for Enterprise
                        HomeMainButtonWidget(
                            icon: Icons.room_preferences,
                            text: "Quản lý phòng",
                            function: () async {
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.loading,
                                  title: 'Đang tải dữ liệu',
                                  barrierDismissible: false
                              );
                              Room? room = await RoomRepository().getRoomInformation();
                              RoomStatus? roomStatus = await RoomRepository().getRoomStatusInformation();
                              RoomAll roomAll = RoomAll(room!, roomStatus!);
                              Navigator.pop(context);
                              Navigator.pushNamed(context, Routes.roomManageMainScreen, arguments: roomAll);
                            }
                        ),
                        HomeMainButtonWidget(
                            icon: Icons.search,
                            text: "Tìm kiếm NVS",
                            function: () async {
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.loading,
                                  title: 'Đang tải dữ liệu',
                                  barrierDismissible: false
                              );
                              Toilet? toilet = await ToiletRepository().getNearestToilet();
                              Navigator.pop(context);
                              if (toilet != null) {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        content: ToiletWidget(toilet: toilet!,)
                                    );
                                  },
                                );
                              } else {
                                showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Chú ý'),
                                      content: const Text('Không tìm thấy Nhà vệ sinh!'),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Xác nhận'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
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
                              Navigator.of(context).pushNamed(Routes.loginMainScreen);
                            } catch (error) {
                              print(error);
                            }
                          },
                        ),
                      ],
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 20.w, crossAxisSpacing: 10.w),
                    ),
                  )
              )
          ),
        )
    );
  }
}
