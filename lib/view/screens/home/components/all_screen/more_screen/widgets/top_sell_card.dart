import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';

class TopSellListCard extends StatelessWidget {
  const TopSellListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.zero,
          elevation: 1.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  width: SizeConfig.screenWidth! / 2.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MIDI Controll',
                        style: kRegularText2.copyWith(
                          color:
                          Get.isDarkMode ? kWhiteColor : kBlackColor2,
                        ),
                      ),
                      kHeightBox10,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '500',
                              style: kRegularText2.copyWith(
                                color: kPrimaryColor,
                              ),
                            ),
                            TextSpan(
                              text: ' People want',
                              style: kSmallText.copyWith(
                                color: Get.isDarkMode
                                    ? kWhiteColor
                                    : kBlackColor2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'this Product',
                        style: kDescriptionText.copyWith(
                          color:
                          Get.isDarkMode ? kWhiteColor : kBlackColor2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: kStUnderLineColor.withOpacity(.30),
                  height: 100,

                ),
              ),
            ],
          ),
        ),
        kHeightBox10,
      ],
    );
  }
}
