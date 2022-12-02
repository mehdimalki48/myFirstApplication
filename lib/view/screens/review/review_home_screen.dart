import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/view/widgets/app_bar_actions.dart';
import '../../../constants/style_data.dart';
import '../../../controllers/home_review_controller.dart';
import '../../widgets/custom_bottom_loader.dart';
import '../../widgets/custom_shimmer.dart';
import 'widgets/review_widget.dart';

class ReviewHomeScreen extends StatelessWidget {
  static const routeName = 'review_home_screen';

  const ReviewHomeScreen({Key? key}) : super(key: key);

  Future<void> _loadData(bool reload) async {
    Get.find<HomeReviewController>().fetchAllReviews('1', reload);
  }

  @override
  Widget build(BuildContext context) {
    //load data
    _loadData(false);
    ScrollController scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !Get.find<HomeReviewController>().isLoading) {
        if (!Get.find<HomeReviewController>().noMoreData) {
          Get.find<HomeReviewController>()
              .setOffset(Get.find<HomeReviewController>().offset + 1);
          log('end page');
          Get.find<HomeReviewController>().showBottomLoader();
          Get.find<HomeReviewController>().fetchAllReviews(
            Get.find<HomeReviewController>().offset.toString(),
            false,
          );
        }else{
          showCustomSnackBar('No more review',);
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'.tr),
        actions: const [
          AppBarActions(
            isWishlist: true,
            isSearch: true,
            isCart: true,
          ),
        ],
      ),
      body: GetBuilder<HomeReviewController>(
        builder: (reviewController) {
          return Stack(
            children: [
              SingleChildScrollView(
                controller: scrollController,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Container(
                    child: reviewController.isShimmerLoading
                        ? buildReviewsShimmer()
                        : reviewController.reviewList.isNotEmpty
                            ? ListView.builder(
                                itemCount: reviewController.reviewList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, int index) {
                                  return ReviewWidget(
                                    reviews:  reviewController.reviewList[index],
                                    product:  reviewController.reviewList[index].productList,
                                  );
                                },)
                            : Center(
                                child: Text(
                                  'No review available'.tr,
                                  style: kRegularText2,
                                ),
                              ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child:
                    CustomBottomLoader(isLoading: reviewController.isLoading),
              )
            ],
          );
        },
      ),
    );
  }
}
