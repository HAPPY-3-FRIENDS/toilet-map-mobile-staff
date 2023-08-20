import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIConstant {
  static const String appName = "Toilet Map - Nhà Vệ Sinh Công Cộng";
}

class AppSize {
  static double heightScreen = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  static double widthScreen = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
}

class AppDomain {
  static String appDomain1 = 'http://192.168.137.1:8081';
  static const String appDomain2 = 'https://toiletmap.azurewebsites.net';
}

class AppColor {
  static const Color primaryColor1 = Color(0xFF0B79D9);
  static const Color primaryColor2 = Color(0xFFD8E9F9);
  static const Color gradientColor1 = Color(0xFF004786);
  static const Color gradientColor2 = Color(0xFF29ABE2);
}

class AppString {
  static const String loginSuccessfully = "Đăng nhập thành công";
}

class AppText {
  static const sampleText = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 26,
      fontStyle: FontStyle.normal,
      color: AppColor.primaryColor1);

  static var titleText1 = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 30.sp,
      fontStyle: FontStyle.normal,
      color: Colors.white);

  static var homeButtonText = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 22.sp,
      fontStyle: FontStyle.normal,
      color: AppColor.primaryColor1);

  static var appbarTitleText1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 30.sp,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );

  static var passerByText1 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20.sp,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var passerByText2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20.sp,
    fontStyle: FontStyle.normal,
    color: Colors.grey,
  );

  static var topupText1 = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var topupText2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 20.sp,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var appbarTitleText2 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 28.sp,
    color: AppColor.primaryColor1,
  );

  static var titleText3 = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.sp,
      color: AppColor.primaryColor1
  );

  static var roommanageText1 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 18.sp,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );

  static var roommanageText2 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
    fontStyle: FontStyle.normal,
    color: Colors.black,
  );
}

class AppShapeBorder {
  static var shapeBorder1 =  RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(600.h, 60.w),
          bottomRight: Radius.elliptical(600.h, 60.w),
      )
  );

  static var shapeBorder2 =  RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10.r),
      )
  );
}

class AppBoxDecoration {
  static var boxDecorationWithGradient1 = BoxDecoration(
    gradient: const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[AppColor.gradientColor1, AppColor.gradientColor2]
    ),
  );

  static const boxDecorationWithGradientNoBorder1 = BoxDecoration(
    gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[AppColor.gradientColor1, AppColor.gradientColor2]
    ),
  );
}