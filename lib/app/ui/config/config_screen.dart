import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:toiletmap_staff/app/utils/Routes.dart';

import '../../utils/constants.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen> {
  String ip = "";

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

              title: Text('Configuration'),
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

        body: Container(
            padding: EdgeInsets.all(
                25.w
            ),
            height: AppSize.heightScreen,
            width: AppSize.widthScreen,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(" IP", style: AppText.sampleText,),
                    SizedBox(height: 10.h,),
                    Form(
                      child: TextFormField(
                        onChanged: (value) => setState(() => {
                          ip = value
                        }),
                        decoration: InputDecoration(
                          hintText: "IP Here...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(color: AppColor.primaryColor1),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60.h,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          primary: AppColor.primaryColor2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r))),
                      onPressed: () async {
                        try {
                          if (ip == "") {
                            AppDomain.appDomain1 = "http://192.168.137.1:8081";
                          } else {
                            AppDomain.appDomain1 = "http://" + ip + ":8081";
                          }
                          Navigator.pushNamed(context, Routes.loginMainScreen);
                        } catch (e) {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Chú ý'),
                                content: const Text('Đã có lỗi xảy ra!'),
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
                      child: Text("Xác nhận", style: AppText.passerByText1,)
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}
