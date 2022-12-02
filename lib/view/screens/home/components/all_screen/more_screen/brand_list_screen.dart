import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/home_controller.dart';
import 'package:woogoods/view/screens/search/search_screen.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';

class BrandListScreen extends StatelessWidget {
  static const routeName = 'brand_list_screen';
  final HomeController productController;

  const BrandListScreen({Key? key, required this.productController})
      : super(key: key);
  Future<void> _loadData(bool reload) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.find<HomeController>().fetchBrandList('1', reload, perPage: '99',);
    });
  }

  @override
  Widget build(BuildContext context) {
    //load data
    _loadData(false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Brands'.tr),
      ),
      body: productController.isBrandLoading
          ? brandShimmer(itemCount: 24, crossCount: 3)
          : productController.brandList.isEmpty
          ? Center(
        child: Text(
          'No data available'.tr,
          style: Theme.of(context).textTheme.headline2,
        ),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 10),
          child: MasonryGridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            itemCount: productController.brandList.length,
            physics: const ScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () => Get.to(() => SearchScreen(
                  brandId: (productController.brandList[index].id ?? 0).toString() ,
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
                          : Container(
                          decoration: BoxDecoration(
                            color: kOrdinaryColor2,
                            borderRadius:
                            BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.circular(5),
                              child: CachedNetworkImage(
                                imageUrl: productController
                                    .brandList[index]
                                    .thumbnailImage ?? '',
                                placeholder: (context, url) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        color: kOrdinaryColor2,
                                        borderRadius:
                                        BorderRadius.circular(5),
                                      ),
                                      child: Image.asset(
                                          Images.placeHolder),
                                    ),
                                errorWidget:
                                    (context, url, error) =>
                                const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )),
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
        ),
      ),
    );
  }
}
