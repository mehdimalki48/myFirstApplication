import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/style_data.dart';

class GendersWidgets extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Function onTap;
  final bool divide;
  final bool selected;

  const GendersWidgets({
    Key? key,
    required this.title,
    this.subTitle,
    this.divide = true,
    this.selected = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Text(
                          title,
                          style: kRegularText2.copyWith(
                            color: Get.isDarkMode
                                ? kWhiteColor
                                : kBlackColor2,),
                        ),
                      ),
                    ],
                  )),
                  selected
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(
                            Icons.check_circle,
                            size: 18.0,
                            color: kPrimaryColor,
                          ),
                        )
                      : const SizedBox()
                ]),
            kHeightBox10,
            divide
                ? Container(
                    margin: const EdgeInsets.only(left: 10.0),
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
