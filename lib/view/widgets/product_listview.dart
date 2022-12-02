import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/view/screens/product/product_details.dart';

import 'product_card_list.dart';

class ProductListView extends StatelessWidget {
  final int? productLength;
  final bool? noPadding;
  final Color? cardColor;
  final ScrollController controller;
  final List<ProductList>? productList;

  const ProductListView({
    Key? key,
    this.productLength,
    this.productList,
    required this.controller,
    this.noPadding = true,
    this.cardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: controller,
      itemCount: productList!.length,
      padding: noPadding == true
          ? EdgeInsets.zero
          : const EdgeInsets.all(
              10,
            ),
      itemBuilder: (context, int index) {
        return InkWell(
            onTap: () {
              Get.to(
                ProductDetailsScreen(
                  id: productList![index].id!,
                  productDetails: productList![index],
                ),
              );
            },
            child: ProductCardList(
              image: productList![index].images == null
                  ? null
                  : productList![index].images![0].src,
              title: productList![index].name,
              price: productList![index].price == ""
                  ? null
                  : productList![index].price,
              prevPrice: productList![index].regularPrice == ""
                  ? null
                  : productList![index].regularPrice,
              reviewCount: '200',
              reviewStar: double.parse(productList![index].averageRating!),
              cardColor: cardColor ?? Theme.of(context).backgroundColor,
            ));
      },
    );
  }
}
