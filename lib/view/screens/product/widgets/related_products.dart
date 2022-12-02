import 'package:flutter/material.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:get/get.dart';
import 'package:woogoods/controllers/product_controller.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';
import 'package:woogoods/view/widgets/product_grid_list.dart';

class RelatedProducts extends StatelessWidget {
  final ProductController productController = Get.find();
  final int catId;
  final int productId;
  RelatedProducts({
    Key? key,
    required this.catId,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await productController.fetchProductsList(
          productController.offset.toString(),
          false,
          parentId: catId.toString(),
        );
      },
    );

    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 1.5,
                  width: 70,
                  color: const Color(0xFFC4C4C4),
                ),
                Positioned(
                  right: -2,
                  top: -1.7,
                  child: Container(
                    height: 5,
                    width: 5,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC4C4C4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            kWidthBox10,
            Text(
              'Related Products'.tr,
              style: kAppBarText.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            kWidthBox10,
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 1.5,
                  width: 70,
                  color: const Color(0xFFC4C4C4),
                ),
                Positioned(
                  left: -2,
                  top: -1.7,
                  child: Container(
                    height: 5,
                    width: 5,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC4C4C4),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        kHeightBox5,
        Obx(
          () {
            if (productController.isLoading.isTrue) {
              return Center(
                child: productsGridShimmer(itemCount: 2),
              );
            } else {
              return ProductGridList(
                productList: productController.productsList,
                noPadding: false,
                isProductDetails: true,
                productId: productId,
              );
            }
          },
        ),
      ],
    );
  }
}
