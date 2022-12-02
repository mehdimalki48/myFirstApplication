import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/home_controller.dart';
import 'package:woogoods/view/screens/home/components/all_screen/widgets/more_widgets.dart';
import 'package:woogoods/view/screens/product/product_details.dart';
import 'package:woogoods/view/screens/product/product_list_screen.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';

class TodayDeal extends StatelessWidget {
  final HomeController productController;

  const TodayDeal({
    Key? key,
    required this.productController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: productController.isTodayLoading
          ? Container(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'TodayDeal'.tr,
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontWeight: FontWeight.w600,
                              color:
                                  Get.isDarkMode ? kWhiteColor : kBlackColor2,
                            ),
                      ),
                      const Spacer(),
                      MoreWidgets(
                        onTap: () => Get.to(
                          () => ProductListScreen(
                            title: 'TodayDeal'.tr,
                            isFeature: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                  kHeightBox10,
                  homeProductShimmer(),
                ],
              ),
            )
          : productController.todayDeal.isEmpty
              ? const SizedBox()
              : Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'TodayDeal'.tr,
                            style:
                                Theme.of(context).textTheme.headline1!.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Get.isDarkMode
                                          ? kWhiteColor
                                          : kBlackColor2,
                                    ),
                          ),
                          const Spacer(),
                          MoreWidgets(
                            onTap: () => Get.to(
                              () => ProductListScreen(
                                title: 'TodayDeal'.tr,
                                isFeature: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                      kHeightBox10,
                      SizedBox(
                        height: getProportionateScreenWidth(120),
                        child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              productController.featuredProducts.length > 10
                                  ? 10
                                  : productController.featuredProducts.length,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () => Get.to(
                                () => ProductDetailsScreen(
                                  id: productController
                                      .featuredProducts[index].id!,
                                  productDetails:
                                      productController.featuredProducts[index],
                                ),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      right: index == 9 ? 0 : 10,
                                    ),
                                    height: getProportionateScreenWidth(95),
                                    width: getProportionateScreenWidth(95),
                                    child: productController
                                                .featuredProducts[index]
                                                .images !=
                                            null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: CachedNetworkImage(
                                              imageUrl: productController
                                                  .featuredProducts[index]
                                                  .images![0]
                                                  .src!,
                                              placeholder: (context, url) =>
                                                  Container(
                                                decoration: BoxDecoration(
                                                  color: kOrdinaryColor2,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Image.asset(
                                                    Images.placeHolder),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              color: kOrdinaryColor2,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            height:
                                                getProportionateScreenWidth(95),
                                            width:
                                                getProportionateScreenWidth(95),
                                            child:
                                                Image.asset(Images.placeHolder),
                                          ),
                                  ),
                                  kHeightBox5,
                                  Text(
                                    kCurrency +
                                        '${productController.featuredProducts[index].regularPrice}',
                                    style: kRegularText2.copyWith(
                                      color: Get.isDarkMode
                                          ? kWhiteColor
                                          : kBlackColor2,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
