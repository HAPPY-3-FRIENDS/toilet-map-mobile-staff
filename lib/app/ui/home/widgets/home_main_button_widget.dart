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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () => function(),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColor.primaryColor2,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(offset: Offset(0.0, 10.0), blurRadius: 10.0, color: Colors.black12),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon,size: screenWidth/4, color: AppColor.primaryColor1),
            Text(text, style: AppText.homeButtonText,)
          ],
        ),
      ),
    );
  }
}
