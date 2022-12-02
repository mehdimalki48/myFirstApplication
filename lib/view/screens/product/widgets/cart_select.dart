import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/cart_controller.dart';
import 'package:woogoods/controllers/product_details_controller.dart';
import 'package:woogoods/services/localization_services.dart';
import 'package:woogoods/view/widgets/default_btn.dart';
import '../../../../models/response/product_list.dart';
import '../../../../util/others_methods.dart';
import '../../checkout/checkout_home_screen.dart';

class CartSelect {
  //get current localization
  String? currentLng = LocalizationService().getCurrentLang();

  void cartView(
      {required BuildContext context,
      bool isCartBuy = false,
      bool isCart = false,
      required ProductList productDetailsController}) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: GetBuilder<CartController>(
          builder: (cartController) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: getProportionateScreenWidth(70),
                        height: getProportionateScreenWidth(70),
                        child: productDetailsController.images![0].src != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      productDetailsController.images![0].src ??
                                          '',
                                  placeholder: (context, url) => Container(
                                    decoration: BoxDecoration(
                                      color: kOrdinaryColor2,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Image.asset(Images.placeHolder),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      color: kOrdinaryColor2,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Image.asset(
                                        kImageDir + 'placeholder.png'),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: kOrdinaryColor2,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Image.asset(Images.placeHolder),
                              ),
                      ),
                      kWidthBox15,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                kCurrency +
                                    (productDetailsController.price ?? ''),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          getProportionateScreenWidth(18.0),
                                    ),
                              ),
                              if (productDetailsController.regularPrice != "" &&
                                  double.parse(productDetailsController
                                              .regularPrice ??
                                          '0') >
                                      double.parse(
                                          productDetailsController.price ??
                                              '0'))
                                Row(
                                  children: [
                                    kWidthBox10,
                                    Text(
                                      kCurrency +
                                          (productDetailsController
                                                  .regularPrice ??
                                              ''),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2
                                          ?.copyWith(
                                            color: kStUnderLineColor,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'In Stock'.tr,
                                style: kRegularText2.copyWith(
                                    color: kSecondaryColor),
                              ),
                              kWidthBox15,
                              SizedBox(
                                child: productDetailsController.regularPrice !=
                                            "" &&
                                        double.parse(productDetailsController
                                                    .regularPrice ??
                                                '0') >
                                            double.parse(
                                                productDetailsController
                                                        .price ??
                                                    '0')
                                    ? Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          border: Border.all(
                                            width: 1,
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                        child: Text(
                                          '${((double.parse(productDetailsController.regularPrice ?? '0') - double.parse(productDetailsController.price ?? '0')) / double.parse(productDetailsController.regularPrice ?? '0') * 100).toInt()}% OFF',
                                          style: kSmallText.copyWith(
                                            color: kPrimaryColor,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                          kHeightBox5,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selected'.tr +
                                    '${cartController.brandSelected}, ${cartController.colorSelected == '' ? '' : '${cartController.colorSelected}, '}${cartController.sizeSelected}',
                                style: kRegularText2.copyWith(
                                  color: const Color(0xFF808080),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  kHeightBox15,
                  const Divider(
                    thickness: .3,
                    height: .3,
                    color: Color(0xFF808080),
                  ),
                  kHeightBox5,
                  SizedBox(
                    child: productDetailsController.attributes == []
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListView.builder(
                                itemCount:
                                    productDetailsController.attributes?.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, int index) {
                                  return SizedBox(
                                    child: productDetailsController
                                                .attributes![index]
                                                .options!
                                                .isEmpty ||
                                            (productDetailsController
                                                        .attributes?[index]
                                                        .name ??
                                                    '') ==
                                                'brands'
                                        ? const SizedBox()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (productDetailsController
                                                                .attributes?[
                                                                    index]
                                                                .name ??
                                                            '') ==
                                                        'color'
                                                    ? 'Color'
                                                    : (productDetailsController
                                                                    .attributes?[
                                                                        index]
                                                                    .name ??
                                                                '') ==
                                                            'size'
                                                        ? 'Size'
                                                        : productDetailsController
                                                                .attributes?[
                                                                    index]
                                                                .name ??
                                                            '',
                                                style: kRegularText2.copyWith(
                                                  color: Get.isDarkMode
                                                      ? kWhiteColor
                                                      : kStUnderLineColor,
                                                ),
                                              ),
                                              kHeightBox5,
                                              Wrap(
                                                children: [
                                                  for (int i = 0;
                                                      i <
                                                          productDetailsController
                                                              .attributes![
                                                                  index]
                                                              .options!
                                                              .length;
                                                      i++)
                                                    InkWell(
                                                      onTap: () {
                                                        if ((productDetailsController
                                                                    .attributes![
                                                                        index]
                                                                    .name ??
                                                                '') ==
                                                            'color') {
                                                          cartController
                                                              .updateCartColor(
                                                            productDetailsController
                                                                    .attributes![
                                                                        index]
                                                                    .options?[i] ??
                                                                '',
                                                          );
                                                        }
                                                        if ((productDetailsController
                                                                    .attributes![
                                                                        index]
                                                                    .name ??
                                                                '') ==
                                                            'size') {
                                                          cartController
                                                              .updateCartSize(
                                                            productDetailsController
                                                                    .attributes![
                                                                        index]
                                                                    .options?[i] ??
                                                                '',
                                                          );
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        margin: const EdgeInsets
                                                            .only(
                                                          right: 10,
                                                          bottom: 10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            width: 1,
                                                            color: getSelectedColor(
                                                                productDetailsController,
                                                                index,
                                                                i,
                                                                cartController),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child: Text(
                                                          productDetailsController
                                                                  .attributes![
                                                                      index]
                                                                  .options?[i] ??
                                                              '',
                                                          style: kRegularText2
                                                              .copyWith(
                                                            color: getSelectedColor(
                                                                productDetailsController,
                                                                index,
                                                                i,
                                                                cartController),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              if (!(productDetailsController
                                                      .attributes!.length ==
                                                  index + 1))
                                                kHeightBox10,
                                            ],
                                          ),
                                  );
                                },
                              ),
                              kHeightBox10,
                              const Divider(
                                thickness: .3,
                                height: .3,
                                color: Color(0xFF808080),
                              ),
                            ],
                          ),
                  ),
                  kHeightBox10,
                  Text(
                    'Quantity'.tr,
                    style: kRegularText2.copyWith(
                      color: Get.isDarkMode ? kWhiteColor : kStUnderLineColor2,
                    ),
                  ),
                  kHeightBox10,
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          if (cartController.cartQuantity > 1) {
                            cartController.updateCartQuantity(
                                isIncrement: false);
                          } else {
                            log('don\' decrement');
                          }
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF000000).withOpacity(.10),
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              '-',
                              textAlign: TextAlign.center,
                              style: kSmallText.copyWith(
                                color:
                                    Get.isDarkMode ? kWhiteColor : kBlackColor2,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w300,
                                height: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      kWidthBox15,
                      Text(
                        '${cartController.cartQuantity}',
                        maxLines: 1,
                        style: kRegularText.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                        ),
                      ),
                      kWidthBox15,
                      InkWell(
                        onTap: () {
                          if (productDetailsController.manageStock ?? false) {
                            int cartQuantity = cartController.cartItemQuantity(
                                productDetailsController.id ?? 0);
                            log('$cartQuantity');
                            if (cartQuantity > 0) {
                              if ((cartController.cartQuantity + cartQuantity) <
                                  (productDetailsController.stockQuantity ??
                                      0)) {
                                cartController.updateCartQuantity();
                              } else {
                                showCustomSnackBar(
                                  'No more stock!'.tr,
                                );
                              }
                            } else {
                              if (cartController.cartQuantity <
                                  (productDetailsController.stockQuantity ??
                                      0)) {
                                cartController.updateCartQuantity();
                              } else {
                                showCustomSnackBar(
                                  'No more stock!'.tr,
                                );
                              }
                            }
                          } else {
                            showCustomSnackBar('This product out of stock!');
                          }
                        },
                        child: Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Theme.of(context).backgroundColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(3)),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF000000).withOpacity(.10),
                                  blurRadius: 4,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '+',
                                textAlign: TextAlign.center,
                                style: kSmallText.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w300,
                                  height: 1.0,
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  kHeightBox20,
                  /*Container(
                    color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.all(10),
                    child: GetBuilder<ProductDetailsController>(
                      builder: (checkoutController) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Shipping'.tr,
                                        style: kRegularText.copyWith(
                                          color: Get.isDarkMode
                                              ? kWhiteColor
                                              : const Color(0xFF303030),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' $kCurrency${checkoutController.shippingFee}',
                                        style: kRegularText2.copyWith(
                                          color: Get.isDarkMode
                                              ? kWhiteColor
                                              : const Color(0xFF303030),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            kHeightBox10,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Images.shippingBox,
                                  width: 15,
                                  height: 15,
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor,
                                ),
                                kWidthBox10,
                                Flexible(
                                  child: Text(
                                    'Cash on Delivery',
                                    style: kRegularText2.copyWith(
                                      color: Get.isDarkMode
                                          ? kWhiteColor
                                          : const Color(0xFF303030),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            kHeightBox10,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Images.thunder,
                                  width: 15,
                                  height: 15,
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor,
                                ),
                                kWidthBox10,
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Ships in'.tr,
                                        style: kRegularText2.copyWith(
                                          color: Get.isDarkMode
                                              ? kWhiteColor
                                              : const Color(0xFF303030),
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' 3 - 7 days',
                                        style: kRegularText2.copyWith(
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            kHeightBox10,
                            const Divider(
                              thickness: .3,
                              height: .3,
                              color: Color(0xFF808080),
                            ),
                            kHeightBox10,
                          ],
                        );
                      },
                    ),
                  ),
                  */
                  kHeightBox30,
                  Container(
                    child: isCartBuy
                        ? Container(
                            alignment: Alignment.center,
                            color: Theme.of(context).cardColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (cartController.authRepo.isLoggedIn()) {
                                      if (productDetailsController
                                              .manageStock ??
                                          false) {
                                        Get.to(
                                          () => CheckoutScreen(
                                            cartData:
                                                OthersMethod().setBuyNowData(
                                              productDetailsController,
                                              quantity:
                                                  cartController.cartQuantity,
                                              price: OthersMethod
                                                  .productPriceCalculate(
                                                      productDetailsController),
                                              brand:
                                                  cartController.brandSelected,
                                              variations: OthersMethod
                                                  .setVariationDataInCart(
                                                      cartController),
                                            ),
                                            totalPrice: OthersMethod
                                                    .productPriceCalculate(
                                                        productDetailsController) *
                                                cartController.cartQuantity,
                                            totalQuantity:
                                                cartController.cartQuantity,
                                          ),
                                        );
                                      } else {
                                        showCustomSnackBar(
                                            'This product out of stock!');
                                      }
                                    } else {
                                      showCustomSnackBar('Please login first!');
                                    }
                                  },
                                  child: Container(
                                    width: SizeConfig.screenWidth! / 2.2,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kSecondaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            currentLng == 'Arabic' ? 0 : 30),
                                        bottomLeft: Radius.circular(
                                            currentLng == 'Arabic' ? 0 : 30),
                                        bottomRight: Radius.circular(
                                            currentLng == 'Arabic' ? 30 : 0),
                                        topRight: Radius.circular(
                                            currentLng == 'Arabic' ? 30 : 0),
                                      ),
                                    ),
                                    child: Text(
                                      'Buy Now'.tr,
                                      style: kAppBarText.copyWith(
                                        color: kWhiteColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (productDetailsController.manageStock ??
                                        false) {
                                      int cartQuantity =
                                          cartController.cartItemQuantity(
                                              productDetailsController.id ?? 0);
                                      log('$cartQuantity');
                                      if ((cartController.cartQuantity +
                                              cartQuantity) <
                                          (productDetailsController
                                                  .stockQuantity ??
                                              0)) {
                                        /* double price = (productDetailsController.price!.isNotEmpty
                                            ? double.parse(
                                                productDetailsController
                                                    .price!)
                                            : double.parse(productDetailsController.regularPrice == "" ? "0.0" : productDetailsController.regularPrice!));*/

                                        Get.find<CartController>().addToCart(
                                          productDetailsController,
                                          price: OthersMethod
                                              .productPriceCalculate(
                                                  productDetailsController),
                                          quantity: cartController.cartQuantity,
                                          brand: cartController.brandSelected,
                                          variations: OthersMethod
                                              .setVariationDataInCart(
                                                  cartController),
                                        );
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
                                  child: Container(
                                    width: SizeConfig.screenWidth! / 2.2,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(
                                            currentLng == 'Arabic' ? 0 : 30),
                                        bottomRight: Radius.circular(
                                            currentLng == 'Arabic' ? 0 : 30),
                                        topLeft: Radius.circular(
                                            currentLng == 'Arabic' ? 30 : 0),
                                        bottomLeft: Radius.circular(
                                            currentLng == 'Arabic' ? 30 : 0),
                                      ),
                                    ),
                                    child: Text(
                                      'Add to Cart'.tr,
                                      style: kAppBarText.copyWith(
                                        color: kWhiteColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: DefaultBtn(
                              title: isCart ? 'Add to Cart'.tr : 'Buy Now'.tr,
                              textColor: kWhiteColor,
                              borderColor: kPrimaryColor,
                              border: 1,
                              btnColor: kSecondaryColor,
                              btnColor2: kPrimaryColor,
                              radius: 10,
                              onPress: () {
                                if (isCart) {
                                  if (productDetailsController.manageStock ??
                                      false) {
                                    int cartQuantity =
                                        cartController.cartItemQuantity(
                                            productDetailsController.id ?? 0);
                                    log('$cartQuantity');
                                    if ((cartController.cartQuantity +
                                            cartQuantity) <
                                        (productDetailsController
                                                .stockQuantity ??
                                            0)) {
                                      Get.find<CartController>().addToCart(
                                        productDetailsController,
                                        price:
                                            OthersMethod.productPriceCalculate(
                                                productDetailsController),
                                        quantity: cartController.cartQuantity,
                                        brand: cartController.brandSelected,
                                        variations:
                                            OthersMethod.setVariationDataInCart(
                                                cartController),
                                      );
                                    } else {
                                      showCustomSnackBar(
                                        'No more stock!'.tr,
                                      );
                                    }
                                  } else {
                                    showCustomSnackBar(
                                        'This product out of stock!');
                                  }
                                } else {
                                  if (cartController.authRepo.isLoggedIn()) {
                                    if (productDetailsController.manageStock ??
                                        false) {
                                      Get.to(
                                        () => CheckoutScreen(
                                          cartData:
                                              OthersMethod().setBuyNowData(
                                            productDetailsController,
                                            quantity:
                                                cartController.cartQuantity,
                                            price: OthersMethod
                                                .productPriceCalculate(
                                                    productDetailsController),
                                            brand: cartController.brandSelected,
                                            variations: OthersMethod
                                                .setVariationDataInCart(
                                                    cartController),
                                          ),
                                          totalPrice: OthersMethod
                                                  .productPriceCalculate(
                                                      productDetailsController) *
                                              cartController.cartQuantity,
                                          totalQuantity:
                                              cartController.cartQuantity,
                                        ),
                                      );
                                    } else {
                                      showCustomSnackBar(
                                          'This product out of stock!');
                                    }
                                  } else {
                                    showCustomSnackBar('Please login first!');
                                  }
                                }
                              },
                            ),
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );
  }

  Color getSelectedColor(ProductList productDetailsController, int index, int i,
      CartController cartController) {
    Color color = kPrimaryColor;
    color = (productDetailsController.attributes![index].name ?? '') == 'color'
        ? cartController.colorSelected == ''
            ? i == 0
                ? kPrimaryColor
                : (Get.isDarkMode ? kWhiteColor : kStUnderLineColor2)
            : cartController.colorSelected ==
                    (productDetailsController.attributes![index].options?[i] ??
                        '')
                ? kPrimaryColor
                : (Get.isDarkMode ? kWhiteColor : kStUnderLineColor2)
        : (productDetailsController.attributes![index].name ?? '') == 'size'
            ? cartController.sizeSelected == ''
                ? i == 0
                    ? kPrimaryColor
                    : (Get.isDarkMode ? kWhiteColor : kStUnderLineColor2)
                : cartController.sizeSelected ==
                        (productDetailsController
                                .attributes![index].options?[i] ??
                            '')
                    ? kPrimaryColor
                    : (Get.isDarkMode ? kWhiteColor : kStUnderLineColor2)
            : i == 0
                ? kPrimaryColor
                : (Get.isDarkMode ? kWhiteColor : kStUnderLineColor2);
    return color;
  }

  String variationsBrandsSelected(ProductList productDetailsController) {
    String variation = '';
    for (int i = 0; i < productDetailsController.attributes!.length; i++) {
      if ((productDetailsController.attributes?[i].name ?? '') == 'brands') {
        variation = productDetailsController.attributes?[i].options![0] ?? '';
      }
    }
    log('var$variation');
    return variation;
  }
}
