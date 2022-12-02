import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/style_data.dart';

class FilterBtnWidget extends StatelessWidget {
  final String? title;
  final String? icon;
  final bool? isSelected;
  const FilterBtnWidget({
    Key? key,
    this.title,
    this.icon,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        color:
            isSelected == false ? Colors.transparent : const Color(0xFFFFF0E9),
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 1,
          color: isSelected == false ? kStUnderLineColor : kPrimaryColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon == null
              ? const SizedBox()
              : Image.asset(
                  icon!,
                  width: 25,
                ),
          kWidthBox5,
          Text(
            title ?? '',
            style: kRegularText2.copyWith(
              color: isSelected == false
                  ? (Get.isDarkMode ? kWhiteColor : kBlackColor2)
                  : kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
