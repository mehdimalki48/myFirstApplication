import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';

class IntroContent extends StatelessWidget {
  const IntroContent({
    Key? key,
    this.text,
    this.decs,
    this.image,
    this.index,
  }) : super(key: key);
  final String? text, image, decs;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        Container(child: index! % 2 != 0 ? Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(50),
            vertical: getProportionateScreenWidth(20),
          ),
          child: Column(
            children: [
              Text(
                text ?? "",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: kPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              kHeightBox10,
              Text(
                decs ?? "",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Get.isDarkMode ? kStUnderLineColor2 : kStUnderLineColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ) : Container(),),
        Center(
          child: Image.asset(
            image ?? Images.logo,
          ),
        ),
        Container(child: index! % 2 == 0 ? Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(50),
            vertical: getProportionateScreenWidth(20),
          ),
          child: Column(
            children: [
              Text(
                text ?? "",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: kPrimaryColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              kHeightBox10,
              Text(
                decs ?? "",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                  color: Get.isDarkMode ? kStUnderLineColor2 : kStUnderLineColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ) : Container(),),
      ],
    );
  }
}
