
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:toiletmap_staff/app/models/userInfo/user_info.dart';
import 'package:toiletmap_staff/app/repositories/payment_repository.dart';
import 'package:toiletmap_staff/app/repositories/user_repository.dart';

import '../../utils/Routes.dart';
import '../../utils/constants.dart';

class TopupMainScreen extends StatefulWidget {
  const TopupMainScreen({Key? key}) : super(key: key);

  @override
  State<TopupMainScreen> createState() => _TopupMainScreenState();
}

class _TopupMainScreenState extends State<TopupMainScreen> {
  final phoneController = TextEditingController();
  String name = "-";
  String phone = "-";
  String balance = "-";
  int userId = 0;
  int money = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nạp tiền'),
          titleTextStyle: AppText.appbarTitleText1,
          centerTitle: true,
          toolbarHeight: AppSize.heightScreen / 12,
          backgroundColor: Colors.transparent,

          flexibleSpace: Container(
            height: AppSize.heightScreen / 12,
            decoration: AppBoxDecoration.boxDecorationWithGradientNoBorder1,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSize.widthScreen / 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Nhập số điện thoại", style: AppText.topupText1,),
                SizedBox(height: AppSize.widthScreen / 20,),
                TextField(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  decoration: InputDecoration(
                    hintText: "Số điện thoại",
                    contentPadding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 30, vertical: 0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSize.widthScreen / 80)
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        UserInfo? user = await UserRepository().getUserInformation(phoneController.text);

                        if (user != null) {
                          setState(() {
                            phone = phoneController.text;
                            name = user!.fullName!;
                            balance = NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(user!.accountBalance) + " VNĐ";
                            userId = user!.accountId!;
                          });
                        } else {
                          setState(() {
                            phone = '-';
                            name = 'Không tìm thấy';
                            balance = '-';
                            userId = 0;
                          });
                        }
                      }
                    ),
                  ),
                ),
                SizedBox(height: AppSize.widthScreen / 20,),
                Divider(
                  height: 5,
                  color: AppColor.primaryColor2,
                ),
                SizedBox(height: AppSize.widthScreen / 20,),
                Text("Thông tin khách hàng", style: AppText.topupText1,),
                SizedBox(height: AppSize.widthScreen / 20,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Họ tên", style: AppText.topupText2),
                        SizedBox(width: AppSize.widthScreen / 20,),
                        Expanded(
                            child:  Container(
                              padding: EdgeInsets.all(AppSize.widthScreen / 35),
                              child: Text('${name}', style: AppText.topupText1,),
                              width: double.infinity,
                              height: AppSize.heightScreen / 20,
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor2,
                                  borderRadius: BorderRadius.circular(AppSize.widthScreen / 60)
                              ),
                            ),
                        )
                      ],
                    ),

                    SizedBox(height: AppSize.widthScreen / 20,),
                    Row(
                      children: [
                        Text('Số điện thoại', style: AppText.topupText2),
                        SizedBox(width: AppSize.widthScreen / 20,),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(AppSize.widthScreen / 35),
                            child: Text('${phone}', style: AppText.topupText1,),
                            width: double.infinity,
                            height: AppSize.heightScreen / 20,
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor2,
                                borderRadius: BorderRadius.circular(AppSize.widthScreen / 60)
                            ),
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: AppSize.widthScreen / 20,),
                    Row(
                      children: [
                        Text('Số tiền', style: AppText.topupText2),
                        SizedBox(width: AppSize.widthScreen / 20,),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(AppSize.widthScreen / 35),
                            child: Text('${balance}', style: AppText.topupText1,),
                            width: double.infinity,
                            height: AppSize.heightScreen / 20,
                            decoration: BoxDecoration(
                                color: AppColor.primaryColor2,
                                borderRadius: BorderRadius.circular(AppSize.widthScreen / 60)
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),

                SizedBox(height: AppSize.widthScreen / 20,),
                Text('Số tiền nạp (VNĐ)', style: AppText.topupText2),
                SizedBox(height: AppSize.widthScreen / 20,),
                GroupButton(
                  onSelected: (value, index, isSelected) {
                    print('index ne' + index.toString());
                    switch (index) {
                      case 0:
                        setState(() {
                          money = 10000;
                        });
                        break;
                      case 1:
                        setState(() {
                          money = 20000;
                        });
                        break;
                      case 2:
                        setState(() {
                          money = 50000;
                        });
                        break;
                      case 3:
                        setState(() {
                          money = 100000;
                        });
                        break;
                      case 4:
                        setState(() {
                          money = 200000;
                        });
                        break;
                      case 5:
                        setState(() {
                          money = 500000;
                        });
                        break;
                    }
                  },
                  isRadio: true,
                  options: GroupButtonOptions(
                    buttonWidth: AppSize.widthScreen / 4,
                    selectedColor: Colors.white,
                    selectedBorderColor: AppColor.primaryColor1,
                    borderRadius: BorderRadius.circular(AppSize.widthScreen / 60),
                    mainGroupAlignment: MainGroupAlignment.center,
                    crossGroupAlignment: CrossGroupAlignment.center,
                    selectedTextStyle: AppText.topupText2,
                    groupingType: GroupingType.wrap,
                    unselectedTextStyle: AppText.topupText2,
                  ),

                  buttons: ['10,000','20,000','50,000','100,000','200,000','500,000'],
                ),
                SizedBox(height: AppSize.widthScreen / 20,),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: AppSize.widthScreen / 20),
                    child: Column(
                      children: [
                        Padding(padding: EdgeInsets.symmetric(horizontal: AppSize.widthScreen / 40),child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Số tiền nạp", style: AppText.passerByText1,),
                            Text(NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(money) + " VNĐ", style: AppText.passerByText1),
                          ],
                        ),),
                        SizedBox(
                          width: double.infinity,
                          height: AppSize.heightScreen / 15,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppColor.primaryColor1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(AppSize.widthScreen / 30))),
                              onPressed: () async {
                                print("User id: " + userId.toString());
                                print("total: " + money.toString());

                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext builderContext) {
                                      if (money == 0 || userId == 0) {
                                        AlertDialog(
                                          backgroundColor: Colors.white,
                                          title: Text('Lỗi'),
                                          content: SingleChildScrollView(
                                            child: Text('Hãy nhập đầy đủ thông tin'),
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
                                      return FutureBuilder<int?> (
                                          future: PaymentRepository().postPayment(userId, money),
                                          builder: (context, snapshot)  {
                                            if (money == 0 && userId != 0) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: Text('Lỗi'),
                                                content: SingleChildScrollView(
                                                  child: Text('Hãy chọn số tiền nạp'),
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

                                            if (money != 0 && userId == 0) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: Text('Lỗi'),
                                                content: SingleChildScrollView(
                                                  child: Text('Hãy nhập số điện thoại khách hàng'),
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
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                title: Text('Nạp thành công'),
                                                content: SingleChildScrollView(
                                                  child: Text('Đã thu: ' + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(money) + " VNĐ"),
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
                              child: Text((money == 0) ? "Xác nhận thu tiền" : "Xác nhận thu tiền - " + NumberFormat.currency(locale: "en_US", decimalDigits: 0, symbol: "").format(money) + " VNĐ", style: TextStyle(color: Colors.white),)
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          )
        )
      ),
    );
  }
}
