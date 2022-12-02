import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/models/response/review_model.dart';
import 'package:woogoods/util/others_methods.dart';
import 'package:woogoods/view/screens/product/product_details.dart';

import '../../../../controllers/favorite_controller.dart';

class ReviewWidget extends StatelessWidget {
  final bool? showImage;
  final ReviewModel reviews;
  final ProductList? product;

   const ReviewWidget({
    Key? key,
    this.showImage = false,
    required this.reviews,
    this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
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
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: reviews.reviewerAvatarUrls?.firstImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              reviews.reviewerAvatarUrls?.firstImage ?? '',
                              width: getProportionateScreenWidth(40),
                              height: getProportionateScreenWidth(40),
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : Container(
                            width: getProportionateScreenWidth(40),
                            height: getProportionateScreenWidth(40),
                            decoration: BoxDecoration(
                              color: kOrdinaryColor2,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                  ),
                  kWidthBox10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              reviews.reviewer ?? '',
                              maxLines: 1,
                              style: kRegularText2.copyWith(
                                color:
                                    Get.isDarkMode ? kWhiteColor : kBlackColor2,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              DateFormat('yyyy-MM-dd hh.mm a').format(
                                DateTime.parse(reviews.dateCreated ??
                                    '2016-04-05T10:38:54'),
                              ),
                              maxLines: 1,
                              style: kDescriptionText.copyWith(
                                color: Get.isDarkMode
                                    ? kWhiteColor
                                    : const Color(0xFF808080),
                              ),
                            ),
                          ],
                        ),
                        RatingBarIndicator(
                          rating: (reviews.rating ?? 0).toDouble(),
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
                  )
                ],
              ),
              kHeightBox20,
              Text(
                reviews.review?.replaceAll(htmlValidatorRegExp, '') ?? '',
                style: kRegularText2.copyWith(
                  color: Get.isDarkMode ? kWhiteColor : const Color(0xFF303030),
                ),
              ),
              kHeightBox20,
              InkWell(
                onTap: () => Get.to(
                      () => ProductDetailsScreen(
                    id: product?.id ?? 0,
                    productDetails: product,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: product!.images!.isNotEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl: product?.images![0].src ?? '',
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    color: kOrdinaryColor2,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Image.asset(Images.placeHolder),
                                ),
                                errorWidget: (context, url, error) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        color: kOrdinaryColor2,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Image.asset(Images.placeHolder),
                                    ),
                                width: getProportionateScreenWidth(65),
                                height: getProportionateScreenWidth(65),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: kOrdinaryColor2,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: getProportionateScreenWidth(65),
                              height: getProportionateScreenWidth(65),
                              child: Image.asset(Images.placeHolder),
                            ),
                    ),
                    kWidthBox10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           product?.name ?? '',
                            maxLines: 2,
                            style: kRegularText2.copyWith(
                              color:
                                  Get.isDarkMode ? kWhiteColor : kBlackColor2,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                kCurrency + '${OthersMethod.productPriceCalculate(product!)}',
                                style: kRegularText.copyWith(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              GetBuilder<FavoriteController>(
                                  builder: (favoriteController) {
                                    return LikeButton(
                                      onTap: (isLiked) async {
                                        if (isLiked) {
                                          favoriteController.addToFavorite(product!);
                                          log('disliked');
                                          return false;
                                        } else {
                                          favoriteController.addToFavorite(product!);
                                          log('liked');
                                          return true;
                                        }
                                      },
                                      isLiked: favoriteController
                                          .isAlreadyAdd(product!.id!),
                                      likeCountPadding: EdgeInsets.zero,
                                      padding: const EdgeInsets.all(0),
                                      likeBuilder: (bool isLiked) {
                                        return Icon(
                                          Icons.favorite,
                                          color: isLiked ? kPrimaryColor : kBlackColor2,
                                        );
                                      },
                                    );
                                  }),
                            ],
                          ),
                        ],
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
    );
  }
}
