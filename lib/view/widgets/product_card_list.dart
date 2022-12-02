import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';

class ProductCardList extends StatelessWidget {
  final Color? cardColor;
  final String? image;
  final String? title;
  final String? price;
  final String? prevPrice;
  final String? reviewCount;
  final double? reviewStar;
  const ProductCardList({
    Key? key,
    this.cardColor,
    this.image,
    this.title,
    this.price,
    this.prevPrice,
    this.reviewCount,
    this.reviewStar = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: cardColor ?? Theme.of(context).backgroundColor,
        border: const Border(
          bottom: BorderSide(
            width: 1,
            color: Color(0xFFC4C4C4),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: isImageShow
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: image ??
                          'https://my-live-05.slatic.net/original/efa16adce11216ea297dcb686f1032d4.jpg_2200x2200q80.jpg_.webp',
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          color: kOrdinaryColor2,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset(Images.placeHolder),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          color: kOrdinaryColor2,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset(kImageDir + 'placeholder.png'),
                      ),
                      width: getProportionateScreenWidth(100),
                      height: getProportionateScreenWidth(100),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      color: kOrdinaryColor2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: getProportionateScreenWidth(100),
                    height: getProportionateScreenWidth(100),
                    child: Image.asset(Images.placeHolder),
                  ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    maxLines: 2,
                    style: kRegularText2.copyWith(
                      color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                    ),
                  ),
                  kHeightBox20,
                  Row(
                    children: [
                      Text(
                        kCurrency + '$price',
                        style: kRegularText.copyWith(
                          color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if(prevPrice != null && double.parse(prevPrice ?? '0') > double.parse(price ?? '0'))
                      Row(
                        children: [
                          kWidthBox5,
                          Text(
                            prevPrice ?? '',
                            style: kDescriptionText.copyWith(
                              color: Get.isDarkMode ? kWhiteColor : kStUnderLineColor,
                              fontWeight: FontWeight.w300,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 10,
                            ),
                          ),
                          kWidthBox5,
                          Text(
                            '${((double.parse(prevPrice ?? '0') - double.parse(price ?? '0'))/double.parse(prevPrice ?? '0')*100).toInt()}% off',
                            style: kDescriptionText.copyWith(
                              color: Colors.green,
                              fontWeight: FontWeight.w300,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),

                    ],
                  ),
                  kHeightBox5,
                  Row(
                    children: [
                      Text(
                        '$reviewStar',
                        style: kDescriptionText.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                        ),
                      ),
                      kWidthBox5,
                      RatingBarIndicator(
                        rating: reviewStar ?? 0.0,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        direction: Axis.horizontal,
                      ),
                      kWidthBox5,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: reviewCount ?? '',
                              style: kSmallText.copyWith(
                                color: Get.isDarkMode
                                    ? kWhiteColor
                                    : const Color(0xFF707070),
                              ),
                            ),
                            TextSpan(
                              text: ' | ',
                              style: kSmallText.copyWith(
                                color: Get.isDarkMode
                                    ? kWhiteColor
                                    : const Color(0xFF707070),
                              ),
                            ),
                            TextSpan(
                              text: '500 wishlist',
                              style: kSmallText.copyWith(
                                color: Get.isDarkMode
                                    ? kWhiteColor
                                    : const Color(0xFF707070),
                              ),
                            ),
                          ],
                        ),
                      ),
                      kWidthBox5,
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
