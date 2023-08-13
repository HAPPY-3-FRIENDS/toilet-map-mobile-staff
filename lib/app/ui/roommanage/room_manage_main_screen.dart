import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap_staff/app/models/toiletService/toilet_service.dart';
import 'package:toiletmap_staff/app/models/userInfo/user_info.dart';
import 'package:toiletmap_staff/app/repositories/checkin_repository.dart';
import 'package:toiletmap_staff/app/repositories/room_repository.dart';
import 'package:toiletmap_staff/app/repositories/toilet_service_repository.dart';
import 'package:toiletmap_staff/app/ui/roommanage/room_lock_screen.dart';
import 'package:toiletmap_staff/app/ui/roommanage/room_status_screen.dart';

import '../../models/room/room.dart';
import '../../models/roomAll/room_all.dart';
import '../../models/roomStatus/room_status.dart';
import '../../utils/Routes.dart';
import '../../utils/constants.dart';

class RoomManageMainScreen extends StatefulWidget {
  RoomAll roomAll;

  RoomManageMainScreen({Key? key, required this.roomAll}) : super(key: key);

  @override
  State<RoomManageMainScreen> createState() => _RoomManageMainScreenState();
}

class _RoomManageMainScreenState extends State<RoomManageMainScreen> with TickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);

    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(150.h),
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

                title: Text('Quản lý phòng'),
                titleTextStyle: AppText.appbarTitleText2,
                centerTitle: true,
                toolbarHeight: 150.h,
                backgroundColor: Colors.white,
                elevation: 0,

                iconTheme: IconThemeData(
                    color: AppColor.primaryColor1
                ),

                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(40.h),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Center(
                      child: TabBar(
                        indicatorPadding: EdgeInsets.zero,
                        indicator: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: AppColor.primaryColor1,
                                  width: 2.h
                              )
                          ),
                        ),
                        controller: tabController,
                        isScrollable: true,

                        labelPadding: EdgeInsets.symmetric(horizontal: 25.w),
                        tabs: [
                          Tab(child: Text("Cập nhật tình trạng phòng",),),
                          Tab(child: Text("Khóa phòng"),),
                        ],
                        labelStyle: AppText.titleText3,
                        labelColor: AppColor.primaryColor1,
                        unselectedLabelColor: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Container(
            color: Color(0xFFF1F1F1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        RoomStatusScreen(roomStatus: widget.roomAll.roomStatus),
                        RoomLockScreen(room: widget.roomAll.room),
                      ],
                    ))
              ],
            ),
          )
      ),
    );
  }
}
