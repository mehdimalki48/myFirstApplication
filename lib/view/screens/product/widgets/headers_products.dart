import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/favorite_controller.dart';
import 'package:woogoods/models/response/product_list.dart' as model;
import '../image_details_screen.dart';

class ProductHeaders extends StatefulWidget {
  static const routeName = 'test_state_less_widget';
  final model.ProductList? product;
  const ProductHeaders({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductHeaders> createState() => _TestStateLessWidgetState();
}

class _TestStateLessWidgetState extends State<ProductHeaders> {
  final FavoriteController favoriteController = Get.find();
  int productIndex = 0;

  @override
  void initState() {
    super.initState();
  /*  WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(milliseconds: 100), () {
        favoriteController.getFavoriteList();
      });

    });
*/
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 48,
        ),
        Stack(
          fit: StackFit.loose,
          children: [
            InkWell(
              onTap: () {
                if (widget.product?.images != null) {
                  Get.to(
                    () => ImageDetailsScreen(
                      images: widget.product?.images!,
                    ),
                  );
                }
              },
              child: widget.product?.images == null
                  ? AspectRatio(
                      aspectRatio: 1.3,
                      child: Container(
                        color: kOrdinaryColor,
                        child: Image.asset(
                          Images.placeHolder,
                        ),
                      ),
                    )
                  : CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.3,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        reverse: false,
                        autoPlay: false,
                        autoPlayInterval: const Duration(seconds: 5),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 1000),
                        autoPlayCurve: Curves.easeInCubic,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        onPageChanged: (int index, reason) {
                          setState(() {
                            productIndex = index;
                          });
                        },
                      ),
                      items: widget.product?.images
                          ?.map(
                            (item) => SizedBox(
                              width: double.infinity,
                              child: isImageShow
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl: item.src!,
                                        placeholder: (context, url) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            color: kOrdinaryColor2,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          //height: getProportionateScreenWidth(95),
                                          //  width: getProportionateScreenWidth(95),
                                          child:
                                              Image.asset(Images.placeHolder),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              decoration: BoxDecoration(
                                                color: kOrdinaryColor2,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              child: Image.asset(kImageDir + 'placeholder.png'),
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
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: (widget.product?.images?.length ?? 0) > 1 ? Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 5,
                ),
                decoration: BoxDecoration(
                  color: kLoginBg,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    kOrdinaryShadow,
                  ],
                ),
                child: Text(
                  '${productIndex + 1}/${widget.product?.images?.length}',
                  style: kDescriptionText.copyWith(
                    color: kStUnderLineColor,
                  ),
                ),
              ) : const SizedBox(),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: GetBuilder<FavoriteController>(builder: (favoriteController){
                return Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFC4C4C4),
                    shape: BoxShape.circle,
                  ),
                  child: LikeButton(
                    onTap: (isLiked) async {
                      if (isLiked) {
                        favoriteController.addToFavorite(widget.product!);
                        log('disliked');
                        return false;
                      } else {
                        favoriteController.addToFavorite(widget.product!);
                        log('liked');
                        return true;
                      }
                    },
                    isLiked: favoriteController
                        .isAlreadyAdd(widget.product!.id!),
                    likeCountPadding: EdgeInsets.zero,
                    padding: const EdgeInsets.all(5),
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? kPrimaryColor : kBlackColor2,
                      );
                    },
                  ),
                );
              },),
            )
          ],
        ),
      ],
    );
  }
}
