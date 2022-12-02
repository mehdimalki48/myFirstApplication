import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/util/date_converter.dart';

class OrderStatusWidgets extends StatelessWidget {
  const OrderStatusWidgets(
      {Key? key, required this.title, required this.time, required this.index})
      : super(key: key);
  final String title;
  final DateTime time;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisStart,
      crossAxisAlignment: crossAxisStart,
      children: [
        /*index == 0
            ? const SizedBox.shrink()
            : Text(DateConverter.dateToDateAndTime2(time),
            style: kSmallText.copyWith(color: kDarkGrayColor3)),*/
        Expanded(
          flex: 3,
          child: index == 0
              ?  Container(
            alignment: Alignment.center,
            width: 60,
            child: Text(DateConverter.dateToDateAndTime2(time),
              textAlign: TextAlign.right,
              style: kRegularText2.copyWith(
                color: Get.isDarkMode ? const Color(0xFF707070) : kStUnderLineColor,
                fontSize: 14.0,
              ),),
          )
              : Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    Text(DateConverter.dateToDateAndTime2(time),
                      textAlign: TextAlign.right,
                      style: kRegularText2.copyWith(
                        color: Get.isDarkMode ? const Color(0xFF707070) : kStUnderLineColor,
                        fontSize: 14.0,
                      ),),
                  ],
                ),
        ),
        Expanded(
          flex: 6,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            index == 0
                ? const SizedBox.shrink()
                : Container(
                    width: 2.5,
                    height: 40,
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(
                      color: kPrimaryColor,
                    ),
                  ),
            Row(
              children: [
                DotIndicator(
                  size: 20.0,
                  color: Theme.of(context).cardColor,
                  child: const Center(
                    child: Icon(
                      Icons.circle,
                      size: 20,
                      color: completeColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    title,
                    style: kRegularText2.copyWith(
                      color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
        kWidthBox10,
      ],
    );
  }
}
