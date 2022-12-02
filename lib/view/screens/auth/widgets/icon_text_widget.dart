import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/style_data.dart';

class IconTextWidget extends StatelessWidget {
  final String icon;
  final String title;
  final Function onTap;
  final bool selected;
  const IconTextWidget({
    Key? key,
    required this.icon,
    required this.title,
    this.selected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 0
        ),
        child: Column(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      icon,
                      width: 20,
                      height: 20,
                      color: selected ? kPrimaryColor: Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF303030),
                    ),
                  ),
                  kWidthBox10,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10),
                    child: Text(
                      title,
                      style:  kRegularText2.copyWith(color: selected ? kPrimaryColor: Get.isDarkMode ? const Color(0xFFFFFFFF) : const Color(0xFF303030)),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
