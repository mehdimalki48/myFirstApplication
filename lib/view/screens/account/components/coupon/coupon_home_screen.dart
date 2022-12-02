import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/coupon_controller.dart';

import 'coupon_list_screen.dart';

class CouponHomeScreen extends StatelessWidget {
  static const routeName = 'coupon_home_screen';
  const CouponHomeScreen({Key? key, this.initialIndex = 0}) : super(key: key);
  final int initialIndex;
  TabBar get _tabBar => TabBar(
        indicatorWeight: 0.1,
        indicatorColor: Colors.transparent,
        labelColor: kPrimaryColor,
        isScrollable: false,
        unselectedLabelColor: Get.isDarkMode ? kWhiteColor : kBlackColor,
        unselectedLabelStyle: kRegularText2.copyWith(
          color: Get.isDarkMode ? kWhiteColor : kBlackColor,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: kRegularText2.copyWith(
          color: Get.isDarkMode ? kWhiteColor : kBlackColor,
          fontWeight: FontWeight.w700,
        ),
        tabs: [
          Tab(
            text: 'Coupon Center'.tr,
          ),
          Tab(
            text: 'My Coupon'.tr,
          ),
        ],
      );
  @override
  Widget build(BuildContext context) {
    Get.find<CouponController>().setOffset(1);
    Get.find<CouponController>().fetchCouponList('1', false);
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Coupon'.tr),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: ColoredBox(
              color: const Color(0xFFFF9E73).withOpacity(0.2),
              child: _tabBar,
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            CouponListScreen(),
            CouponListScreen(couponStatus: true),
          ],
        ),
      ),
    );
  }
}
