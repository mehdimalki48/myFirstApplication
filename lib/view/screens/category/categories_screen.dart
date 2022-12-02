import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/category_controller.dart';
import 'package:woogoods/view/screens/search/search_screen.dart';
import 'package:woogoods/view/widgets/app_bar_actions.dart';
import 'package:woogoods/view/widgets/custom_shimmer.dart';

class CategoriesScreen extends StatefulWidget {
  static const routeName = 'shop_cat_screen';

  const CategoriesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final ScrollController scrollController = ScrollController();
  final CategoryController categoryController = Get.find();

  int catIndex = 0;
  int? selected;

  void _scrollToIndex(int? index) {
    scrollController.animateTo(
      80.0 * index!,
      duration: const Duration(seconds: 1),
      curve: Curves.easeIn,
    );
  }

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  void getCategory() async {
    await categoryController.fetchParentCatList(parent: '0');
    for (int i = 0; i < categoryController.categoriesList.length; i++) {
      if (categoryController.categoriesList[i].count! > 1) {
        catIndex = i;
        await categoryController.fetchSubCatList(
          parent: categoryController.categoryList[i].id.toString(),
        );
        break;
      }
    }
  }

  void getSubCategory(String id) async {
    await categoryController.fetchSubCatList(parent: id);
  }

  void getChildCategory(String id) async {
    await categoryController.fetchChildCatList(parent: id);

    if (categoryController.childCategoriesList.isEmpty) {
      Get.to(
        () => SearchScreen(
          catId: id.toString(),
        ),
      );
    } else {
      var isEmpty = categoryController.childCategoriesList
              .where((element) => element.count! < 1)
              .length ==
          categoryController.childCategoriesList.length;
      log(isEmpty.toString());
      if (isEmpty) {
        Get.to(
          Get.to(
            () => SearchScreen(
              catId: id.toString(),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? kDarkColor : const Color(0xFFF3F3F3),
      appBar: AppBar(
        elevation: 0.5,
        title: const Text('Category'),
        actions: const [
          AppBarActions(
            isWishlist: true,
            isSearch: true,
            isCart: true,
          ),
        ],
      ),
      body: SizedBox(
        width: SizeConfig.screenWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Obx(
                () {
                  if (categoryController.isParentLoading.isTrue) {
                    return parentCategoriesShimmer();
                  } else {
                    return SizedBox(
                      height: SizeConfig.screenHeight,
                      child: ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: categoryController.categoryList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return categoryController.categoryList[index].count! <
                                  1
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () async {
                                    if (catIndex != index) {
                                      setState(
                                        () {
                                          catIndex = index;
                                          log(catIndex.toString());
                                        },
                                      );
                                      getSubCategory(
                                        categoryController
                                            .categoryList[index].id
                                            .toString(),
                                      );
                                    }
                                  },
                                  child: AspectRatio(
                                    aspectRatio: 1.2,
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Get.isDarkMode
                                            ? (catIndex == index
                                                ? kDarkColor
                                                : kLiteDarkColor)
                                            : (catIndex == index
                                                ? kWhiteColor
                                                : const Color(0xFFF3F3F3)),
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: categoryController
                                                        .categoryList[index]
                                                        .image ==
                                                    null
                                                ? Image.asset(
                                                    Images.placeHolder,
                                                    height: 25,
                                                  )
                                                : Image.network(
                                                    categoryController
                                                        .categoryList[index]
                                                        .image!
                                                        .src!,
                                                    height: 25,
                                                  ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              categoryController
                                                      .categoryList[index].name
                                                      ?.replaceAll(
                                                          htmlValidatorRegExp,
                                                          '') ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              style: kDescriptionText.copyWith(
                                                color: Get.isDarkMode
                                                    ? kWhiteColor
                                                    : kBlackColor2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            Expanded(
              flex: 9,
              child: Obx(
                () {
                  if (categoryController.isSubCatLoading.isTrue) {
                    return parentCategoriesShimmer();
                  } else if (categoryController.subCategoriesList.isEmpty) {
                    return const Center(
                      child: Text('No Sub-categories Available'),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      color: Theme.of(context).cardColor,
                      child: ListView(
                        controller: scrollController,
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        children: [
                          kHeightBox10,
                          AspectRatio(
                            aspectRatio: 2.5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: kOrdinaryColor2,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: isImageShow
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://www.nicepng.com/png/detail/593-5933043_promotion-banner-png-promotional-banners.png',
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            color: kOrdinaryColor2,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child:
                                              Image.asset(Images.placeHolder),
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
                          ),
                          kHeightBox5,
                          ListView.builder(
                            key: Key('builder ${selected.toString()}'),
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount:
                                categoryController.subCategoriesList.length,
                            itemBuilder: (context, int index) {
                              return categoryController
                                          .subCategoriesList[index].count! <
                                      1
                                  ? const SizedBox()
                                  : Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: .3,
                                            color: categoryController
                                                            .subCategoriesList
                                                            .length -
                                                        1 ==
                                                    index
                                                ? Colors.transparent
                                                : kStUnderLineColor,
                                          ),
                                        ),
                                      ),
                                      child: Theme(
                                        data: ThemeData().copyWith(
                                          dividerColor: Colors.transparent,
                                        ),
                                        child: ExpansionTile(
                                          key: Key(index.toString()),
                                          initiallyExpanded: index == selected,
                                          onExpansionChanged: ((newState) {
                                            if (newState) {
                                              getChildCategory(
                                                  categoryController
                                                      .subCategoriesList[index]
                                                      .id
                                                      .toString());
                                              setState(() {
                                                selected = index;
                                              });
                                              _scrollToIndex(selected);
                                            } else {
                                              setState(() {
                                                selected = -1;
                                              });
                                            }
                                          }),
                                          collapsedTextColor: kBlackColor2,
                                          iconColor: kStUnderLineColor,
                                          collapsedIconColor: kStUnderLineColor,
                                          tilePadding: EdgeInsets.zero,
                                          childrenPadding: EdgeInsets.zero,
                                          title: InkWell(
                                            onTap: () => Get.to(
                                              () => SearchScreen(
                                                catId: categoryController
                                                    .subCategoriesList[index].id
                                                    .toString(),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  categoryController
                                                          .subCategoriesList[
                                                              index]
                                                          .name
                                                          ?.replaceAll(
                                                              htmlValidatorRegExp,
                                                              '') ??
                                                      '',
                                                  maxLines: 1,
                                                  style: kRegularText2.copyWith(
                                                    color: Get.isDarkMode
                                                        ? kWhiteColor
                                                        : kBlackColor2,
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  color: kStUnderLineColor,
                                                  width: 1,
                                                  height: 20,
                                                )
                                              ],
                                            ),
                                          ),
                                          children: [
                                            Obx(
                                              () {
                                                if (categoryController
                                                    .isChildCatLoading.isTrue) {
                                                  return childCategoriesShimmer();
                                                } else if (categoryController
                                                    .childCategoriesList
                                                    .isEmpty) {
                                                  return const Center(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                        vertical: 10,
                                                      ),
                                                      child: Text(
                                                          'No Child Categories Available'),
                                                    ),
                                                  );
                                                } else {
                                                  return MasonryGridView.count(
                                                    crossAxisCount: 3,
                                                    shrinkWrap: true,
                                                    itemCount:
                                                        categoryController
                                                            .childCategoriesList
                                                            .length,
                                                    physics:
                                                        const ScrollPhysics(),
                                                    mainAxisSpacing: 10.0,
                                                    crossAxisSpacing: 10.0,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index2) {
                                                      return categoryController
                                                                  .childCategoriesList[
                                                                      index2]
                                                                  .count! <
                                                              1
                                                          ? const SizedBox()
                                                          : InkWell(
                                                              onTap: () =>
                                                                  Get.to(
                                                                () =>
                                                                    SearchScreen(
                                                                  catId: categoryController
                                                                      .childCategoriesList[
                                                                          index2]
                                                                      .id
                                                                      .toString(),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        getProportionateScreenWidth(
                                                                            85),
                                                                    width:
                                                                        getProportionateScreenWidth(
                                                                            80),
                                                                    child: categoryController.childCategoriesList[index2].image ==
                                                                            null
                                                                        ? Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: kOrdinaryColor2,
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                            height:
                                                                                getProportionateScreenWidth(85),
                                                                            width:
                                                                                getProportionateScreenWidth(80),
                                                                            child:
                                                                                Image.asset(Images.placeHolder),
                                                                          )
                                                                        : ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(5),
                                                                            child:
                                                                                CachedNetworkImage(
                                                                              imageUrl: categoryController.childCategoriesList[index2].image!.src!,
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
                                                                            ),
                                                                          ),
                                                                  ),
                                                                  kHeightBox5,
                                                                  Text(
                                                                    categoryController
                                                                            .childCategoriesList[
                                                                                index2]
                                                                            .name
                                                                            ?.replaceAll(htmlValidatorRegExp,
                                                                                '') ??
                                                                        '',
                                                                    style: kDescriptionText
                                                                        .copyWith(
                                                                      color: Get
                                                                              .isDarkMode
                                                                          ? kWhiteColor
                                                                          : kBlackColor2,
                                                                    ),
                                                                    maxLines: 2,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                    },
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
