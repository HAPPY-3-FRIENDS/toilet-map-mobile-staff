import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/constants.dart';

class LoginAppbar extends StatelessWidget {
  const LoginAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AppBar(
          toolbarHeight: 225.h,
          shape: AppShapeBorder.shapeBorder1,
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
              decoration: AppBoxDecoration.boxDecorationWithGradient1
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 112.5.h),
          child: Container(
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all( Radius.circular(75.w)),
              border: Border.all(
                color: Colors.white,
                width: 2.0,
              ),
            ),
          ),
        )
      ],
    );
  }
}
