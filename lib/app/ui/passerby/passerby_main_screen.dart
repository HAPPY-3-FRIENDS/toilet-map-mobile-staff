import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class PasserbyMainScreen extends StatefulWidget {
  const PasserbyMainScreen({Key? key}) : super(key: key);

  @override
  State<PasserbyMainScreen> createState() => _PasserbyMainScreenState();
}

class _PasserbyMainScreenState extends State<PasserbyMainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Khách vãng lai'),
          titleTextStyle: AppText.appbarTitleText1,
          centerTitle: true,
          toolbarHeight: AppSize.heightScreen / 12,
          backgroundColor: Colors.transparent,

          flexibleSpace: Container(
            height: AppSize.heightScreen / 12,
            decoration: AppBoxDecoration.boxDecorationWithGradientNoBorder1,
          ),
        ),
      ),
    );
  }
}
