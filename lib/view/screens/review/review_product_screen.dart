import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/review_controller.dart';

import 'package:woogoods/view/screens/product/widgets/review_widget.dart';
import 'package:woogoods/view/widgets/app_bar_actions.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';

class ReviewProductsScreen extends StatelessWidget {
  static const routeName = 'review_product_screen';
  final String? rating;
  final ReviewController reviewController = Get.find();

  ReviewProductsScreen({
    Key? key,
    this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('Ratings & Reviews'.tr),
        actions: const [
          AppBarActions(
            isCart: true,
            isWishlist: true,
            isMoreVert: true,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    rating ?? '0.0',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          fontSize: 28,
                        ),
                  ),
                  Text(
                    ' / 5',
                    style: kSmallText.copyWith(
                      color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  kWidthBox5,
                  Container(
                    height: 10,
                    width: 1,
                    color:
                        Get.isDarkMode ? kWhiteColor : const Color(0xFF808080),
                  ),
                  kWidthBox5,
                  RatingBarIndicator(
                    rating: 5,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 15.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              kHeightBox10,
              Text(
                '${reviewController.reviewList.length - 1} Ratings',
                style: kSmallText.copyWith(
                  color:
                      Get.isDarkMode ? kStUnderLineColor : kStUnderLineColor2,
                  fontWeight: FontWeight.w300,
                ),
              ),
              kHeightBox10,
              const Divider(
                thickness: .3,
                height: .3,
                color: Color(0xFF808080),
              ),
              Obx(
                () {
                  if (reviewController.isLoading.isTrue) {
                    return const Center(
                      child: CustomLoader(),
                    );
                  } else if (reviewController.reviewList.isEmpty) {
                    return const Center(
                      child: Text('No Review Found!'),
                    );
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const ScrollPhysics(),
                      children: [
                        Container(
                          color: Theme.of(context).cardColor,
                          // padding: const EdgeInsets.all(10),
                          // margin: const EdgeInsets.only(top: 10),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: reviewController.reviewList.length,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, int index) {
                              return ReviewWidget(
                                showImage: false,
                                userName:
                                    reviewController.reviewList[index].reviewer,
                                userImage: reviewController.reviewList[index]
                                    .reviewerAvatarUrls?.firstImage,
                                rating:
                                    reviewController.reviewList[index].rating,
                                date: reviewController
                                    .reviewList[index].dateCreated,
                                reviewDetails: reviewController
                                    .reviewList[index].review!
                                    .replaceAll(htmlValidatorRegExp, ''),
                              );
                            },
                          ),
                        ),
                        kHeightBox15,
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
