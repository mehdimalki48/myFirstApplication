import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/view/screens/home/components/all_screen/more_screen/top_sell_list_screen.dart';
import 'package:woogoods/view/screens/home/components/all_screen/widgets/more_widgets.dart';
import 'package:woogoods/view/screens/product/product_details.dart';

class TopSale extends StatelessWidget {
  const TopSale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          kOrdinaryShadow,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Top Sale'.tr,
                style: kRegularText2.copyWith(
                  color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              kWidthBox10,
              Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'in January',
                    style: kDescriptionText.copyWith(
                      color: kWhiteColor,
                    ),
                  )),
              const Spacer(),
              MoreWidgets(
                onTap: () => Get.to(() => const TopSellListScreen(),
                    transition: Transition.rightToLeft),
              ),
            ],
          ),
          kHeightBox10,
          GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2,
            ),
            scrollDirection: Axis.vertical,
            itemCount: 4,
            itemBuilder: (context, int index) {
              return InkWell(
                onTap: () {
                  Get.to(const ProductDetailsScreen(
                    id: 72,
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'MIDI Controll',
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              const Spacer(),
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
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: kOrdinaryColor2,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: isImageShow
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://i.pinimg.com/originals/34/ec/e8/34ece887ec3b2224e0860fce70120fdb.jpg',
                                    placeholder: (context, url) => Container(
                                      decoration: BoxDecoration(
                                        color: kOrdinaryColor2,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Image.asset(Images.placeHolder),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: kOrdinaryColor2,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Image.asset(Images.placeHolder),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
