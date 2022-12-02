import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/style_data.dart';

class MoreWidgets extends StatelessWidget {
  final Function? onTap;
  const MoreWidgets({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap as void Function()?,
      child: Row(
        children: [
          Text(
            'More'.tr,
            style: kDescriptionText.copyWith(
              color: Get.isDarkMode ? kStUnderLineColor : kStUnderLineColor2,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 12.0,
            color: Get.isDarkMode ? kStUnderLineColor : kStUnderLineColor2,
          ),
        ],
      ),
    );
  }
}
