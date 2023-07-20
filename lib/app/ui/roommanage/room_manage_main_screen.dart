import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap_staff/app/models/toiletService/toilet_service.dart';
import 'package:toiletmap_staff/app/models/userInfo/user_info.dart';
import 'package:toiletmap_staff/app/repositories/checkin_repository.dart';
import 'package:toiletmap_staff/app/repositories/room_repository.dart';
import 'package:toiletmap_staff/app/repositories/toilet_service_repository.dart';

import '../../models/room/room.dart';
import '../../utils/Routes.dart';
import '../../utils/constants.dart';

class RoomManageMainScreen extends StatefulWidget {
  Room room;

  RoomManageMainScreen({Key? key, required this.room}) : super(key: key);

  @override
  State<RoomManageMainScreen> createState() => _RoomManageMainScreenState();
}

class _RoomManageMainScreenState extends State<RoomManageMainScreen> {
  int roomnumber1 = 0;
  int roomnumber2 = 0;
  int roomnumber3 = 0;
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    roomnumber1 = widget.room.numberOfRestroom;
    roomnumber2 = widget.room.numberOfBathroom;
    roomnumber3 = widget.room.numberOfDisabledRestroom;
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
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

                title: Text('Quản lý phòng'),
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
          body: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10.h,),
                      Table(
                        border: TableBorder.all(),
                        columnWidths: {
                          0: FractionColumnWidth(0.6),
                          1: FractionColumnWidth(0.2),
                          3: FractionColumnWidth(0.2),
                        },
                        children: [
                          buildRow(['Loại phòng', 'Số phòng hoạt động', 'Tổng số phòng'], isHeader: true),
                          buildRow(['Phòng vệ sinh', widget.room.numberOfRestroom.toString(), widget.room.maxNumberOfRestroom.toString()]),
                          buildRow(['Phòng tắm', widget.room.numberOfBathroom.toString(), widget.room.maxNumberOfBathroom.toString()]),
                          buildRow(['Phòng cho người khuyết tật', widget.room.numberOfDisabledRestroom.toString(), widget.room.maxNumberOfDisabledRestroom.toString()]),
                        ],
                      ),
                      SizedBox(height: 30.h,),
                      Divider(
                        height: 5,
                        color: AppColor.primaryColor2,
                      ),
                      SizedBox(height: 30.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(10000) + " VNĐ", style: AppText.passerByText1,),
                          Text('Loại phòng', style: AppText.roommanageText1),
                          Text('Nhập số lượng phòng hoạt động', style: AppText.roommanageText1),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Divider(
                        height: 5,
                        color: AppColor.primaryColor2,
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phòng vệ sinh', style: AppText.roommanageText2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed: () {
                                if (roomnumber1 > 0) {
                                  setState(() {
                                    roomnumber1--;
                                  });
                                }
                              }, icon: Icon(Icons.remove, size: 16.w, color: Colors.grey,)),
                              Container(
                                height: 35.h,
                                width: 60.w,
                                child: TextField(
                                  readOnly: true,
                                  textAlign: TextAlign.center,
                                  onSubmitted: (value) => setState(() => roomnumber1 = int.parse(value)),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
                                    hintText: roomnumber1.toString(),
                                    hintStyle: AppText.passerByText2,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4.5.w)
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(onPressed: () {
                                if (roomnumber1 < widget.room.maxNumberOfRestroom) {
                                  setState(() {
                                    roomnumber1++;
                                  });
                                }
                              }, icon: Icon(Icons.add, size: 16.w, color: Colors.grey,)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(10000) + " VNĐ", style: AppText.passerByText1,),
                          Text('Phòng tắm', style: AppText.roommanageText2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed: () {
                                if (roomnumber2 > 0) {
                                  setState(() {
                                    roomnumber2--;
                                  });
                                }
                              }, icon: Icon(Icons.remove, size: 16.w, color: Colors.grey,)),
                              Container(
                                height: 35.h,
                                width: 60.w,
                                child: TextField(
                                  readOnly: true,
                                  textAlign: TextAlign.center,
                                  onSubmitted: (value) => setState(() => roomnumber2 = int.parse(value)),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
                                    hintText: roomnumber2.toString(),
                                    hintStyle: AppText.passerByText2,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4.5.w)
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(onPressed: () {
                                if (roomnumber2 < widget.room.maxNumberOfBathroom) {
                                  setState(() {
                                    roomnumber2++;
                                  });
                                }
                              }, icon: Icon(Icons.add, size: 16.w, color: Colors.grey,)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Phòng cho người khuyết tật', style: AppText.roommanageText2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(onPressed: () {
                                if (roomnumber3 > 0) {
                                  setState(() {
                                    roomnumber3--;
                                  });
                                }
                              }, icon: Icon(Icons.remove, size: 16.w, color: Colors.grey,)),
                              Container(
                                height: 35.h,
                                width: 60.w,
                                child: TextField(
                                  readOnly: true,
                                  textAlign: TextAlign.center,
                                  onSubmitted: (value) => setState(() => roomnumber3 = int.parse(value)),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
                                    hintText: roomnumber3.toString(),
                                    hintStyle: AppText.passerByText2,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4.5.w)
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(onPressed: () {
                                if (roomnumber3 < widget.room.maxNumberOfDisabledRestroom) {
                                  setState(() {
                                    roomnumber3++;
                                  });
                                }
                              }, icon: Icon(Icons.add, size: 16.w, color: Colors.grey,)),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.w),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60.h,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: AppColor.primaryColor1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r))),
                          onPressed: () async {
                            showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Xác nhận'),
                                  content: const Text('Xác nhận các thay đổi!'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Xác nhận'),
                                      onPressed: () async {
                                        Room? room = await RoomRepository().postRoomInformation(widget.room.id, roomnumber1, roomnumber2, roomnumber3);
                                        if (room != null) {
                                          Navigator.pushNamed(context, Routes.homeMainScreen);
                                          showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thành công'),
                                                content: const Text('Thay đổi thông tin thành công!'),
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
                                        } else {
                                          Navigator.pushNamed(context, Routes.homeMainScreen);
                                          showDialog<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Thất bại'),
                                                content: const Text('Thay đổi thông tin thất bại!'),
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
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text("Xác nhận", style: TextStyle(color: Colors.white),)
                      ),
                    ),
                ),
              ],
            )
          )
      ),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
    decoration: BoxDecoration(
      color: isHeader ? AppColor.primaryColor2 : Colors.white,
    ),
    children: cells.map((cell) {
      final style = TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 16.sp,
      );

      return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        child: Center(child: Text(cell, style: style,),),
      );
    }).toList(),
  );
}
