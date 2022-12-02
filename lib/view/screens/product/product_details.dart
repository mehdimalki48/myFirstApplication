import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/cart_controller.dart';
import 'package:woogoods/controllers/product_details_controller.dart';
import 'package:woogoods/controllers/recent_post_controller.dart';
import 'package:woogoods/controllers/review_controller.dart';
import 'package:woogoods/models/product_details_overview_data.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/services/localization_services.dart';
import 'package:woogoods/view/screens/cart/cart_screen.dart';
import '../../../util/others_methods.dart';
import '../checkout/checkout_home_screen.dart';
import 'widgets/cart_select.dart';
import 'widgets/fappbar.dart';
import 'widgets/tab_section.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int id;
  final ProductList? productDetails;

  const ProductDetailsScreen({Key? key, required this.id, this.productDetails})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => YourPageState();
}

class YourPageState extends State<ProductDetailsScreen>
    with SingleTickerProviderStateMixin {
  final ReviewController reviewController = Get.find();
  bool isCollapsed = false;
  late AutoScrollController scrollController;
  late TabController tabController;
  final double expandedHeight = 350.0;
  final PageData data = ExampleData.data;
  final double collapsedHeight = kToolbarHeight;

  // bool isLoading = true;
  final listViewKey = RectGetter.createGlobalKey();
  Map<int, dynamic> itemKeys = {};

  // prevent animate when press on tab bar
  bool pauseRectGetterIndex = false;
  bool overViewClick = false;

  @override
  void initState() {
    getReviewList();
    Get.find<RecentController>().addToRecent(widget.productDetails!);
    Get.find<ProductDetailsController>().fetchShippingZone();
    Get.find<ProductDetailsController>().addedSpecification(product: widget.productDetails!);
    tabController = TabController(length: data.categories.length, vsync: this);
    scrollController = AutoScrollController();
    super.initState();
  }

  void getReviewList() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await reviewController.fetchReviewList(id: widget.id.toString());
      },
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  List<int> getVisibleItemsIndex() {
    Rect? rect = RectGetter.getRectFromKey(listViewKey);
    List<int> items = [];
    if (rect == null) return items;
    itemKeys.forEach((index, key) {
      Rect? itemRect = RectGetter.getRectFromKey(key);
      if (itemRect == null) return;
      if (itemRect.top > rect.bottom) return;
      if (itemRect.bottom < rect.top) return;
      items.add(index);
    });
    return items;
  }

  void onCollapsed(bool value) {
    if (isCollapsed == value) return;
    setState(() => isCollapsed = value);
  }

  bool onScrollNotification(ScrollNotification notification) {
    if (pauseRectGetterIndex) return true;
    int lastTabIndex = tabController.length - 1;
    List<int> visibleItems = getVisibleItemsIndex();

    bool reachLastTabIndex = visibleItems.isNotEmpty &&
        visibleItems.length <= 2 &&
        visibleItems.last == lastTabIndex;
    if (reachLastTabIndex) {
      tabController.animateTo(lastTabIndex);
    } else {
      int sumIndex = visibleItems.reduce((value, element) => value + element);
      int middleIndex = sumIndex ~/ visibleItems.length;
      if (tabController.index != middleIndex) {
        tabController.animateTo(middleIndex);
      }
    }
    return false;
  }

  void animateAndScrollTo(int index) {
    pauseRectGetterIndex = true;
    tabController.animateTo(index);
    scrollController
        .scrollToIndex(index, preferPosition: AutoScrollPosition.begin)
        .then((value) => pauseRectGetterIndex = false);
  }

  int productIndex = 0;
  List products = [
    'https://familytrust.com.bd/uploads/product/shop/thumb_61120c98c14e9.jpg',
    'https://familytrust.com.bd/uploads/product/shop/thumb_61120d93cd7d6.jpg',
    'https://familytrust.com.bd/uploads/product/shop/thumb_61120ff834de9.jpg',
    'https://familytrust.com.bd/uploads/product/shop/thumb_6112112b41d08.jpg',
  ];

  //get current localization
  String? currentLng = LocalizationService().getCurrentLang();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: RectGetter(
              key: listViewKey,
              child: NotificationListener<ScrollNotification>(
                child: buildSliverScrollView(),
                onNotification: onScrollNotification,
              ),
            ),
          ),
          SizedBox(
              child: (widget.productDetails?.manageStock ?? false)
                  ? buildBottom(widget.productDetails!)
                  : const SizedBox())
        ],
      ),
    );
  }

  Widget buildSliverScrollView() {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        buildAppBar(),
        buildBody(),
      ],
    );
  }

  SliverAppBar buildAppBar() {
    return FAppBar(
      data: data,
      productDetails: widget.productDetails!,
      context: context,
      scrollController: scrollController,
      expandedHeight2: expandedHeight,
      collapsedHeight2: collapsedHeight,
      isCollapsed: isCollapsed,
      onCollapsed: onCollapsed,
      tabController: tabController,
      onTap: (index) => animateAndScrollTo(index),
    );
  }

  SliverList buildBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(
          data.categories.length,
          (index) {
            itemKeys[index] = RectGetter.createGlobalKey();
            return buildCategoryItem(index);
          },
        ),
      ),
    );
  }

  Widget buildCategoryItem(int index) {
    Category category = data.categories[index];
    return RectGetter(
      key: itemKeys[index],
      child: AutoScrollTag(
        key: ValueKey(index),
        index: index,
        controller: scrollController,
        child: CategorySection(
          category: category,
          indexList: index,
          productList: widget.productDetails!,
        ),
      ),
    );
  }

  buildBottom(ProductList productDetailsController) {
    return Container(
      color: Theme.of(context).cardColor,
      height: 65,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Get.to(
                () => const CartListScreen(),
              );
            },
            child: SvgPicture.asset(
              Images.cart,
              width: 25,
              height: 25,
              color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () async {
              if (Get.find<CartController>().authRepo.isLoggedIn()) {
                if (OthersMethod.variationsIsEmptyCheck(
                    productDetailsController)) {
                  var cart = CartSelect();
                  await OthersMethod.variationsSelected(
                      productDetailsController);
                  cart.cartView(
                    context: context,
                    isCart: false,
                    productDetailsController: productDetailsController,
                  );
                } else {
                  int price = OthersMethod.productPriceCalculate(
                      productDetailsController);
                  Get.to(
                    () => CheckoutScreen(
                      cartData: OthersMethod().setBuyNowData(
                        productDetailsController,
                        quantity: 1,
                        price: price,
                        brand: OthersMethod.selectedBrands(
                            productDetailsController),
                      ),
                      totalPrice: price,
                      totalQuantity: 1,
                    ),
                  );
                }
              } else {
                showCustomSnackBar(
                  'Please login first!'.tr,
                );
              }
            },
            child: Container(
              width: SizeConfig.screenWidth! / 2.5,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(currentLng == 'Arabic' ? 0 : 30),
                  bottomLeft: Radius.circular(currentLng == 'Arabic' ? 0 : 30),
                  bottomRight: Radius.circular(currentLng == 'Arabic' ? 30 : 0),
                  topRight: Radius.circular(currentLng == 'Arabic' ? 30 : 0),
                ),
              ),
              child: Text(
                'Buy Now'.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kAppBarText.copyWith(
                  color: kWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              if (OthersMethod.variationsIsEmptyCheck(
                  productDetailsController)) {
                var cart = CartSelect();
                await OthersMethod.variationsSelected(productDetailsController);
                cart.cartView(
                  context: context,
                  isCart: true,
                  productDetailsController: productDetailsController,
                );
              } else {
                int cartQuantity =
                Get.find<CartController>().cartItemQuantity(
                    productDetailsController.id ?? 0);
                log('$cartQuantity');
                if (cartQuantity < (productDetailsController.stockQuantity ?? 0)) {
                  Get.find<CartController>().addToCart(
                    productDetailsController,
                    price: OthersMethod.productPriceCalculate(productDetailsController),
                    quantity: 1,
                    brand: OthersMethod.selectedBrands(productDetailsController),
                  );
                } else {
                  showCustomSnackBar('No more stock!'.tr,);
                }
              }
            },
            child: Container(
              width: SizeConfig.screenWidth! / 2.4,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(currentLng == 'Arabic' ? 0 : 30),
                  bottomRight: Radius.circular(currentLng == 'Arabic' ? 0 : 30),
                  topLeft: Radius.circular(currentLng == 'Arabic' ? 30 : 0),
                  bottomLeft: Radius.circular(currentLng == 'Arabic' ? 30 : 0),
                ),
              ),
              child: Text(
                'Add to Cart'.tr,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: kAppBarText.copyWith(
                  color: kWhiteColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
