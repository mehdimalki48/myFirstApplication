import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/filter_controller.dart';
import 'package:woogoods/controllers/product_controller.dart';
import 'package:woogoods/view/screens/cart/cart_screen.dart';
import 'package:woogoods/view/screens/dashboard/dashboard_screen.dart';
import 'package:woogoods/view/widgets/custom_appbar.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';
import 'package:woogoods/view/widgets/filter_drawer.dart';
import 'package:woogoods/view/widgets/input_form_widget.dart';
import 'package:woogoods/view/widgets/product_grid_list.dart';
import 'package:woogoods/view/widgets/product_listview.dart';

import '../../../controllers/cart_controller.dart';
import 'search_home_screen.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = 'search_screen';
  final String? catId;
  final String? search;
  final String? brandId;
  const SearchScreen({
    Key? key,
    this.catId,
    this.search,
    this.brandId,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  final FilterController filterController = Get.find();
  final GlobalKey<ScaffoldState> filterKey = GlobalKey();
  final ProductController productController = Get.find();
  final _scrollController = ScrollController();

  @override
  void initState() {
    searchController = TextEditingController(text: widget.search);

    super.initState();
  }

  void getProducts({
    bool reload = false,
    String? minPrice,
    String? maxPrice,
    bool onSale = false,
    bool featured = false,
    String? orderBy,
  }) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await productController.fetchProductsList(
        productController.offset.toString(),
        reload,
        onSale: onSale,
        search: widget.search ?? '',
        feature: featured,
        parentId: widget.catId,
        maxPrice: maxPrice,
        minPrice: minPrice,
        order: filterController.isDescending,
        orderBy: orderBy,
        brandId: widget.brandId,
      );
    });
  }

  void addProducts() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      log('===========>>>work');
      productController.showBottomLoader();
      productController.changeOffset();
      getProducts();
    }
  }
  Future<void> _loadData(bool reload) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.find<CartController>().hideDelete();
      Get.find<CartController>().getAllCartList(isTamUp: true);
      getProducts();
      _scrollController.addListener(addProducts);
    },);
  }

  @override
  Widget build(BuildContext context) {
    _loadData(false);

    return Scaffold(
      // backgroundColor: Theme.of(context).cardColor,
      // key: filterKey,
      endDrawer: FilterDrawer(
        onPress: () {
          Navigator.pop(context);
          getProducts(
            minPrice: filterController.minPrice,
            maxPrice: filterController.maxPrice,
            onSale: filterController.isOnSale,
            featured: filterController.isFeatured,
            orderBy: filterController.orderBy,
          );
          filterController.changeMax(null);
          filterController.changeOrderBy(null);
          filterController.changeMin(null);
        },
        onReset: () {
          Navigator.pop(context);
          filterController.resetFilter();
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await productController.fetchProductsList(
              productController.offset.toString(),
              true,
              search: widget.search ?? '',
            );
          });
        },
      ),
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        toolbarHeight: 0.0,
        actions: [
          Container(),
        ],
      ),
      body: Obx(
        () {
          if (filterController.isLoading.isTrue) {
            return const Center(
              child: CustomLoader(),
            );
          } else {
            return Column(
              children: [
                CustomAppBar(
                  search: InkWell(
                    onTap: () {
                      Get.off(() => SearchHomeScreen(
                            search: widget.search,
                          ));
                    },
                    child: InputFormWidget(
                      fieldController: searchController,
                      prefixIcon: Icons.search,
                      hintText: 'Search...'.tr,
                      borderColor: kPrimaryColor,
                      maxLines: 1,
                      radius: 30,
                      borderWidth: 1.0,
                      height: getProportionateScreenHeight(38),
                      absorbing: true,
                    ),
                  ),
                  actionWidget: Row(
                    children: [
                      kWidthBox10,
                      InkWell(
                        onTap: () => Get.to(
                          () => const CartListScreen(),
                        ),
                        child: SizedBox(
                          width: 20,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              SvgPicture.asset(
                                Images.cart,
                                color:
                                    Get.isDarkMode ? kWhiteColor : kBlackColor2,
                                height: 20,
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
                                  child: Center(child: GetBuilder<CartController>(
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
                                  ),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      kWidthBox10,
                      InkWell(
                        onTap: () => Get.offAll(
                          () => const DashBoardScreen(
                            index: 0,
                          ),
                        ),
                        child: SizedBox(
                          width: 20,
                          child: SvgPicture.asset(
                            Images.moreVert,
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                            height: 20,
                          ),
                        ),
                      ),
                      kWidthBox10,
                    ],
                  ),
                ),
                Container(
                  height: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    boxShadow: [
                      kOrdinaryShadow,
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            filterController.changeFilterActive();
                          },
                          child: SizedBox(
                            height: getProportionateScreenWidth(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  filterController.selectedFilter ??
                                      'Best Match',
                                  style: kDescriptionText.copyWith(
                                    color: Get.isDarkMode
                                        ? kWhiteColor
                                        : const Color(0xFF707070),
                                  ),
                                ),
                                kWidthBox5,
                                const Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Filter',
                        style: kDescriptionText.copyWith(
                          color: Get.isDarkMode
                              ? kWhiteColor
                              : const Color(0xFF707070),
                        ),
                      ),
                      kWidthBox15,
                      Builder(
                        builder: (context) => // Ensure Scaffold is in context
                            InkWell(
                          onTap: () {
                            log('print');
                            // filterKey.currentState!.openEndDrawer();
                            /* if (filterKey.currentState!.isEndDrawerOpen) {
                              filterKey.currentState!.openDrawer();
                            } else {
                              filterKey.currentState!.openEndDrawer();
                            }*/
                            Scaffold.of(context).openEndDrawer();
                          },
                          child: SvgPicture.asset(
                            Images.filter,
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                            height: 16,
                          ),
                        ),
                      ),
                      kWidthBox15,
                      InkWell(
                        onTap: () {
                          filterController.changeGrid();
                        },
                        child: filterController.isGrid == true
                            ? SvgPicture.asset(
                                Images.grid,
                                color:
                                    Get.isDarkMode ? kWhiteColor : kBlackColor2,
                                height: 20,
                                width: 20,
                              )
                            : SvgPicture.asset(
                                Images.list,
                                color:
                                    Get.isDarkMode ? kWhiteColor : kBlackColor2,
                                height: 20,
                                width: 20,
                              ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(
                    () {
                      if (productController.isLoading.isTrue) {
                        return filterController.isGrid == true
                            ? productsGridShimmer()
                            : productsListShimmer();
                      } else if (productController.productList.isEmpty) {
                        return const Center(
                          child: Text(
                            'No Products Available',
                          ),
                        );
                      } else {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            filterController.isGrid == true
                                ? ProductGridList(
                                    controller: _scrollController,
                                    productList: productController.productList,
                                    noPadding: false,
                                  )
                                : ProductListView(
                                    controller: _scrollController,
                                    productList: productController.productList,
                                    noPadding: false,
                                    productLength: 20,
                                    cardColor: Theme.of(context).cardColor,
                                  ),
                            filterController.isFilterActive
                                ? Positioned(
                                    top: 0,
                                    child: Container(
                                      width: SizeConfig.screenWidth,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        boxShadow: [
                                          kOrdinaryShadow,
                                        ],
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(
                                            10,
                                          ),
                                          bottomRight: Radius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                      child: ListView.builder(
                                        itemCount:
                                            filterController.matchFilter.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, int index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  width: .3,
                                                  color: filterController
                                                                  .matchFilter
                                                                  .length -
                                                              1 ==
                                                          index
                                                      ? Colors.transparent
                                                      : kStUnderLineColor,
                                                ),
                                              ),
                                            ),
                                            child: ListTile(
                                              title: Text(
                                                filterController
                                                    .matchFilter[index],
                                                style: kRegularText2.copyWith(
                                                  color: Get.isDarkMode
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                ),
                                              ),
                                              trailing: filterController
                                                          .matchFilter[index] ==
                                                      filterController
                                                          .selectedFilter
                                                  ? Icon(
                                                      Icons.check_circle,
                                                      color: Get.isDarkMode
                                                          ? kWhiteColor
                                                          : kPrimaryColor,
                                                    )
                                                  : const SizedBox(),
                                              onTap: () {
                                                filterController.changeFilter(
                                                    filterController
                                                        .matchFilter[index]);
                                                filterController
                                                    .changeFilterActive();
                                                filterController.changeOrder();
                                                getProducts();
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            Positioned(
                              bottom: -20,
                              child: productController.isLoadingMore.isTrue
                                  ? const CustomLoader()
                                  : const SizedBox(),
                            )
                          ],
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
