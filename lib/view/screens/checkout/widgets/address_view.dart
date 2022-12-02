import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/response/address_book.dart';
import 'package:woogoods/view/screens/address_book/address_book_list_screen.dart';

class AddressView extends StatelessWidget {
  final double? width;
  final bool isAddress;
  final AddressBook? addressBook;

  const AddressView({
    Key? key,
    this.width,
    this.isAddress = false,
    this.addressBook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: isAddress
          ? InkWell(
              child: Container(
                alignment: Alignment.centerLeft,
                height: isAddress ? width : 80,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).backgroundColor,
                      Theme.of(context).cardColor,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF000000).withOpacity(.10),
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: const Offset(1, -4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    kHeightBox10,
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                '${addressBook?.firstName ?? ''} ${addressBook?.lastName ?? ''}',
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              kWidthBox20,
                              Text(
                                '${addressBook?.countyCode ?? ''} ${addressBook?.phone ?? ''}',
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => const AddressBookListScreen(
                                isCheckout: true,
                              ),
                            );
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 18.0,
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          ),
                        ),
                      ],
                    ),
                    kHeightBox10,
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
                                (addressBook?.labelAs ?? '').tr,
                                style: kSmallText.copyWith(
                                  color: kWhiteColor,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        kWidthBox15,
                        SvgPicture.asset(
                          Images.location,
                          width: 15,
                          height: 15,
                          color: kFbColors,
                        ),
                        kWidthBox10,
                        Text(
                          (addressBook?.address ?? ''),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: kRegularText2.copyWith(
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    kHeightBox10,
                    Text(
                      'We support home delivery only at District Metro address. If you are not in sadar, you may pick up the order at our delivery hub.'
                          .tr,
                      style: kRegularText2.copyWith(
                        color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                        fontWeight: FontWeight.w300,
                        fontSize: 14.0,
                        height: 1.0,
                      ),
                    ),
                    kHeightBox10,
                    const DottedLine(
                      direction: Axis.horizontal,
                      lineLength: double.infinity,
                      lineThickness: 4.0,
                      dashLength: 16.0,
                      dashColor: kPrimaryColor,
                      dashRadius: 0.0,
                      dashGapLength: 16.0,
                      dashGapColor: kFbColors,
                      dashGapRadius: 0.0,
                    ),
                  ],
                ),
              ),
            )
          : Container(
              alignment: Alignment.centerLeft,
              height: isAddress ? width : 80,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).backgroundColor,
                    Theme.of(context).cardColor,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF000000).withOpacity(.10),
                    blurRadius: 4,
                    spreadRadius: 0,
                    offset: const Offset(1, -4),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Get.to(
                    () => const AddressBookListScreen(),
                  );
                },
                child: Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'You have not set your shipping information'.tr,
                            style: kRegularText2.copyWith(
                              color:
                                  Get.isDarkMode ? kWhiteColor : kBlackColor2,
                              fontWeight: FontWeight.w300,
                              fontSize: 14.0,
                              height: 1.0,
                            ),
                          ),
                          kHeightBox10,
                          Text(
                            'Add Shipping Address'.tr,
                            style: kRegularText2.copyWith(
                              color: const Color(0xFFFF005C),
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0,
                              height: 1.0,
                              decoration: TextDecoration.underline,
                              decorationThickness: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18.0,
                        color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          DottedLine(
                            direction: Axis.horizontal,
                            lineLength: double.infinity,
                            lineThickness: 4.0,
                            dashLength: 16.0,
                            dashColor: kPrimaryColor,
                            dashRadius: 0.0,
                            dashGapLength: 16.0,
                            dashGapColor: kFbColors,
                            dashGapRadius: 0.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
