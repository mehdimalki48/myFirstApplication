import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/response/cart_model.dart';

import '../../../../models/body/line_items.dart';
import '../../../../util/others_methods.dart';

class CheckoutProductCard extends StatelessWidget {
  final CartModel data;
  const CheckoutProductCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<MetaCartData> variations = OthersMethod.getCartVariationList(variations: data.variations);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kWidthBox10,
              SizedBox(
                width: getProportionateScreenWidth(70),
                height: getProportionateScreenWidth(60),
                child: data.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: data.image ?? '',
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              color: kOrdinaryColor2,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Image.asset(
                              kImageDir + 'placeholder.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            kImageDir + 'placeholder.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: kOrdinaryColor2,
                            borderRadius: BorderRadius.circular(5),
                            image: const DecorationImage(
                                image: AssetImage(
                                  kImageDir + 'placeholder.png',
                                ),
                                fit: BoxFit.cover)),
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
                        data.title ?? '',
                        maxLines: 1,
                        style: kRegularText2.copyWith(
                          color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                        ),
                      ),
                      kHeightBox10,
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000).withOpacity(.10),
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            '${data.brand ?? ''}${variations.isEmpty ?  '' : OthersMethod.variationsShow(variations)}',
                            textAlign: TextAlign.center,
                            style: kSmallText.copyWith(
                              color:
                                  Get.isDarkMode ? kWhiteColor : kBlackColor2,
                              fontSize: 10.0,
                              fontWeight: FontWeight.w300,
                            ),
                          )),
                      kHeightBox5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            kCurrency + '${data.price ?? 0}',
                            style: kRegularText.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'x${data.quantity ?? 0}',
                            style: kRegularText2.copyWith(
                                color:
                                    Get.isDarkMode ? kWhiteColor : kBlackColor2,
                                fontWeight: FontWeight.w300,
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        kHeightBox10,
      ],
    );
  }
}
