import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';

class PoliciesScreen extends StatelessWidget {
  static const routeName = 'policies_screen';

  const PoliciesScreen({Key? key, this.initialIndex = 0}) : super(key: key);
  final int initialIndex;

  TabBar get _tabBar => TabBar(
        indicatorWeight: 0.1,
        indicatorColor: Colors.transparent,
        labelColor: kPrimaryColor,
        isScrollable: false,
        unselectedLabelColor: Get.isDarkMode ? kWhiteColor : kBlackColor2,
        unselectedLabelStyle: kRegularText2.copyWith(
          color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: kRegularText2.copyWith(
          color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
          fontWeight: FontWeight.w700,
        ),
        tabs: [
          Tab(
            text: 'Privacy Policy'.tr,
          ),
          Tab(
            text: 'Trams & Conditions'.tr,
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Policies'.tr),
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: ColoredBox(
              color: const Color(0xFFFF9E73).withOpacity(0.2),
              child: _tabBar,
            ),
          ),
        ),
        body: TabBarView(
          children: [
            buildPolicies(context, kPrivacyPolices),
            buildPolicies(context, kTermsConditions),
          ],
        ),
      ),
    );
  }

  buildPolicies(BuildContext context, String text) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(
          text,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
