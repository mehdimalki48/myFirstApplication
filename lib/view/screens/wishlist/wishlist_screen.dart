import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/favorite_controller.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/util/others_methods.dart';
import 'package:woogoods/view/widgets/app_bar_actions.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/default_btn.dart';
import 'package:woogoods/view/widgets/icon_btn.dart';

import '../../../controllers/cart_controller.dart';

class WishListScreen extends StatefulWidget {
  static const routeName = 'wishlist_screen';

  const WishListScreen({Key? key}) : super(key: key);

  @override
  YourPageState createState() => YourPageState();
}

class YourPageState extends State<WishListScreen> {
  final FavoriteController favoriteController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        Future.delayed(const Duration(milliseconds: 100), () {
          favoriteController.onInit();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wishlist'.tr,
        ),
        actions: [
          AppBarActions(
            isCart: true,
            isDelete: favoriteController.favoriteList.isEmpty ? false : true,
            onTapDelete: () {
              favoriteController.showDelete();
            },
          )
        ],
      ),
      body: Obx(
        () {
          if (favoriteController.isLoading.isTrue) {
            return const Center(
              child: CustomLoader(),
            );
          }
          if (favoriteController.favoriteList.isEmpty) {
            return const Center(
              child: Text('Wishlist Empty'),
            );
          } else {
            return Container(
              child: favoriteController.isDelete
                  ? Column(
                      children: [
                        Expanded(flex: 9, child: buildList()),
                        Expanded(
                          flex: 1,
                          child: Card(
                            color: Theme.of(context).cardColor,
                            margin: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      kWidthBox10,
                                      InkWell(
                                        onTap: () {
                                          var test = favoriteController.tempList
                                              .where(
                                                  (element) => element == true);
                                          if (test.length ==
                                              favoriteController
                                                  .favoriteList.length) {
                                            favoriteController.addToTemp(false);
                                          } else {
                                            favoriteController.addToTemp(true);
                                          }
                                        },
                                        child: favoriteController.tempList
                                                    .where((element) =>
                                                        element == true)
                                                    .length ==
                                                favoriteController
                                                    .favoriteList.length
                                            ? SvgPicture.asset(
                                                Images.circleCheck,
                                                width: 20,
                                                height: 20,
                                              )
                                            : SvgPicture.asset(
                                                Images.circleOutline,
                                                width: 20,
                                                height: 20,
                                              ),
                                      ),
                                      kWidthBox10,
                                      Text(
                                        'All'.tr,
                                        style: kRegularText2.copyWith(
                                          color: Get.isDarkMode
                                              ? kWhiteColor
                                              : kBlackColor2,
                                        ),
                                      ),
                                    ],
                                  ),
                                  DefaultBtn(
                                    radius: 5.0,
                                    title: 'Delete'.tr,
                                    onPress: () {
                                      if (favoriteController.tempList
                                          .where((element) => element == true)
                                          .isNotEmpty) {
                                        for (int i = 0;
                                            i <
                                                favoriteController
                                                    .tempList.length;
                                            i++) {
                                          if (favoriteController.tempList[i] ==
                                              true) {
                                            favoriteController
                                                .removeFromTemp(i);
                                            favoriteController
                                                .removeFromFavorite(
                                                    favoriteController
                                                        .favoriteList[i].id!);
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  : buildList(),
            );
          }
        },
      ),
    );
  }

  buildList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: favoriteController.favoriteList.length,
        padding: EdgeInsets.zero,
        physics: const ScrollPhysics(),
        itemBuilder: (context, int index) {
          var productFab =
              jsonDecode(favoriteController.favoriteList[index].product!);
          ProductList productList = ProductList.fromJson(productFab);
          return buildCard(index, productList);
        },
      ),
    );
  }

  Widget buildCard(int index, ProductList productFab) {
    return Column(
      children: [
        Card(
          color: Theme.of(context).cardColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: favoriteController.isDelete
                      ? InkWell(
                          onTap: () {
                            favoriteController.removeFromTemp(index);
                          },
                          child: SizedBox(
                            width: 30,
                            child: Row(
                              children: [
                                kWidthBox10,
                                favoriteController.tempList[index]
                                    ? SvgPicture.asset(
                                        Images.circleCheck,
                                        width: 20,
                                        height: 20,
                                      )
                                    : SvgPicture.asset(
                                        Images.circleOutline,
                                        width: 20,
                                        height: 20,
                                        color: Get.isDarkMode
                                            ? kWhiteColor
                                            : kBlackColor2,
                                      ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
                kWidthBox10,
                SizedBox(
                  width: getProportionateScreenWidth(70),
                  height: getProportionateScreenWidth(70),
                  child: InkWell(
                    /*  onTap: () => Get.to(
                          () => ProductDetailsScreen(
                        id: productFab.id ?? 0,
                        productDetails: productFab,
                      ),
                    ),*/
                    child: productFab.images!.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: CachedNetworkImage(
                              imageUrl: productFab.images![0].src!,
                              placeholder: (context, url) => Container(
                                decoration: BoxDecoration(
                                  color: kOrdinaryColor2,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.asset(Images.placeHolder),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                              width: getProportionateScreenWidth(70),
                              height: getProportionateScreenWidth(70),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: kOrdinaryColor2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            width: getProportionateScreenWidth(70),
                            height: getProportionateScreenWidth(70),
                            child: Image.asset(Images.placeHolder),
                          ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productFab.name ?? '',
                          maxLines: 1,
                          style: kRegularText2.copyWith(
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          ),
                        ),
                        kHeightBox10,
                        Text(
                          OthersMethod.productPriceCalculate(productFab)
                              .toString(),
                          style: kRegularText.copyWith(
                            color:
                                Get.isDarkMode ? kPrimaryColor : kBlackColor2,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        kHeightBox5,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    kSecondaryColor,
                                    kPrimaryColor,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              height: 16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    Images.flashDeal,
                                    color: kWhiteColor,
                                  ),
                                  kWidthBox5,
                                  Text(
                                    'Flash Deals',
                                    style: kSmallText.copyWith(
                                      color: kWhiteColor,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GetBuilder<CartController>(
                                builder: (cartController) {
                              return IconButtons(
                                padding: 10,
                                height: 22,
                                onPress: () async {
                                  if (productFab.manageStock ?? false) {
                                    int cartQuantity = cartController
                                        .cartItemQuantity(productFab.id ?? 0);
                                    log('$cartQuantity');
                                    if (cartQuantity <
                                        (productFab.stockQuantity ?? 0)) {
                                      if (OthersMethod.variationsIsEmptyCheck(
                                          productFab)) {
                                        //added variation + cart
                                        await OthersMethod.variationsSelected(
                                            productFab);
                                        cartController.addToCart(
                                          productFab,
                                          price: OthersMethod
                                              .productPriceCalculate(
                                                  productFab),
                                          quantity: 1,
                                          brand: OthersMethod.selectedBrands(
                                              productFab),
                                          variations: OthersMethod
                                              .setVariationDataInCart(
                                                  cartController),
                                        );
                                      } else {
                                        cartController.addToCart(
                                          productFab,
                                          price: OthersMethod
                                              .productPriceCalculate(
                                                  productFab),
                                          quantity: 1,
                                          brand: OthersMethod.selectedBrands(
                                              productFab),
                                        );
                                      }
                                    } else {
                                      showCustomSnackBar(
                                        'No more stock!'.tr,
                                      );
                                    }
                                  } else {
                                    showCustomSnackBar(
                                        'This product out of stock!');
                                  }
                                },
                                imageURL: Images.cart,
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        kHeightBox10,
      ],
    );
  }
}
