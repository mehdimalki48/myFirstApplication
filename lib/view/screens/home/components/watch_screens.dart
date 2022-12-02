import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/controllers/product_controller.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';
import 'package:woogoods/view/widgets/product_listview.dart';

class WatchScreens extends StatefulWidget {
  final String? categoryId;

  const WatchScreens({Key? key, this.categoryId,}) : super(key: key);

  @override
  State<WatchScreens> createState() => _WatchScreensState();
}

class _WatchScreensState extends State<WatchScreens> {
  final ProductController productController = Get.find();
  final _scrollController = ScrollController();

  @override
  void initState() {
    getProducts();
    _scrollController.addListener(addProducts);
    super.initState();
  }

  void getProducts({bool reload = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productController.fetchProductsList(
          productController.offset.toString(),
          reload,
          parentId: widget.categoryId
      );
    });
  }

  void addProducts() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      log('===========>>>work');
      productController.changeOffset();
      productController.showBottomLoader();
      getProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () {
          if (productController.isLoading.isTrue) {
            return productsListShimmer();
          } else {
            if (productController.productList.isEmpty) {
              return const Center(
                child: Text('No Products Available'),
              );
            } else {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  ProductListView(
                    controller: _scrollController,
                    productList: productController.productList,
                    noPadding: false,
                    cardColor: Theme
                        .of(context)
                        .cardColor,
                  ),
                  Positioned(
                    bottom: -20,
                    child: productController.isLoadingMore.isTrue
                        ? const CustomLoader()
                        : const SizedBox(),
                  ),
                ],
              );
            }
          }
        },
      ),
    );
  }
}
