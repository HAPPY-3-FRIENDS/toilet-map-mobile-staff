import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/toilet/toilet.dart';
import '../../utils/constants.dart';

class ToiletWidget extends StatelessWidget {
  Toilet toilet;

  ToiletWidget({Key? key, required this.toilet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        height: 300.h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Nhà vệ sinh gần đây", style: AppText.sampleText,),
            Container(
              height: 150.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: 'Tên Nhà vệ sinh: ',
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: toilet.toiletName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColor.primaryColor1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  RichText(
                    text: TextSpan(
                        text: 'Địa chỉ: ',
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: toilet.address + ", " + toilet.ward + ", " + toilet.district + ", " + toilet.province,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColor.primaryColor1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                    ),
                  ),
                  SizedBox(height: 15.h,),
                  RichText(
                    text: TextSpan(
                        text: 'Thời gian: ',
                        style: TextStyle(fontSize: 16.sp, color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: toilet.openTime + " - " + toilet.closeTime,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColor.primaryColor1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]
                    ),
                  ),


                ],
              ),
            ),
          ],
        ));
  }
}
