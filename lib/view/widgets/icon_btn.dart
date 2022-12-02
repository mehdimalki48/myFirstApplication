import 'package:woogoods/constants/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconButtons extends StatelessWidget {
  final Function? onPress;
  final double radius;
  final double border;
  final Color btnColor;
  final Color btnColor2;
  final Color imageColor;
  final double? width;
  final double? height;
  final double padding;
  final String imageURL;

  const IconButtons({
    Key? key,
    this.width,
    this.height = 24,
    this.btnColor = kSecondaryColor,
    this.btnColor2 = kPrimaryColor,
    this.imageColor = kWhiteColor,
    this.border = 0,
    this.onPress,
    this.radius = 30,
    this.padding = 12,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress as void Function()?,
      child: Container(
          padding:  EdgeInsets.symmetric(horizontal: padding, vertical: 4),
        decoration: BoxDecoration(
          color: btnColor,
          gradient:  LinearGradient(
            colors: [
              btnColor,
              btnColor2,
            ],
          ),
          borderRadius: BorderRadius.circular(radius),
        ),
        width: width,
        height: height,
        child: SvgPicture.asset(
          imageURL, color: imageColor,)
      ),
    );
  }
}
