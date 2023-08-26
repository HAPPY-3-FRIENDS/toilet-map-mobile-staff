import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap_staff/app/models/toiletService/toilet_service.dart';
import 'package:toiletmap_staff/app/models/userInfo/user_info.dart';
import 'package:toiletmap_staff/app/repositories/checkin_repository.dart';
import 'package:toiletmap_staff/app/repositories/toilet_service_repository.dart';

import '../../utils/Routes.dart';
import '../../utils/constants.dart';

class PasserbyMainScreen extends StatefulWidget {
  const PasserbyMainScreen({Key? key}) : super(key: key);

  @override
  State<PasserbyMainScreen> createState() => _PasserbyMainScreenState();
}

class _PasserbyMainScreenState extends State<PasserbyMainScreen> {
  TextEditingController service1Controller = TextEditingController();
  TextEditingController service2Controller = TextEditingController();
  TextEditingController service3Controller = TextEditingController();
  int peoplenumber1 = 0;
  int peoplenumber2 = 0;
  int peoplenumber3 = 0;
  int total = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    service1Controller.addListener(() => setState(() {
    }));
    service2Controller.addListener(() => setState(() {
    }));
    service3Controller.addListener(() => setState(() {
    }));
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

              title: Text('Khách vãng lai'),
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
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: FutureBuilder<List<ToiletService>?> (
                future: ToiletServiceRepository().getToiletService(),
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
                    if (snapshot!.data!.length == 3) {
                      total = snapshot!.data![0].service.price * peoplenumber1 + snapshot!.data![1].service.price * peoplenumber2 + snapshot!.data![2].service.price * peoplenumber3;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(10000) + " VNĐ", style: AppText.passerByText1,),
                                    Text('Dịch vụ', style: AppText.passerByText1),
                                    Text('Nhập số lượng (người)', style: AppText.passerByText1),
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
                                    //Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(10000) + " VNĐ", style: AppText.passerByText1,),
                                    Text(snapshot!.data![0].service.name, style: AppText.passerByText1),
                                    Container(
                                      height: 35.h,
                                      width: 120.w,
                                      child: TextField(
                                        onSubmitted: (value) => setState(() => peoplenumber1 = int.parse(value)),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
                                          hintText: peoplenumber1.toString(),
                                          hintStyle: AppText.passerByText2,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4.5.w)
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(10000) + " VNĐ", style: AppText.passerByText1,),
                                    Text(snapshot!.data![1].service.name, style: AppText.passerByText1),
                                    Container(
                                      height: 35.h,
                                      width: 120.w,
                                      child: TextField(
                                        onSubmitted: (value) => setState(() => peoplenumber2 = int.parse(value)),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
                                          hintText: peoplenumber2.toString(),
                                          hintStyle: AppText.passerByText2,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4.5.w)
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(10000) + " VNĐ", style: AppText.passerByText1,),
                                    Text(snapshot!.data![2].service.name, style: AppText.passerByText1),
                                    Container(
                                      height: 35.h,
                                      width: 120.w,
                                      child: TextField(
                                        onSubmitted: (value) => setState(() => peoplenumber3 = int.parse(value)),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
                                          hintText: peoplenumber3.toString(),
                                          hintStyle: AppText.passerByText2,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4.5.w)
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Divider(
                                  height: 5,
                                  color: AppColor.primaryColor2,
                                ),
                                SizedBox(height: 20.h,),
                                Table(
                                  border: TableBorder.all(),
                                  columnWidths: {
                                    0: FractionColumnWidth(0.4),
                                    1: FractionColumnWidth(0.2),
                                    2: FractionColumnWidth(0.2),
                                    3: FractionColumnWidth(0.2),
                                  },
                                  children: [
                                    buildRow(['Dịch vụ', 'Đơn giá (VNĐ)', 'Số người', 'Thành tiền (VNĐ)'], isHeader: true),
                                    buildRow([snapshot!.data![0].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![0].service.price), peoplenumber1.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![0].service.price * peoplenumber1)]),
                                    buildRow([snapshot!.data![1].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![1].service.price), peoplenumber2.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![1].service.price * peoplenumber2)]),
                                    buildRow([snapshot!.data![2].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![2].service.price), peoplenumber3.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![2].service.price * peoplenumber3)]),
                                    //buildRow([snapshot!.data![2].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![2].service.price), peoplenumber3.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![2].service.price * peoplenumber3)]),
                                  ],
                                ),
                                SizedBox(height: 40.h,),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.w),
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Tổng tiền", style: AppText.passerByText1,),
                                      Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(total) + " VNĐ", style: AppText.passerByText1),
                                    ],
                                  ),),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 60.h,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: AppColor.primaryColor1,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.r))),
                                        onPressed: () async {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext builderContext) {
                                                return FutureBuilder<UserInfo?> (
                                                    future: CheckinRepository().postCheckinsThreeServices(
                                                        snapshot!.data![0].service.name, peoplenumber1, snapshot!.data![1].service.name, peoplenumber2, snapshot!.data![2].service.name, peoplenumber3
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
                                                        if (snapshot.data!.fullName == "Khách vãng lai") {
                                                          return AlertDialog(
                                                            backgroundColor: Colors.white,
                                                            title: Text('Khách vãng lai'),
                                                            content: SingleChildScrollView(
                                                              child: Text('Đã thu: ' + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(total) + " VNĐ"),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: const Text('Xác nhận'),
                                                                onPressed: () {
                                                                  Navigator.pushNamed(context, Routes.homeMainScreen);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        } else {
                                                          return AlertDialog(
                                                            backgroundColor: Colors.white,
                                                            title: Text('Check-in thất bại!'),
                                                            content: SingleChildScrollView(
                                                              child: Text(snapshot.data!.fullName!),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: const Text('Xác nhận'),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                      } else {
                                                        return AlertDialog(
                                                          backgroundColor: Colors.white,
                                                          title: Text('Lỗi'),
                                                          content: SingleChildScrollView(
                                                            child: Text('Đã xảy ra lỗi!'),
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text('Xác nhận'),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                    });
                                              });
                                        },
                                        child: Text((total == 0) ? "Xác nhận thu tiền" : "Xác nhận thu tiền - " + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(total) + " VNĐ", style: TextStyle(color: Colors.white),)
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      );
                    }
                    if (snapshot!.data!.length == 2) {
                      total = snapshot!.data![0].service.price * peoplenumber1 + snapshot!.data![1].service.price * peoplenumber2;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Text(NumberFormat.cur
                                    // rency(locale: "en_US", decimalDigits: 0, symbol: "").format(10000) + " VNĐ", style: AppText.passerByText1,),
                                    Text('Dịch vụ', style: AppText.passerByText1),
                                    Text('Nhập số lượng (người)', style: AppText.passerByText1),
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
                                    //Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(10000) + " VNĐ", style: AppText.passerByText1,),
                                    Text(snapshot!.data![0].service.name, style: AppText.passerByText1),
                                    Container(
                                      height: 35.h,
                                      width: 120.w,
                                      child: TextField(
                                        onSubmitted: (value) => setState(() => peoplenumber1 = int.parse(value)),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
                                          hintText: peoplenumber1.toString(),
                                          hintStyle: AppText.passerByText2,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4.5.w)
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(10000) + " VNĐ", style: AppText.passerByText1,),
                                    Text(snapshot!.data![1].service.name, style: AppText.passerByText1),
                                    Container(
                                      height: 35.h,
                                      width: 120.w,
                                      child: TextField(
                                        onSubmitted: (value) => setState(() => peoplenumber2 = int.parse(value)),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
                                          hintText: peoplenumber2.toString(),
                                          hintStyle: AppText.passerByText2,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4.5.w)
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Divider(
                                  height: 5,
                                  color: AppColor.primaryColor2,
                                ),
                                SizedBox(height: 20.h,),
                                Table(
                                  border: TableBorder.all(),
                                  columnWidths: {
                                    0: FractionColumnWidth(0.4),
                                    1: FractionColumnWidth(0.2),
                                    2: FractionColumnWidth(0.2),
                                    3: FractionColumnWidth(0.2),
                                  },
                                  children: [
                                    buildRow(['Dịch vụ', 'Đơn giá (VNĐ)', 'Số người', 'Thành tiền (VNĐ)'], isHeader: true),
                                    buildRow([snapshot!.data![0].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![0].service.price), peoplenumber1.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![0].service.price * peoplenumber1)]),
                                    buildRow([snapshot!.data![1].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![1].service.price), peoplenumber2.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![1].service.price * peoplenumber2)]),
                                  ],
                                ),
                                SizedBox(height: 40.h,),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.w),
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Tổng tiền", style: AppText.passerByText1,),
                                      Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(total) + " VNĐ", style: AppText.passerByText1),
                                    ],
                                  ),),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 60.h,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: AppColor.primaryColor1,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.r))),
                                        onPressed: () async {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext builderContext) {
                                                return FutureBuilder<UserInfo?> (
                                                    future: CheckinRepository().postCheckinsTwoServices(
                                                        snapshot!.data![0].service.name, peoplenumber1, snapshot!.data![1].service.name, peoplenumber2
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
                                                        if (snapshot.data!.fullName == "Khách vãng lai") {
                                                          return AlertDialog(
                                                            backgroundColor: Colors.white,
                                                            title: Text('Khách vãng lai'),
                                                            content: SingleChildScrollView(
                                                              child: Text('Đã thu: ' + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(total) + " VNĐ"),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: const Text('Xác nhận'),
                                                                onPressed: () {
                                                                  Navigator.pushNamed(context, Routes.homeMainScreen);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        } else {
                                                          return AlertDialog(
                                                            backgroundColor: Colors.white,
                                                            title: Text('Check-in thất bại!'),
                                                            content: SingleChildScrollView(
                                                              child: Text(snapshot.data!.fullName!),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: const Text('Xác nhận'),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                      } else {
                                                        return AlertDialog(
                                                          backgroundColor: Colors.white,
                                                          title: Text('Lỗi'),
                                                          content: SingleChildScrollView(
                                                            child: Text('Đã xảy ra lỗi!'),
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text('Xác nhận'),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                    });
                                              });
                                        },
                                        child: Text((total == 0) ? "Xác nhận thu tiền" : "Xác nhận thu tiền - " + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(total) + " VNĐ", style: TextStyle(color: Colors.white),)
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      );
                    }
                    if (snapshot!.data!.length == 1) {
                      total = snapshot!.data![0].service.price * peoplenumber1;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(10000) + " VNĐ", style: AppText.passerByText1,),
                                    Text('Dịch vụ', style: AppText.passerByText1),
                                    Text('Nhập số lượng (người)', style: AppText.passerByText1),
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
                                    //Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(10000) + " VNĐ", style: AppText.passerByText1,),
                                    Text(snapshot!.data![0].service.name, style: AppText.passerByText1),
                                    Container(
                                      height: 35.h,
                                      width: 120.w,
                                      child: TextField(
                                        onSubmitted: (value) => setState(() => peoplenumber1 = int.parse(value)),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 0),
                                          hintText: peoplenumber1.toString(),
                                          hintStyle: AppText.passerByText2,
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(4.5.w)
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20.h,),
                                Divider(
                                  height: 5,
                                  color: AppColor.primaryColor2,
                                ),
                                SizedBox(height: 20.h,),
                                Table(
                                  border: TableBorder.all(),
                                  columnWidths: {
                                    0: FractionColumnWidth(0.4),
                                    1: FractionColumnWidth(0.2),
                                    2: FractionColumnWidth(0.2),
                                    3: FractionColumnWidth(0.2),
                                  },
                                  children: [
                                    buildRow(['Dịch vụ', 'Đơn giá (VNĐ)', 'Số người', 'Thành tiền (VNĐ)'], isHeader: true),
                                    buildRow([snapshot!.data![0].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![0].service.price), peoplenumber1.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![0].service.price * peoplenumber1)]),
                                    //buildRow([snapshot!.data![2].service.name, NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![2].service.price), peoplenumber3.toString(), NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(snapshot!.data![2].service.price * peoplenumber3)]),
                                  ],
                                ),
                                SizedBox(height: 40.h,),
                              ],
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.w),
                              child: Column(
                                children: [
                                  Padding(padding: EdgeInsets.symmetric(horizontal: 10.w),child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Tổng tiền", style: AppText.passerByText1,),
                                      Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(total) + " VNĐ", style: AppText.passerByText1),
                                    ],
                                  ),),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 60.h,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: AppColor.primaryColor1,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.r))),
                                        onPressed: () async {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (BuildContext builderContext) {
                                                return FutureBuilder<UserInfo?> (
                                                    future: CheckinRepository().postCheckinsOneService(
                                                        snapshot!.data![0].service.name, peoplenumber1
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
                                                        if (snapshot.data!.fullName == "Khách vãng lai") {
                                                          return AlertDialog(
                                                            backgroundColor: Colors.white,
                                                            title: Text('Khách vãng lai'),
                                                            content: SingleChildScrollView(
                                                              child: Text('Đã thu: ' + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(total) + " VNĐ"),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: const Text('Xác nhận'),
                                                                onPressed: () {
                                                                  Navigator.pushNamed(context, Routes.homeMainScreen);
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        } else {
                                                          return AlertDialog(
                                                            backgroundColor: Colors.white,
                                                            title: Text('Check-in thất bại!'),
                                                            content: SingleChildScrollView(
                                                              child: Text(snapshot.data!.fullName!),
                                                            ),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                child: const Text('Xác nhận'),
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        }
                                                      } else {
                                                        return AlertDialog(
                                                          backgroundColor: Colors.white,
                                                          title: Text('Lỗi'),
                                                          content: SingleChildScrollView(
                                                            child: Text('Đã xảy ra lỗi!'),
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: const Text('Xác nhận'),
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                    });
                                              });
                                        },
                                        child: Text((total == 0) ? "Xác nhận thu tiền" : "Xác nhận thu tiền - " + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(total) + " VNĐ", style: TextStyle(color: Colors.white),)
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      );
                    }
                  }
                  return Center(child: Text('Lỗi'));
                }),
          ),
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
