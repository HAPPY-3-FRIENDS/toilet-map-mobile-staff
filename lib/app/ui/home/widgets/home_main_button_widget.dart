import 'package:flutter/material.dart';
import '../../../utils/Routes.dart';

import '../../../utils/constants.dart';

class HomeMainButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function function;

  const HomeMainButtonWidget({Key? key, required this.icon, required this.text, required this.function}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        padding: EdgeInsets.all(AppSize.widthScreen / 40),
        decoration: BoxDecoration(
          color: AppColor.primaryColor2,
          borderRadius: BorderRadius.circular(AppSize.widthScreen / 40),
          boxShadow: [
            BoxShadow(offset: Offset(0.0, 5.0), blurRadius: 5.0, color: Colors.black12),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon,size: AppSize.widthScreen / 4, color: AppColor.primaryColor1),
            Text(text, style: AppText.homeButtonText,)
          ],
        ),
      ),
    );
  }
}
