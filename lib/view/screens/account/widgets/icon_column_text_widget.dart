import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';

class IconColumnTextWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;
  final TextAlign textAlign;
  const IconColumnTextWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: getProportionateScreenWidth(26),
            height: getProportionateScreenHeight(26),
            child: SvgPicture.asset(
              icon,
              width: 20,
              height: 20,
              color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
            ),
          ),
          kHeightBox8,
          Text(
            title,
            textAlign: textAlign,
            style: kRegularText2.copyWith(
                color: Get.isDarkMode ? kWhiteColor : kBlackColor2, fontSize: 12.0),
          ),
        ],
      )),
    );
  }
}
