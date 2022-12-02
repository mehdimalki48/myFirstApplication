import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/response/address_book.dart';

class AddressCard extends StatelessWidget {
  final AddressBook data;
  final Function onEditTap;

  const AddressCard({
    Key? key,
    required this.data,
    required this.onEditTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Theme.of(context).cardColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    kWidthBox10,
                    SvgPicture.asset(
                      Images.location,
                      width: 20,
                      height: 20,
                      color: kFbColors,
                    ),
                  ],
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${data.firstName ?? ''} ${data.lastName ?? ''}',
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: onEditTap as Function(),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Edit'.tr,
                                      style: kRegularText2.copyWith(
                                        color: kFbColors,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 12.0,
                                      color: kFbColors,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        kHeightBox5,
                        Text(
                          '${data.countyCode ?? ''} ${data.phone ?? ''}',
                          style: kRegularText2.copyWith(
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          ),
                        ),
                        kHeightBox5,
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    kSecondaryColor,
                                    kPrimaryColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 18,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.labelAs ?? '',
                                    style: kSmallText.copyWith(
                                      color: kWhiteColor,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            kWidthBox10,
                            Text(
                              '${data.address}',
                              maxLines: 2,
                              style: kRegularText2.copyWith(
                                color:
                                    Get.isDarkMode ? kWhiteColor : kBlackColor2,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        if ((data.isSelect ?? 0) == 1) kHeightBox10,
                        if ((data.isSelect ?? 0) == 1)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 1, color: kFbColors),
                            ),
                            height: 18,
                            child: Text(
                              'Select Address',
                              style: kSmallText.copyWith(
                                  color: kFbColors,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w300,
                                  height: 1.0),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        kHeightBox10,
      ],
    );
  }
}
