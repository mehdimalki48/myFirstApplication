import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/home_controller.dart';

import 'components/brands.dart';
import 'components/flash_deal.dart';
import 'components/home_menus.dart';
import 'components/liked_items.dart';
import 'components/slider.dart';
import 'components/today_deal.dart';

class AllScreens extends StatelessWidget {
  const AllScreens({Key? key}) : super(key: key);

  Future<void> _loadData(bool reload) async {
    Get.find<HomeController>().fetchSliderList('1', reload);
    Get.find<HomeController>().fetchFlashSaleList('1', reload);
    Get.find<HomeController>().fetchTodaySellList('1', reload);
    Get.find<HomeController>().fetchBrandList('1', reload, );
    Get.find<HomeController>().fetchHomeProductList('1', reload);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      body: RefreshIndicator(
        color: kPrimaryColor,
        backgroundColor: Theme.of(context).cardColor,
        displacement: 0,
        onRefresh: () async {
          await _loadData(true);
        },
        child: GetBuilder<HomeController>(
          builder: (homeController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  kHeightBox10,
                  AllSlider(
                    homeController: homeController,
                  ),
                  const HomeMenus(),
                  FlashDeal(
                    productController: homeController,
                  ),
                  kHeightBox10,
                  AspectRatio(
                    aspectRatio: 2.5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kOrdinaryColor2,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: isImageShow
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://i.postimg.cc/9QXp0c6K/i-1.png',
                                fit: BoxFit.fill,
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
                              //height: getProportionateScreenWidth(95),
                              //  width: getProportionateScreenWidth(95),
                              child: Image.asset(Images.placeHolder),
                            ),
                    ),
                  ),
                  kHeightBox10,
                  TodayDeal(
                    productController: homeController,
                  ),
                  kHeightBox10,
                  Brands(
                    productController: homeController,
                  ),
                  kHeightBox10,
                  AspectRatio(
                    aspectRatio: 2.5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: kOrdinaryColor2,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: isImageShow
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://i.postimg.cc/9QXp0c6K/i-1.png',
                                fit: BoxFit.fill,
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
                              //height: getProportionateScreenWidth(95),
                              //  width: getProportionateScreenWidth(95),
                              child: Image.asset(Images.placeHolder),
                            ),
                    ),
                  ),
                /*  kHeightBox10,
                  const TrendingStore(),
                  kHeightBox10,
                  const TopSale(),*/
                  kHeightBox15,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 1.5,
                            width: 70,
                            color: const Color(0xFFC4C4C4),
                          ),
                          Positioned(
                            right: -2,
                            top: -1.7,
                            child: Container(
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                color: Color(0xFFC4C4C4),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                      kWidthBox10,
                      Text(
                        'You May Like'.tr,
                        style: kAppBarText.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      kWidthBox10,
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 1.5,
                            width: 70,
                            color: const Color(0xFFC4C4C4),
                          ),
                          Positioned(
                            left: -2,
                            top: -1.7,
                            child: Container(
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                color: Color(0xFFC4C4C4),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  kHeightBox15,
                  LikedItems(
                    scrollController: scrollController,
                    productController: homeController,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
