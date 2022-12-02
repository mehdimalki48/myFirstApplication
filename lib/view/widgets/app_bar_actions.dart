import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/view/screens/cart/cart_screen.dart';
import 'package:woogoods/view/screens/dashboard/dashboard_screen.dart';
import 'package:woogoods/view/screens/search/search_home_screen.dart';
import 'package:woogoods/view/screens/wishlist/wishlist_screen.dart';

import '../../controllers/cart_controller.dart';

class AppBarActions extends StatelessWidget {
  final bool isWishlist;
  final bool isMoreVert;
  final bool isSearch;
  final bool isCart;
  final bool isDelete;
  final Function? onTapSearch;
  final Function? onTapDelete;
  final Function? onTapWishlist;
  final Function? onTapCart;
  final Function? onTapMoreVert;
  final double height;

  const AppBarActions({
    Key? key,
    this.isWishlist = false,
    this.isMoreVert = false,
    this.isCart = false,
    this.isSearch = false,
    this.isDelete = false,
    this.height = 20,
    this.onTapSearch,
    this.onTapDelete,
    this.onTapWishlist,
    this.onTapCart,
    this.onTapMoreVert,
  }) : super(key: key);

  Future<void> _loadData(bool reload) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.find<CartController>().hideDelete();
      Get.find<CartController>().getAllCartList(isTamUp: true);
    },);
  }

  @override
  Widget build(BuildContext context) {
    _loadData(false);
    return Row(
      children: [
        if (isSearch)
          SizedBox(
            width: 35,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                Images.search,
                color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                height: height,
              ),
              onPressed: onTapSearch != null
                  ? onTapSearch as void Function()?
                  : () => Get.to(
                        () => const SearchHomeScreen(),
                      ),
            ),
          ),
        if (isDelete)
          SizedBox(
            width: 35,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                Images.delete,
                color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                height: height,
              ),
              onPressed: onTapDelete as void Function()?,
            ),
          ),
        if (isCart)
          SizedBox(
            width: 35,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  SvgPicture.asset(
                    Images.cart,
                    color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                    height: height,
                  ),
                  Positioned(
                    top: -10,
                    right: -5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: GetBuilder<CartController>(
                          builder: (cartController) {
                            return Center(
                              child: Text(
                                '${cartController.totalQuantity}',
                                style: kDescriptionText.copyWith(
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w600,
                                  height: 1.0,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: onTapCart != null
                  ? onTapCart as void Function()?
                  : () => Get.to(
                        () => const CartListScreen(
                        ),
                      ),
            ),
          ),
        if (isWishlist)
          SizedBox(
            width: 35,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                Images.wishList2,
                color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                height: height,
              ),
              onPressed: onTapWishlist != null
                  ? onTapWishlist as void Function()?
                  : () => Get.to(
                        () => const WishListScreen(),
                      ),
            ),
          ),
        if (isMoreVert)
          SizedBox(
            width: 35,
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: SvgPicture.asset(
                Images.moreVert,
                color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                height: height,
              ),
              onPressed: onTapMoreVert != null
                  ? onTapMoreVert as void Function()?
                  : () => Get.offAll(
                        () => const DashBoardScreen(
                          index: 0,
                        ),
                      ),
            ),
          ),
      ],
    );
  }
}
