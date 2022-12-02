import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/style_data.dart';

class ProfileButton extends StatelessWidget {
  final String icon;
  final String title;
  final String? subTitle;
  final Function onTap;

  const ProfileButton({
    Key? key,
    required this.icon,
    required this.title,
    this.subTitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Column(
          children: [
            kHeightBox8,
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: SvgPicture.asset(
                      icon,
                      width: 25,
                      height: 25,
                      color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                    ),
                  ),
                  kWidthBox20,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: subTitle != null ? 0 : 10),
                        child: Text(
                          title,
                          style: kRegularText2.copyWith(
                            color: Get.isDarkMode
                                ? kWhiteColor
                                : kBlackColor2,
                          ),
                        ),
                      ),
                      subTitle != null ? kHeightBox5 : const SizedBox(),
                      subTitle != null
                          ? Text(
                              subTitle ?? "",
                              style: kDescriptionText,
                            )
                          : const SizedBox(),
                    ],
                  )),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18.0,
                      color: Color(0xFF707070),
                    ),
                  )
                ]),
            kHeightBox8,
            Container(
              margin: const EdgeInsets.only(left: 0.0),
              height: .3,
              color: kStUnderLineColor,
            ),
          ],
        ),
      ),
    );
  }
}
