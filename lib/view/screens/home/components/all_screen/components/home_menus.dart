import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/view/screens/account/components/coupon/coupon_home_screen.dart';
import 'package:woogoods/view/screens/home/components/all_screen/widgets/menu_widgets.dart';
import 'package:woogoods/view/screens/product/product_list_screen.dart';
import 'package:woogoods/view/screens/wishlist/wishlist_screen.dart';

class HomeMenus extends StatelessWidget {
  const HomeMenus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Get.to(() => ProductListScreen(
                  title: 'Hot Sale'.tr,
                orderBy: 'popularity'
                )),
            child: MenuWidgets(
              title: 'Hot Sale'.tr,
              color: const Color(0xFFEA5230),
              icon: Images.flashSale,
            ),
          ),
          InkWell(
            onTap: () => Get.to(() => ProductListScreen(
                  title: 'Trending'.tr,
                orderBy: 'rating'
                )),
            child: MenuWidgets(
              title: 'Trending'.tr,
              color: const Color(0xFF50C9C3),
              icon: Images.trend,
            ),
          ),
          InkWell(
            onTap: () => Get.to(() => ProductListScreen(
                  title: 'Free Shipping'.tr,
                  isOnSale: true,
                )),
            child: MenuWidgets(
              title: 'Free Shipping'.tr,
              color: const Color(0xFF5242A4),
              icon: Images.freeDelivery,
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(() => const CouponHomeScreen());
            },
            child: MenuWidgets(
              title: 'Coupon'.tr,
              color: const Color(0xFF04924E),
              icon: Images.coupon,
            ),
          ),
          InkWell(
            onTap: () {
              Get.to(const WishListScreen());
            },
            child: MenuWidgets(
              title: 'Wishlist'.tr,
              color: const Color(0xFF2DB2FD),
              icon: Images.wishList,
            ),
          ),
        ],
      ),
    );
  }
}
