import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/controllers/suggestion_controller.dart';
import 'package:woogoods/view/widgets/custom_appbar.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/input_form_widget.dart';

import 'search_screen.dart';

class SearchHomeScreen extends StatefulWidget {
  final String? search;
  static const routeName = 'search_home_screen';

  const SearchHomeScreen({
    Key? key,
    this.search,
  }) : super(key: key);

  @override
  State<SearchHomeScreen> createState() => _TestState();
}

class _TestState extends State<SearchHomeScreen> {
  late TextEditingController searchController;
  final SuggestionController suggestionController = Get.find();

  // final ProductController productController = Get.find();
  // final _scrollController = ScrollController();
  //
  // @override
  // void initState() {
  //   _scrollController.addListener(addProducts);
  //   super.initState();
  // }
  //
  // void getProducts({bool reload = false, String? search}) {
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (_) async {
  //       await productController.fetchProductsList(
  //         productController.offset.toString(),
  //         reload,
  //         search: search ?? '',
  //       );
  //     },
  //   );
  // }
  //
  // void addProducts() async {
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     log('===========>>>work');
  //     productController.changeOffset();
  //     getProducts();
  //   }
  // }

  @override
  void initState() {
    searchController = TextEditingController(
      text: widget.search,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await suggestionController.getSuggestionList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(
              search: InputFormWidget(
                fieldController: searchController,
                prefixIcon: Icons.search,
                autoFocus: true,
                hintText: 'Search...'.tr,
                borderColor: kPrimaryColor,
                maxLines: 1,
                radius: 30,
                borderWidth: 1.0,
                height: getProportionateScreenHeight(38),
                onConfirm: (value) {
                  if (searchController.text.isNotEmpty) {
                    suggestionController.addToSuggestion(value);
                  }
                  Get.to(
                    () => SearchScreen(
                      search: value,
                    ),
                    
                  );
                },
                // onSaved: (value) {
                //   getProducts(search: value);
                // },
              ),
              actionWidget: InkWell(
                onTap: () {
                  if (searchController.text.isNotEmpty) {
                    suggestionController.addToSuggestion(searchController.text);
                  }
                  Get.to(
                    () => SearchScreen(
                      search: searchController.text,
                    ),
                    
                  );
                  // searchController.clear();
                  // getProducts();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: Text(
                      'Search'.tr,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            color: Get.isDarkMode ? kWhiteColor : kFbColors,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            Obx(
              () {
                if (suggestionController.isLoading.isTrue) {
                  return const Center(
                    child: CustomLoader(),
                  );
                } else if (suggestionController.suggestionList.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No Suggestions Available'),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Search History',
                              maxLines: 1,
                              style: Theme.of(context).textTheme.headline1,
                            ),
                            InkWell(
                              onTap: () {
                                suggestionController.removeSuggestionList();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: kWhiteColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          children: [
                            for (int index = 0;
                                index <
                                    suggestionController.suggestionList.length;
                                index++)
                              InkWell(
                                onTap: () {
                                  searchController = TextEditingController(
                                    text: suggestionController
                                        .suggestionList[index].title,
                                  );
                                  setState(() {});
                                  Get.to(
                                    () => SearchScreen(
                                      search: searchController.text,
                                    ),
                                    
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: kWhiteColor.withOpacity(.6),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    suggestionController
                                            .suggestionList[index].title ??
                                        '',
                                    maxLines: 1,
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        /*  ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // itemCount: prefs.getStringList('suggestions')?.length,
                          itemCount: suggestionController.suggestionList.length,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                searchController = TextEditingController(
                                  text: suggestionController
                                      .suggestionList[index].title,
                                );
                                setState(() {});
                                Get.to(
                                  () => SearchScreen(
                                    search: searchController.text,
                                  ),
                                  
                                );
                              },
                              child: Wrap(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      suggestionController
                                              .suggestionList[index].title ??
                                          '',
                                      maxLines: 1,
                                      style:
                                          Theme.of(context).textTheme.headline2,
                                    ),
                                  ),
                                  // kHeightBox10,
                                  // Container(
                                  //   alignment: Alignment.center,
                                  //   color: kStUnderLineColor,
                                  //   height: .3,
                                  // ),
                                ],
                              ),
                            );
                          },
                        ),*/
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
