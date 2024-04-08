

import 'package:cripto/components/app_colors.dart';
import 'package:flutter/material.dart';

class IconsWidget {

  Widget smallIcon({required String asset, Color bgColor = AppColors.blackColor,double size = 1.7}) {
    return Container(

      width: 40,
      height: 40,
      decoration: BoxDecoration(
          color: bgColor,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: AssetImage(asset),scale: size)
      ),

    );
  }



}