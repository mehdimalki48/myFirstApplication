import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/style_data.dart';

import 'payment_details.dart';

class ManagePaymentScreen extends StatefulWidget {
  const ManagePaymentScreen({Key? key}) : super(key: key);

  @override
  State<ManagePaymentScreen> createState() => _ManagePaymentScreenState();
}

class _ManagePaymentScreenState extends State<ManagePaymentScreen> {
  bool isDelActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Manage Payment'.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Get.to(
                    () => const PaymentDetails(),
                    
                  );
                },
                child: DottedBorder(
                  color: Get.isDarkMode ? kWhiteColor : kStUnderLineColor,
                  borderType: BorderType.RRect,
                  strokeWidth: 1,
                  radius: const Radius.circular(5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SvgPicture.asset(
                              Images.bank,
                              color: Get.isDarkMode
                                  ? kWhiteColor
                                  : kStUnderLineColor,
                            ),
                            Positioned(
                              top: 0,
                              right: -5,
                              child: SvgPicture.asset(
                                Images.add,
                              ),
                            ),
                          ],
                        ),
                        kWidthBox10,
                        Text(
                          'Add Card'.tr,
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          color:
                              Get.isDarkMode ? kWhiteColor : kStUnderLineColor,
                          size: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              kHeightBox10,
              ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(
                          () => const PaymentDetails(),
                          
                        );
                      },
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Get.isDarkMode
                                  ? (isDelActive == true
                                      ? const Color(0xFF2D3749)
                                      : Theme.of(context).cardColor)
                                  : (isDelActive == true
                                      ? const Color(0xFF2D3749)
                                      : kWhiteColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 25,
                                    horizontal: 15,
                                  ),
                                  child: SvgPicture.asset(
                                    Images.bank,
                                    color: Get.isDarkMode
                                        ? kWhiteColor
                                        : (isDelActive == true
                                            ? kWhiteColor
                                            : kStUnderLineColor),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Visa Card',
                                      style: isDelActive == true
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(color: kWhiteColor)
                                          : Theme.of(context)
                                              .textTheme
                                              .headline1,
                                    ),
                                    kHeightBox5,
                                    Text(
                                      'Card Number'.tr,
                                      style: isDelActive == true
                                          ? kDescriptionText.copyWith(
                                              color: kWhiteColor,
                                            )
                                          : kDescriptionText.copyWith(
                                              color: kStUnderLineColor,
                                            ),
                                    ),
                                    Text(
                                      '1234567891018765',
                                      style: isDelActive == true
                                          ? Theme.of(context)
                                              .textTheme
                                              .headline1!
                                              .copyWith(
                                                color: kWhiteColor,
                                              )
                                          : Theme.of(context)
                                              .textTheme
                                              .headline1,
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 18,
                                          color: Get.isDarkMode
                                              ? kWhiteColor
                                              : kStUnderLineColor,
                                        ),
                                      ),
                                      kHeightBox20,
                                      isDelActive == true
                                          ? Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      isDelActive == false;
                                                    });
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: kWhiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: Text(
                                                      'Delete'.tr,
                                                      style: Get.isDarkMode
                                                          ? Theme.of(context)
                                                              .textTheme
                                                              .headline1!
                                                              .copyWith(
                                                                color:
                                                                    kBlackColor2,
                                                              )
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .headline1!,
                                                    ),
                                                  ),
                                                ),
                                                kWidthBox10,
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      isDelActive = false;
                                                    });
                                                  },
                                                  child: Icon(
                                                    Icons.close,
                                                    size: 18,
                                                    color: Get.isDarkMode
                                                        ? kWhiteColor
                                                        : kStUnderLineColor,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : InkWell(
                                              onTap: () {
                                                setState(
                                                  () {
                                                    isDelActive = true;
                                                  },
                                                );
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                size: 18,
                                                color: Get.isDarkMode
                                                    ? kWhiteColor
                                                    : kStUnderLineColor,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          kHeightBox10,
                        ],
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
