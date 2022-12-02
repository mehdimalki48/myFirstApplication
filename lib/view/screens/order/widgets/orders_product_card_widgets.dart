import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/response/order_list.dart';

class ProductCardWidgets extends StatelessWidget {
  final LineItems product;
  const ProductCardWidgets({Key? key, required this.product}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                kWidthBox10,
                isImageShow
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://xsport.bg/userfiles/productlargeimages/product_1007846.jpg',
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: kOrdinaryColor2,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(kImageDir + 'placeholder.png'),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                              color: kOrdinaryColor2,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(kImageDir + 'placeholder.png'),
                          ),
                          width: getProportionateScreenWidth(70),
                          height: getProportionateScreenWidth(70),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          color: kOrdinaryColor2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: getProportionateScreenWidth(60),
                        height: getProportionateScreenWidth(60),
                        child: Image.asset(kImageDir + 'placeholder.png'),
                      ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? '',
                          maxLines: 1,
                          style: kRegularText2.copyWith(
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          ),
                        ),
                        /* size10,
                        Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF000000).withOpacity(.10),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              'Two Battery Red / UK',
                              textAlign: TextAlign.center,
                              style: kSmallText.copyWith(
                                color:
                                    Get.isDarkMode ? kWhiteColor : kBlackColor2,
                                fontSize: 10.0,
                                fontWeight: FontWeight.w300,
                              ),
                            )),*/
                        kHeightBox10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              kCurrency + '${product.price ?? 0}',
                              style: kRegularText.copyWith(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'x${product.quantity ?? 0}',
                              style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 14.0),
                            ),
                          ],
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
