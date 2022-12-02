import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/view/screens/product/product_details.dart';

import 'product_card_grid.dart';

class ProductGridList extends StatelessWidget {
  final bool? noPadding;
  final bool isCart, reverse, isProductDetails;
  final List<ProductList>? productList;
  final ScrollController? controller;
  final int productId;

  const ProductGridList({
    Key? key,
    this.productList,
    this.controller,
    this.noPadding = true,
    this.isCart = false,
    this.reverse = false,
    this.isProductDetails = false,
    this.productId = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MasonryGridView.count(
          reverse: reverse,
          controller: controller,
          crossAxisCount: 2,
          shrinkWrap: true,
          itemCount: productList!.length,
          physics: const ScrollPhysics(),
          mainAxisSpacing: 9.0,
          crossAxisSpacing: 9.0,
          padding: noPadding == true
              ? EdgeInsets.zero
              : const EdgeInsets.all(
                  10,
                ),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                if (isProductDetails) {
                  log('isProductDetails');
                  if ((productList![index].id ?? 0) == productId) {
                    showCustomSnackBar(
                      'same product',
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                                id: productList![index].id!,
                                productDetails: productList![index],
                              ),),
                    );
                  }
                } else {
                  log('isProductDetails false');
                  Get.to(
                    () => ProductDetailsScreen(
                      id: productList![index].id!,
                      productDetails: productList![index],
                    ),
                  );
                }
              },
              child: ProductCardGrid(
                isCart: isCart,
                image: productList![index].images![0].src,
                title: productList![index].name,
                price: productList![index].price == ""
                    ? null
                    : productList![index].price,
                prevPrice: productList![index].regularPrice == ""
                    ? null
                    : productList![index].regularPrice,
                reviewCount: productList![index].ratingCount.toString(),
                reviewStar: double.parse(
                  productList![index].averageRating!,
                ),
                product: productList![index],
              ),
            );
          },
        ),
      ],
    );
  }
}
