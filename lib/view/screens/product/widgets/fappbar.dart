import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/product_details_overview_data.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/services/localization_services.dart';
import 'package:woogoods/view/widgets/app_bar_actions.dart';

import 'headers_products.dart';

//get current localization
String? currentLng = LocalizationService().getCurrentLang();

class FAppBar extends SliverAppBar {
  final PageData data;
  final ProductList? productDetails;
  final BuildContext context;
  final bool isCollapsed;
  final double expandedHeight2;
  final double collapsedHeight2;
  final AutoScrollController scrollController;
  final TabController tabController;
  final void Function(bool isCollapsed) onCollapsed;
  final void Function(int index) onTap;

  const FAppBar({
    Key? key,
    required this.data,
    required this.context,
    required this.productDetails,
    required this.isCollapsed,
    required this.expandedHeight2,
    required this.collapsedHeight2,
    required this.scrollController,
    required this.onCollapsed,
    required this.onTap,
    required this.tabController,
  }) : super(key: key, elevation: 0.0, pinned: true, forceElevated: true);

  @override
  Color? get backgroundColor => Theme.of(context).cardColor;

  @override
  double? get expandedHeight => expandedHeight2;
  @override
  Widget? get leading {
    return IconButton(
      onPressed: () => Get.back(),
      icon: Icon(
        Icons.arrow_back,
        color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
      ),
    );
  }

  @override
  List<Widget>? get actions {
    return [
      const AppBarActions(
        isCart: true,
        isMoreVert: true,
      ),
    ];
  }

  @override
  Widget? get title {
    var textTheme = Theme.of(context).textTheme;
    return AnimatedOpacity(
      opacity: isCollapsed ? 0 : 1,
      duration: const Duration(milliseconds: 250),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productDetails?.name ?? '',
            style: textTheme.headline1,
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? get bottom {
    return PreferredSize(
      preferredSize: Size(SizeConfig.screenWidth!, 48),
      child: isCollapsed == false
          ? Container(
              color: Theme.of(context).cardColor,
              child: Container(
                alignment: Alignment.center,
                color: Theme.of(context).cardColor,
                margin: EdgeInsets.only(
                    right: LocalizationService().getCurrentLang() == 'Arabic'
                        ? 0
                        : 20,
                    left: LocalizationService().getCurrentLang() == 'Arabic'
                        ? 20
                        : 0),
                child: TabBar(
                  isScrollable: false,
                  controller: tabController,
                  indicatorPadding: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  labelPadding: EdgeInsets.zero,
                  indicatorColor: kPrimaryColor,
                  labelColor: kPrimaryColor,
                  unselectedLabelColor:
                      Get.isDarkMode ? kWhiteColor : kBlackColor2,
                  indicatorWeight: 3.0,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelStyle: kRegularText2.copyWith(
                    color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                    fontWeight: FontWeight.w400,
                  ),
                  labelStyle: kRegularText2.copyWith(
                    color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: data.categories.map((e) {
                    return Tab(text: e.title);
                  }).toList(),
                  onTap: onTap,
                ),
              ),
            )
          : Container(),
    );
  }

  @override
  Widget? get flexibleSpace {
    return SafeArea(
      child: LayoutBuilder(
        builder: (
          BuildContext context,
          BoxConstraints constraints,
        ) {
          final top = constraints.constrainHeight();
          final collapsedHeight =
              MediaQuery.of(context).viewPadding.top + kToolbarHeight + 48;
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            onCollapsed(collapsedHeight != top);
          });

          return FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: ProductHeaders(
              product: productDetails,
            ),
          );
        },
      ),
    );
  }
}
