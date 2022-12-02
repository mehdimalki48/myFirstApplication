import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/cart_controller.dart';
import 'package:woogoods/models/response/product_list.dart';

import '../../util/others_methods.dart';
import 'icon_btn.dart';

class ProductCardGrid extends StatelessWidget {
  final bool isCart;
  final String? image;
  final String? title;
  final String? price;
  final String? prevPrice;
  final String? reviewCount;
  final double? reviewStar;
  final ProductList? product;

  const ProductCardGrid({
    Key? key,
    this.isCart = false,
    this.image,
    this.title,
    this.price,
    this.prevPrice,
    this.reviewCount,
    this.reviewStar = 0.0,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          kOrdinaryShadow,
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                child: image != null
                    ? ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: image ??
                              'https://g3fashion.cdn.imgeng.in/upload/products/medium/wedding_wear_orange_hue_gown_for_little_girl_16325684162528_as2168689.jpg',
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
                        ),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          color: kOrdinaryColor2,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        //height: getProportionateScreenWidth(95),
                        width: getProportionateScreenWidth(95),
                        child: Image.asset(Images.placeHolder),
                      ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: prevPrice != null && double.parse(prevPrice ?? '0') > double.parse(price ?? '0') ? Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: kPrimaryColor,
                  ),
                  child: Text(
                    '${((double.parse(prevPrice ?? '0') - double.parse(price ?? '0'))/double.parse(prevPrice ?? '0')*100).toInt()}% off',
                    style: kSmallText.copyWith(
                      color: kWhiteColor,
                    ),
                  ),
                ) : const SizedBox(),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ?? '',
                  style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 14.0,
                        height: 1.25,
                      ),
                  maxLines: 2,
                ),
                kHeightBox5,
                Row(
                  children: [
                    Text(
                      kCurrency + '$price',
                      style: kRegularText.copyWith(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    if(prevPrice != null && double.parse(prevPrice ?? '0') > double.parse(price ?? '0'))
                      Row(
                        children: [
                          kWidthBox10,
                          Text(
                            kCurrency + '$prevPrice',
                            style: kDescriptionText.copyWith(
                              color: Get.isDarkMode ? kWhiteColor : kStUnderLineColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),

                  ],
                ),
                kHeightBox10,
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: reviewStar!,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 14.0,
                      direction: Axis.horizontal,
                    ),
                    kWidthBox5,
                    Text(
                      '($reviewCount)',
                      style: kDescriptionText.copyWith(
                        color: Get.isDarkMode ? kWhiteColor : kStUnderLineColor,
                      ),
                    ),
                    const Spacer(),
                    isCart
                        ? GetBuilder<CartController>(builder: (cartController){
                          return IconButtons(
                            padding: 10,
                            height: 22,
                            onPress: () async{
                              if (product?.manageStock ?? false) {
                                int cartQuantity = cartController.cartItemQuantity(product?.id ?? 0);log('$cartQuantity');
                                if (cartQuantity < (product?.stockQuantity ?? 0)) {
                                  if (OthersMethod.variationsIsEmptyCheck(product!)) {
                                    //added variation + cart
                                    await OthersMethod.variationsSelected(product!);
                                    cartController.addToCart(product!,
                                      price: OthersMethod.productPriceCalculate(product!),
                                      quantity: 1,
                                      brand: OthersMethod.selectedBrands(product!),
                                      variations: OthersMethod.setVariationDataInCart(cartController),
                                    );
                                  } else {
                                    cartController.addToCart(product!,
                                      price: OthersMethod.productPriceCalculate(product!),
                                      quantity: 1,
                                      brand: OthersMethod.selectedBrands(product!),
                                    );
                                  }
                                } else {
                                  showCustomSnackBar('No more stock!'.tr,);
                                }
                              } else {
                                showCustomSnackBar(
                                    'This product out of stock!');
                              }
                            },
                            imageURL: Images.cart,
                          );
                    })
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
