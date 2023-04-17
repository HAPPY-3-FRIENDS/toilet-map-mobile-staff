import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class TopupMainScreen extends StatefulWidget {
  const TopupMainScreen({Key? key}) : super(key: key);

  @override
  State<TopupMainScreen> createState() => _TopupMainScreenState();
}

class _TopupMainScreenState extends State<TopupMainScreen> {
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
      ),
    );
  }
}
