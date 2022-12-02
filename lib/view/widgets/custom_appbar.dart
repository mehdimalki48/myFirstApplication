import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';

class CustomAppBar extends StatelessWidget {
  final Widget? search;
  final Widget? actionWidget;
  final Color? color;
  const CustomAppBar({
    Key? key,
    @required this.actionWidget,
    this.color,
    this.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Theme.of(context).cardColor,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Icon(
                Icons.arrow_back,
                color: color != null
                    ? kWhiteColor
                    : (Get.isDarkMode ? kWhiteColor : kBlackColor),
              ),
            ),
          ),
          Expanded(
            child: search!,
          ),
          actionWidget ?? const SizedBox()
        ],
      ),
    );
  }
}
