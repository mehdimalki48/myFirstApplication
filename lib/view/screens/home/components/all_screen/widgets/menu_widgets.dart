import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/style_data.dart';

class MenuWidgets extends StatelessWidget {
  final String? icon;
  final String? title;
  final Color? color;
  const MenuWidgets({
    Key? key,
    this.icon,
    this.color,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 52,
          width: 52,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Container(
            decoration: const BoxDecoration(
                // gradient: RadialGradient(
                //   colors: [
                //     kWhiteColor.withOpacity(.5),
                //     color!,
                //   ],
                // ),

                ),
            child: SvgPicture.asset(
              icon!,
              width: 50,
            ),
          ),
        ),
        kHeightBox10,
        Text(
          title ?? '',
          style: kDescriptionText.copyWith(
            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
