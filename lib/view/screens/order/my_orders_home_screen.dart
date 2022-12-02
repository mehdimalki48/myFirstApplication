import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/util/md2_indicator.dart';

import 'widgets/order_list_widgets.dart';

class MyOrdersHomeScreen extends StatelessWidget {
  static const routeName = 'my_orders_home_screen';
  const MyOrdersHomeScreen({Key? key, this.initialIndex = 0}) : super(key: key);
  final int initialIndex;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('My Order'.tr),
          bottom: TabBar(
            indicatorColor: kPrimaryColor,
            labelColor: kPrimaryColor,
            isScrollable: true,
            unselectedLabelColor: Get.isDarkMode ? kWhiteColor : kBlackColor2,
            unselectedLabelStyle: Theme.of(context).textTheme.headline2,
            labelStyle: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
            indicator: const MD2Indicator(
              indicatorSize: MD2IndicatorSize.normal,
              indicatorHeight: 4.0,
              indicatorColor: kPrimaryColor,
            ),
            tabs: [
              Tab(
                text: 'All'.tr,
              ),
              Tab(
                text: 'Pending'.tr,
              ),
              Tab(
                text: 'On Hold'.tr,
              ),
              Tab(
                text: 'Processing'.tr,
              ),
              Tab(
                text: 'Delivered'.tr,
              ),
              Tab(
                text: 'Returned'.tr,
              ),
              Tab(
                text: 'Cancelled'.tr,
              ),
              Tab(
                text: 'Failed'.tr,
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            OrderListWidgets(
              orderStatusCheck: true,
              orderStatus: 'any',
            ),
            OrderListWidgets(
              paymentStatus: false,
              orderStatus: 'pending',
            ),
            OrderListWidgets(
              orderStatus: 'on-hold',
            ),
            OrderListWidgets(
              orderStatus: 'processing',
            ),
            OrderListWidgets(
              orderStatus: 'completed',
            ),
            OrderListWidgets(
              orderStatus: 'refunded',
            ),
            OrderListWidgets(
              orderStatus: 'cancelled',
            ),
            OrderListWidgets(
              orderStatus: 'failed',
            ),
          ],
        ),
      ),
    );
  }
}
