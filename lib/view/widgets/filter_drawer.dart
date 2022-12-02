import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/filter_controller.dart';
import 'package:woogoods/view/screens/search/filter_btn_widget.dart';
import 'custom_loader.dart';
import 'default_btn.dart';

class FilterDrawer extends StatefulWidget {
  final Function onPress, onReset;
  const FilterDrawer({
    Key? key,
    required this.onPress,
    required this.onReset,
  }) : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  final FilterController filterController = Get.find();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: SizeConfig.screenWidth! - 100,
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 5,
            ),
            child: Obx(
              () {
                if (filterController.isLoading.isTrue) {
                  return const Center(
                    child: CustomLoader(),
                  );
                } else {
                  return Column(
                    children: [
                      Expanded(
                        flex: 9,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ship From'.tr,
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              kHeightBox5,
                              Row(
                                children: const [
                                  FilterBtnWidget(
                                    isSelected: true,
                                    icon: kImageDir + 'bangladesh.png',
                                    title: 'BD',
                                  ),
                                  SizedBox(),
                                ],
                              ),
                              kHeightBox10,
                              const Divider(
                                thickness: .3,
                                height: .3,
                                color: Color(0xFF808080),
                              ),
                              kHeightBox5,
                              Text(
                                'Special options'.tr,
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              kHeightBox5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      filterController.changeOnSale();
                                    },
                                    child: FilterBtnWidget(
                                      isSelected: filterController.isOnSale,
                                      title: 'Hot Deals',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      filterController.changeFeatured();
                                    },
                                    child: FilterBtnWidget(
                                      isSelected: filterController.isFeatured,
                                      title: 'Flash Deals',
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
                              kHeightBox5,
                              Text(
                                'Price Range'.tr,
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              kHeightBox5,
                              SizedBox(
                                width: SizeConfig.screenWidth! - 120,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: getProportionateScreenWidth(35),
                                        margin: const EdgeInsets.all(5),
                                        child: TextFormField(
                                          controller: minPriceController,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            filterController.changeMin(value);
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Min',
                                            hintStyle: kSmallText,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 0),
                                              gapPadding: 3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      width: getProportionateScreenWidth(10),
                                      color: kBlackColor2,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: getProportionateScreenWidth(35),
                                        margin: const EdgeInsets.all(5),
                                        child: TextFormField(
                                          controller: maxPriceController,
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            filterController.changeMax(value);
                                          },
                                          decoration: InputDecoration(
                                            hintText: 'Max',
                                            hintStyle: kSmallText,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: const BorderSide(
                                                  color: kPrimaryColor,
                                                  width: 0),
                                              gapPadding: 3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              kHeightBox10,
                              const Divider(
                                thickness: .3,
                                height: .3,
                                color: Color(0xFF808080),
                              ),

                              /// extra design commit start ///
                              /*kHeightBox5,
                        Text(
                          'Brands'.tr,
                          style: kRegularText2.copyWith(
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          ),
                        ),
                        kHeightBox5,
                         Wrap(
                          children: [
                            for (int i = 0; i < 10; i++)
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: FilterBtnWidget(
                                  isSelected: i % 2 == 0 ? true : false,
                                  icon: Images.srl,
                                ),
                              ),
                          ],
                        ),*/

                              /*  kHeightBox10,
                              const Divider(
                                thickness: .3,
                                height: .3,
                                color: Color(0xFF808080),
                              ),
                              kHeightBox5,
                              Text(
                                'Age Range'.tr,
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              kHeightBox5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  FilterBtnWidget(
                                    isSelected: true,
                                    title: 'Over 15 Years',
                                  ),
                                  FilterBtnWidget(
                                    title: '16-18 Years',
                                  ),
                                ],
                              ),
                              kHeightBox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  FilterBtnWidget(
                                    title: 'Over 18 Years',
                                  ),
                                  FilterBtnWidget(
                                    title: '10-15 Years',
                                  ),
                                ],
                              ),
                              kHeightBox10,
                              const Divider(
                                thickness: .3,
                                height: .3,
                                color: Color(0xFF808080),
                              ),
                              kHeightBox5,
                              Text(
                                'Scale'.tr,
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              kHeightBox5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  FilterBtnWidget(
                                    isSelected: true,
                                    title: '1:10',
                                  ),
                                  FilterBtnWidget(
                                    title: '1:16',
                                  ),
                                ],
                              ),
                              kHeightBox10,
                              const Divider(
                                thickness: .3,
                                height: .3,
                                color: Color(0xFF808080),
                              ),
                              kHeightBox5,
                              Text(
                                'Frequency'.tr,
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              kHeightBox5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  FilterBtnWidget(
                                    isSelected: true,
                                    title: '120Hz',
                                  ),
                                ],
                              ), kHeightBox5, const Divider(
                                thickness: .3,
                                height: .3,
                                color: Color(0xFF808080),
                              ),*/

                              /// extra design commit end ///
                              kHeightBox5,
                              Text(
                                'Sort By'.tr,
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              kHeightBox5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      filterController.changeOrderBy('price');
                                    },
                                    child: FilterBtnWidget(
                                      isSelected:
                                          filterController.orderBy == 'price'
                                              ? true
                                              : false,
                                      title: 'Price',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      filterController.changeOrderBy('rating');
                                    },
                                    child: FilterBtnWidget(
                                      isSelected:
                                          filterController.orderBy == 'rating'
                                              ? true
                                              : false,
                                      title: 'Rating',
                                    ),
                                  ),
                                ],
                              ),

                              /// extra design commit start ///

                              /*
                                kHeightBox10,
                              const Divider(
                                thickness: .3,
                                height: .3,
                                color: Color(0xFF808080),
                              ),

                              kHeightBox5,
                              Text(
                                'Color'.tr,
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              kHeightBox5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  FilterBtnWidget(
                                    isSelected: true,
                                    title: 'Red',
                                  ),
                                  FilterBtnWidget(
                                    title: 'Green',
                                  ),
                                ],
                              ),kHeightBox10,
                              const Divider(
                                thickness: .3,
                                height: .3,
                                color: Color(0xFF808080),
                              ),
                              kHeightBox5,
                              Text(
                                'Control Channel'.tr,
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              kHeightBox5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  FilterBtnWidget(
                                    isSelected: true,
                                    title: '4 Channel',
                                  ),
                                  FilterBtnWidget(
                                    title: '5 Channel',
                                  ),
                                ],
                              ),
                              kHeightBox10,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  FilterBtnWidget(
                                    title: '3 Channel',
                                  ),
                                  FilterBtnWidget(
                                    title: '6 Channel',
                                  ),
                                ],
                              ),
                              kHeightBox10,
                              const Divider(
                                thickness: .3,
                                height: .3,
                                color: Color(0xFF808080),
                              ),
                              kHeightBox5,
                              Text(
                                'Version'.tr,
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              kHeightBox5,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  FilterBtnWidget(
                                    isSelected: true,
                                    title: 'PHP',
                                  ),
                                  FilterBtnWidget(
                                    title: 'KIT',
                                  ),
                                ],
                              ),
                              kHeightBox10,
                              const Divider(
                                thickness: .3,
                                height: .3,
                                color: Color(0xFF808080),
                              ),*/
                              /// extra design commit end ///
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          width: SizeConfig.screenWidth! - 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: DefaultBtn(
                                  title: 'Reset',
                                  textColor: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                  borderColor: kPrimaryColor,
                                  border: 1,
                                  btnColor: Get.isDarkMode
                                      ? Colors.transparent
                                      : Theme.of(context).cardColor,
                                  btnColor2: Get.isDarkMode
                                      ? Colors.transparent
                                      : Theme.of(context).cardColor,
                                  radius: 10,
                                  onPress: widget.onReset as Function(),
                                ),
                              ),
                              kWidthBox10,
                              Expanded(
                                child: DefaultBtn(
                                  title: 'Done',
                                  radius: 10,
                                  onPress: widget.onPress as void Function(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
