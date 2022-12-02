import 'package:flutter/material.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/style_data.dart';

class TextButtons extends StatelessWidget {
  final Function? onPress;
  final double radius;
  final double border;
  final Color btnColor;
  final Color btnColor2;
  final Color titleColor;
  final double? width;
  final double? height;
  final String title;

  const TextButtons({
    Key? key,
    this.width,
    this.height = 26.0,
    this.btnColor = kSecondaryColor,
    this.btnColor2 = kPrimaryColor,
    this.titleColor = kWhiteColor,
    this.border = 0,
    this.onPress,
    this.radius = 30,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress as void Function()?,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: btnColor,
          gradient: LinearGradient(
            colors: [
              btnColor,
              btnColor2,
            ],
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        width: width,
        height: height,
        child: Center(
          child: Text(
            title,
            style: kSmallText.copyWith(
              color: titleColor,
              fontSize: 10.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}
