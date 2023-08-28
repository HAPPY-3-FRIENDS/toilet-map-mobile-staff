import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap_staff/app/models/roomStatus/room_status.dart';
import 'package:toiletmap_staff/app/models/toiletService/toilet_service.dart';
import 'package:toiletmap_staff/app/models/userInfo/user_info.dart';
import 'package:toiletmap_staff/app/repositories/checkin_repository.dart';
import 'package:toiletmap_staff/app/repositories/room_repository.dart';
import 'package:toiletmap_staff/app/repositories/toilet_service_repository.dart';

import '../../models/room/room.dart';
import '../../utils/Routes.dart';
import '../../utils/constants.dart';

class RoomStatusScreen extends StatefulWidget {
  RoomStatus roomStatus;

  RoomStatusScreen({Key? key, required this.roomStatus}) : super(key: key);

  @override
  State<RoomStatusScreen> createState() => _RoomStatusScreenState();
}

class _RoomStatusScreenState extends State<RoomStatusScreen> {
  int numberOfRestroom = 0;
  int numberOfBathroom = 0;
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    numberOfRestroom = widget.roomStatus.numberOfRestroom - widget.roomStatus.numNotAvailableRestroom;
    numberOfBathroom = widget.roomStatus.numberOfBathroom - widget.roomStatus.numNotAvailableBathroom;
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
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
                      buildRow(['Loại phòng', 'Số phòng trống', 'Số phòng hoạt động'], isHeader: true),
                      buildRow(['Phòng vệ sinh', (widget.roomStatus.numberOfRestroom-widget.roomStatus.numNotAvailableRestroom).toString(), widget.roomStatus.numberOfRestroom.toString()]),
                      buildRow(['Phòng tắm', (widget.roomStatus.numberOfBathroom-widget.roomStatus.numNotAvailableBathroom).toString(), widget.roomStatus.numberOfBathroom.toString(),]),
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
                      Text('Nhập số lượng phòng trống', style: AppText.roommanageText1),
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
                            if (numberOfRestroom > widget.roomStatus.numberOfRestroom-widget.roomStatus.numNotAvailableRestroom) {
                              setState(() {
                                numberOfRestroom--;
                              });
                            }
                          }, icon: Icon(Icons.remove, size: 16.w, color: Colors.grey,)),
                          Container(
                            height: 35.h,
                            width: 60.w,
                            child: TextField(
                              readOnly: true,
                              textAlign: TextAlign.center,
                              onSubmitted: (value) => setState(() => numberOfRestroom = int.parse(value)),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
                                hintText: numberOfRestroom.toString(),
                                hintStyle: AppText.passerByText2,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.5.w)
                                ),
                              ),
                            ),
                          ),
                          IconButton(onPressed: () {
                            if (numberOfRestroom < widget.roomStatus.numberOfRestroom) {
                              setState(() {
                                numberOfRestroom++;
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
                            if (numberOfBathroom > widget.roomStatus.numberOfBathroom-widget.roomStatus.numNotAvailableBathroom) {
                              setState(() {
                                numberOfBathroom--;
                              });
                            }
                          }, icon: Icon(Icons.remove, size: 16.w, color: Colors.grey,)),
                          Container(
                            height: 35.h,
                            width: 60.w,
                            child: TextField(
                              readOnly: true,
                              textAlign: TextAlign.center,
                              onSubmitted: (value) => setState(() => numberOfBathroom = int.parse(value)),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
                                hintText: numberOfBathroom.toString(),
                                hintStyle: AppText.passerByText2,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.5.w)
                                ),
                              ),
                            ),
                          ),
                          IconButton(onPressed: () {
                            if (numberOfBathroom < widget.roomStatus.numberOfBathroom) {
                              setState(() {
                                numberOfBathroom++;
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
                                  int room = await RoomRepository().postRoomStatusInformation(widget.roomStatus.numberOfRestroom - numberOfRestroom, widget.roomStatus.numberOfBathroom - numberOfBathroom);
                                  if (room != 0) {
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
