import 'package:flutter/material.dart';

class UIConstant {
  static const String appName = "Toilet Map - Nhà Vệ Sinh Công Cộng";
}

class AppSize {
  static double heightScreen = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.height;
  static double widthScreen = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
}

class AppDomain {
  static const String appDomain1 = 'https://toilet-map.azurewebsites.net';
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
      fontSize: AppSize.heightScreen / 30,
      fontStyle: FontStyle.normal,
      color: Colors.white);

  static var homeButtonText = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: AppSize.heightScreen / 35,
      fontStyle: FontStyle.normal,
      color: AppColor.primaryColor1);

  static var appbarTitleText1 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: AppSize.heightScreen / 30,
    fontStyle: FontStyle.normal,
    color: Colors.white,
  );

}

class AppShapeBorder {
  static var shapeBorder1 =  RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(AppSize.heightScreen / 1.5, AppSize.widthScreen / 6),
          bottomRight: Radius.elliptical(AppSize.heightScreen / 1.5, AppSize.widthScreen / 6),
      )
  );

  static var shapeBorder2 =  RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(AppSize.widthScreen / 40),
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