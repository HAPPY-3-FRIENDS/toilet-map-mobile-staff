import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class LoginAppbar extends StatelessWidget {
  const LoginAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AppBar(
          toolbarHeight: AppSize.heightScreen / 4,
          shape: AppShapeBorder.shapeBorder1,
          flexibleSpace: Container(
              decoration: AppBoxDecoration.boxDecorationWithGradient1
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: AppSize.heightScreen / 8),
          child: Container(
            width: AppSize.widthScreen / 2.5,
            height: AppSize.widthScreen / 2.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all( Radius.circular(AppSize.widthScreen / 5)),
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
