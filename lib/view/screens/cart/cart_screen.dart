import 'dart:convert';
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
import 'package:woogoods/models/response/cart_model.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/util/others_methods.dart';
import 'package:woogoods/view/screens/checkout/checkout_home_screen.dart';
import 'package:woogoods/view/screens/product/product_details.dart';
import 'package:woogoods/view/widgets/app_bar_actions.dart';
import 'package:woogoods/view/widgets/custom_alert_dialog.dart';
import 'package:woogoods/view/widgets/default_btn.dart';

import '../../../models/body/line_items.dart';

class CartListScreen extends StatefulWidget {
  static const routeName = 'cartList_screen';

  const CartListScreen({
    Key? key,
  }) : super(key: key);

  @override
  YourPageState createState() => YourPageState();
}

class YourPageState extends State<CartListScreen> {
  bool isDelete = false;
  List<bool> list = List.filled(10, true);
  int cartCount = 2;

  Future<void> _loadData(bool reload) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.find<CartController>().hideDelete();
      Get.find<CartController>().getAllCartList(isTamUp: true);
      //Get.find<CartController>().updateTampList();
    });
  }

  @override
  Widget build(BuildContext context) {
    _loadData(false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shopping'.tr,
        ),
        actions: [
          AppBarActions(
            isDelete: true,
            isWishlist: true,
            onTapDelete: () {
              Get.find<CartController>().showDelete();
            },
          ),
        ],
      ),
      body: GetBuilder<CartController>(
        builder: (cartController) {
          return Container(
            child: cartController.cartList.isEmpty
                ? const Center(
                    child: Text('Cart is empty!'),
                  )
                : cartController.isDelete
                    ? Column(
                        children: [
                          Expanded(flex: 9, child: buildList(cartController)),
                          Expanded(
                            flex: 1,
                            child: Card(
                              color: Theme.of(context).cardColor,
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                                            var test = cartController.tempList
                                                .where((element) =>
                                                    element == true);
                                            if (test.length ==
                                                cartController
                                                    .cartList.length) {
                                              cartController.addToTemp(false);
                                            } else {
                                              cartController.addToTemp(true);
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            cartController.isAll
                                                ? Images.circleCheck
                                                : Images.circleOutline,
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
                                        if (cartController.tempList
                                            .where((element) => element == true)
                                            .isNotEmpty) {
                                          CustomAlertDialog().customAlert2(
                                            context: context,
                                            title: 'Delete Form Cart'.tr,
                                            body:
                                                'Are you sure want to delete item'
                                                    .tr,
                                            color: kPrimaryColor,
                                            confirmTitle: 'Delete',
                                            onPress: () {
                                              if (cartController.isAll) {
                                                cartController.emptyCart();
                                                log('all');
                                              } else {
                                                for (int i = 0;
                                                    i <
                                                        cartController
                                                            .tempList.length;
                                                    i++) {
                                                  if (cartController
                                                          .tempList[i] ==
                                                      true) {
                                                    cartController
                                                        .removeFromTemp(i);
                                                    cartController
                                                        .removeFromCart(
                                                            cartController
                                                                .cartList[i]
                                                                .id!);
                                                  }
                                                }
                                              }

                                              Navigator.pop(context);
                                            },
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please item select first!'.tr);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(flex: 9, child: buildList(cartController)),
                          Expanded(
                            flex: 1,
                            child: Card(
                              color: Theme.of(context).cardColor,
                              margin: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          kWidthBox10,
                                          InkWell(
                                            onTap: () {
                                              var test = cartController.tempList
                                                  .where((element) =>
                                                      element == true);
                                              if (test.length ==
                                                  cartController
                                                      .cartList.length) {
                                                cartController.addToTemp(false);
                                              } else {
                                                cartController.addToTemp(true);
                                              }
                                            },
                                            child: SvgPicture.asset(
                                              cartController.isAll
                                                  ? Images.circleCheck
                                                  : Images.circleOutline,
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
                                    ),
                                    Text(
                                      kCurrency +
                                          '${cartController.totalPrice}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1!
                                          .copyWith(
                                            fontWeight: FontWeight.w700,
                                            height: 1.0,
                                            fontSize: 16,
                                          ),
                                    ),
                                    kWidthBox10,
                                    DefaultBtn(
                                      radius: 5.0,
                                      title: 'Check Out'.tr +
                                          '(${cartController.cartList.length})',
                                      onPress: () {
                                        //cartController.authRepo.isLoggedIn()
                                        if (true) {
                                          if (cartController.tempList
                                              .where(
                                                  (element) => element == true)
                                              .isNotEmpty) {
                                            if (cartController.isAll) {
                                              Get.to(
                                                () => CheckoutScreen(
                                                  cartData:
                                                      cartController.cartList,
                                                  totalPrice:
                                                      cartController.totalPrice,
                                                  totalQuantity: cartController
                                                      .totalQuantity,
                                                ),
                                              );
                                            } else {
                                              List<CartModel> data = [];
                                              for (int i = 0;
                                                  i <
                                                      cartController
                                                          .tempList.length;
                                                  i++) {
                                                if (cartController
                                                        .tempList[i] ==
                                                    true) {
                                                  data.add(cartController
                                                      .cartList[i]);
                                                }
                                              }
                                              Get.to(
                                                () => CheckoutScreen(
                                                  cartData: data,
                                                  totalPrice:
                                                      cartController.totalPrice,
                                                  totalQuantity: cartController
                                                      .totalQuantity,
                                                ),
                                              );
                                            }
                                          } else {
                                            showCustomSnackBar(
                                                'Please item select first!'.tr);
                                          }
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first!');
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
          );
        },
      ),
    );
  }

  buildList(CartController cartController) {
    return Container(
      child: cartController.cartList.isEmpty
          ? const Center(
              child: Text('Cart is empty!'),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    kHeightBox10,
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: cartController.cartList.length,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, int index) {
                        return buildListCard(
                          index,
                          cartController.cartList[index],
                          cartController,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  buildListCard(int index, CartModel data, CartController cartController) {
    var productFab = jsonDecode(data.product!);
    ProductList product = ProductList.fromJson(productFab);
    log(data.variations ?? '');
    List<MetaCartData> variations =
        OthersMethod.getCartVariationList(variations: data.variations);

    return Column(
      children: [
        Card(
          color: Theme.of(context).cardColor,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            children: [
              kHeightBox10,
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          cartController.removeFromTemp(index);
                        },
                        child: SizedBox(
                          width: 30,
                          child: Row(
                            children: [
                              kWidthBox10,
                              Container(
                                child: cartController.tempList.length ==
                                        cartController.cartList.length
                                    ? cartController.tempList[index]
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
                                          )
                                    : const SizedBox(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      kWidthBox10,
                      Expanded(
                        child: InkWell(
                          onTap: () => Get.to(
                            () => ProductDetailsScreen(
                              id: product.id ?? 0,
                              productDetails: product,
                            ),
                          ),
                          child: data.image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: CachedNetworkImage(
                                    imageUrl: data.image ?? '',
                                    placeholder: (context, url) => Container(
                                      decoration: BoxDecoration(
                                        color: kOrdinaryColor2,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Image.asset(Images.placeHolder),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                    width: getProportionateScreenWidth(70),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: kOrdinaryColor2,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  width: getProportionateScreenWidth(70),
                                  height: getProportionateScreenWidth(78),
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
                              InkWell(
                                onTap: () => Get.to(
                                  () => const ProductDetailsScreen(
                                    id: 72,
                                  ),
                                ),
                                child: Text(
                                  data.title ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                              kHeightBox10,
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).backgroundColor,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF000000)
                                            .withOpacity(.10),
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.brand ?? ''}${variations.isEmpty ? '' : OthersMethod.variationsShow(variations)}',
                                    textAlign: TextAlign.center,
                                    style: kSmallText.copyWith(
                                      color: Get.isDarkMode
                                          ? kWhiteColor
                                          : kBlackColor2,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  )),
                              kHeightBox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    kCurrency + '${data.price ?? 0}',
                                    style: kRegularText.copyWith(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if ((data.quantity ?? 0) > 1) {
                                            int qty = (data.quantity ?? 0) - 1;
                                            Get.find<CartController>()
                                                .updateCart(product.id!, qty);
                                          } else {
                                            deleteCartItem(product, context);
                                          }
                                        },
                                        child: Container(
                                          width: 25,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xFF000000)
                                                    .withOpacity(.10),
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
                                                color: Get.isDarkMode
                                                    ? kWhiteColor
                                                    : kBlackColor2,
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
                                        '${data.quantity ?? 0}',
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                      kWidthBox15,
                                      InkWell(
                                        onTap: () {
                                          if ((data.quantity ?? 0) <
                                              (product.stockQuantity ?? 0)) {
                                            int qty = (data.quantity ?? 0) + 1;
                                            Get.find<CartController>()
                                                .updateCart(product.id!, qty);
                                          } else {
                                            showCustomSnackBar(
                                              'No more stock!'.tr,
                                            );
                                          }
                                        },
                                        child: Container(
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .backgroundColor,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(3)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF000000)
                                                      .withOpacity(.10),
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
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  kHeightBox15,
                ],
              ),
            ],
          ),
        ),
        kHeightBox10,
      ],
    );
  }

  Future deleteCartItem(ProductList product, BuildContext context) {
    return CustomAlertDialog().customAlert2(
      context: context,
      title: 'Delete',
      body: 'Are you sure want to delete?',
      color: kPrimaryColor,
      confirmTitle: 'Delete',
      onPress: () {
        Get.find<CartController>().removeFromCart(product.id ?? 0);
        Navigator.pop(context);
      },
    );
  }
}
