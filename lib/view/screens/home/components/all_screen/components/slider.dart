import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/controllers/home_controller.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';

class AllSlider extends StatelessWidget {
  final HomeController homeController;

  const AllSlider({
    Key? key,
    required this.homeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: homeController.sliderList.isEmpty
          ? sliderShimmer()
          : Stack(
              fit: StackFit.loose,
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                      aspectRatio: 2.5,
                      viewportFraction: 1,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 1000),
                      autoPlayCurve: Curves.easeInCubic,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      onPageChanged: (int index, reason) {
                        homeController.setCurrentIndex(index, true);
                      }),
                  items: homeController.sliderList
                      .map(
                        (item) => SizedBox(
                          width: double.infinity,
                          child: item.embedded?.wpfeaturedmedia?[0].sourceUrl !=
                                  null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: item.embedded?.wpfeaturedmedia?[0]
                                            .sourceUrl ??
                                        '',
                                    fit: BoxFit.fill,
                                    placeholder: (context, url) => Container(
                                      decoration: BoxDecoration(
                                        color: kOrdinaryColor2,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      //height: getProportionateScreenWidth(95),
                                      //  width: getProportionateScreenWidth(95),
                                      child: Image.asset(Images.placeHolder),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: kOrdinaryColor2,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  //height: getProportionateScreenWidth(95),
                                  //  width: getProportionateScreenWidth(95),
                                  child: Image.asset(Images.placeHolder),
                                ),
                        ),
                      )
                      .toList(),
                ),
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: homeController.sliderList.map((banner) {
                      int index = homeController.sliderList.indexOf(banner);
                      return Row(
                        children: [
                          Container(
                            height: 3,
                            width:
                                homeController.currentIndex == index ? 20 : 10,
                            decoration: BoxDecoration(
                              color: homeController.currentIndex == index
                                  ? kWhiteColor
                                  : kWhiteColor.withOpacity(.5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 3.5,
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
    );
  }
}
