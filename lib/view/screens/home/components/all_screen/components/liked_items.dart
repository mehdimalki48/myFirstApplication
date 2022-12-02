import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/home_controller.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';
import 'package:woogoods/view/widgets/product_grid_list.dart';

class LikedItems extends StatelessWidget {
  final HomeController productController;
  final ScrollController scrollController;

  const LikedItems({
    Key? key,
    required this.productController,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !Get.find<HomeController>().isLoading) {
        int pageSize = 10;
        if (Get.find<HomeController>().offset < pageSize) {
          Get.find<HomeController>()
              .setOffset(Get.find<HomeController>().offset + 1);
          log('end page');
          Get.find<HomeController>().showBottomLoader();
          Get.find<HomeController>().fetchHomeProductList(
            Get.find<HomeController>().offset.toString(),
            false,
          );
        }
      }
    });
    return Column(
      children: [
        Container(
          child: productController.isShimmerLoading
              ? productsGridShimmer()
              : productController.featuredProduct.isNotEmpty
                  ? ProductGridList(
                      noPadding: true,
                      isCart: false,
                      productList: productController.featuredProduct,
                    )
                  : Center(
                      child: Text(
                        'No comment available',
                        style: kRegularText2,
                      ),
                    ),
        ),
        productController.isLoading ? const CustomLoader() : const SizedBox(),
      ],
    );
  }
}
