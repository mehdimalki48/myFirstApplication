import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/style_data.dart';

class AccountInfoWidgets extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Function onTap;
  final bool divide;

  const AccountInfoWidgets({
    Key? key,
    required this.title,
    this.subTitle,
    this.divide = true,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 0,
        ),
        child: Column(
          children: [
            kHeightBox8,
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          title,
                          style: kRegularText2.copyWith(
                            color: Get.isDarkMode
                                ? const Color(0xFFFFFFFF)
                                : const Color(0xFF303030),
                          ),
                        ),
                      ),
                    ],
                  )),
                  Text(
                    subTitle ?? "Not Set".tr,
                    style: kDescriptionText,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18.0,
                      color: Color(0xFF707070),
                    ),
                  ),
                ]),
            kHeightBox8,
            divide
                ? Container(
                    margin: const EdgeInsets.only(left: 0.0),
                    height: .3,
                    color: kStUnderLineColor,
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
