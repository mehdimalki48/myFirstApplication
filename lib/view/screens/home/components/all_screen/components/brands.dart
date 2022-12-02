import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/home_controller.dart';
import 'package:woogoods/view/screens/home/components/all_screen/more_screen/brand_list_screen.dart';
import 'package:woogoods/view/screens/home/components/all_screen/widgets/more_widgets.dart';
import 'package:woogoods/view/screens/search/search_screen.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';

class Brands extends StatelessWidget {
  final HomeController productController;

  const Brands({Key? key, required this.productController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return productController.isBrandLoading
        ? Container(
      padding: const EdgeInsets.all(
        10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          kOrdinaryShadow,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Brands'.tr,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              MoreWidgets(
                onTap: () {},
              ),
            ],
          ),
          kHeightBox10,
          brandShimmer(itemCount: 4),
        ],
      ),
    )
        : productController.brandList.isEmpty
        ? const SizedBox()
        : Container(
      padding: const EdgeInsets.all(
        10,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          kOrdinaryShadow,
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Brands'.tr,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(
                  color:
                  Get.isDarkMode ? kWhiteColor : kBlackColor2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              MoreWidgets(
                onTap: () => Get.to(() => BrandListScreen(
                  productController: productController,
                )),
              ),
            ],
          ),
          kHeightBox10,
          MasonryGridView.count(
            crossAxisCount: 4,
            shrinkWrap: true,
            itemCount: productController.brandList.length > 8
                ? 8
                : productController.brandList.length,
            physics: const ScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => Get.to(() => SearchScreen(
                  brandId:
                  (productController.brandList[index].id ?? 0)
                      .toString(),
                ),),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.5,
                      child: productController
                          .brandList[index].thumbnailImage ==
                          null
                          ? Container(
                        decoration: BoxDecoration(
                          color: kOrdinaryColor2,
                          borderRadius:
                          BorderRadius.circular(5),
                        ),
                        child: Image.asset(
                          Images.placeHolder,
                        ),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                          imageUrl: productController
                              .brandList[index]
                              .thumbnailImage ??
                              '',
                          fit: BoxFit.fitHeight,
                          placeholder: (context, url) =>
                              Container(
                                decoration: BoxDecoration(
                                  color: kOrdinaryColor2,
                                  borderRadius:
                                  BorderRadius.circular(5),
                                ),
                                child:
                                Image.asset(Images.placeHolder),
                              ),
                          errorWidget: (context, url, error) =>
                          const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    kHeightBox5,
                    Text(
                      productController.brandList[index].name ?? '',
                      style: kDescriptionText.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Get.isDarkMode
                            ? kWhiteColor
                            : kBlackColor2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
