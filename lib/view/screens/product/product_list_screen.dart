import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/controllers/product_controller.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';
import 'package:woogoods/view/widgets/product_grid_list.dart';

class ProductListScreen extends StatefulWidget {
  static const routeName = 'recent_view_screen';
  final bool isRecent;
  final bool isOnSale;
  final bool isFeature;
  final String? title;
  final String? orderBy;

  const ProductListScreen({
    Key? key,
    this.isRecent = false,
    this.isOnSale = false,
    this.isFeature = false,
    this.title,
    this.orderBy,
  }) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductController productController = Get.find();
  final _scrollController = ScrollController();

  @override
  void initState() {
    getProducts();
    _scrollController.addListener(addProducts);
    super.initState();
  }

  void getProducts({bool reload = false}) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await productController.fetchProductsList(
          productController.offset.toString(),
          reload,
          onSale: widget.isOnSale,
          feature: widget.isFeature,
          orderBy: widget.orderBy,
        );
      },
    );
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
      appBar: AppBar(
        title: Text(widget.isRecent ? 'Recent View'.tr : widget.title ?? ""),
        actions: [
          if (widget.isRecent)
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 10),
              child: Text(
                'Clear',
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
        ],
      ),
      body: Obx(
        () {
          if (productController.isLoading.isTrue) {
            return Center(
              child: productsGridShimmer(),
            );
          } else if (productController.productsList.isEmpty) {
            return const Center(
              child: Text('No Products Found!'),
            );
          } else {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                ProductGridList(
                  controller: _scrollController,
                  noPadding: false,
                  isCart: true,
                  productList: productController.productList,
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
        },
      ),

      // GetBuilder<ProductController>(
      //   builder: (productController) {
      //     if (productController.productList.isEmpty) {
      //       return const CustomLoader();
      //     }
      //     return ProductGridList(
      //       noPadding: false,
      //       isCart: true,
      //       productList: productController.categoriesList,
      //     );
      //   },
      // ),
    );
  }
}
