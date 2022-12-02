import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/util/md2_indicator.dart';
import 'package:woogoods/view/screens/search/search_home_screen.dart';
import 'package:new_version/new_version.dart';
import '../../../constants/strings.dart';
import '../../../controllers/category_controller.dart';
import '../../../controllers/home_controller.dart';
import '../../../main.dart';
import '../../../services/api/api_client.dart';
import '../../../services/api/app_config.dart';
import '../../widgets/custom_shimmer.dart';
import '../message/support_room_screen.dart';
import 'components/all_screen/all_screen.dart';
import 'components/all_screen/components/home_menus.dart';
import 'components/all_screen/widgets/more_widgets.dart';
import 'components/watch_screens.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  YourPageState createState() => YourPageState();
}

class YourPageState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    //load data
    _loadData(false);
    //setup google app update checker
    initPlatformState();
    // Instantiate NewVersion manager object
    final newVersion = NewVersion(
      iOSId: 'com.akaarit.woogoods',
      androidId: 'com.akaarit.woogoods',
    );

    basicStatusCheck(newVersion);
    //advancedStatusCheck(newVersion);
  }

  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Update Available',
        dialogText:
        "A new version of Upgrade is available!. Version ${status.storeVersion}, is now available-your have ${status.localVersion}\nWould you like to update it now",
      );
    }
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    OneSignal.shared.setAppId(onesignalAppId);

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    /* OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      log("Accepted permission: $accepted");
    });*/
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
            (OSNotificationReceivedEvent event) {
          // Will be called whenever a notification is received in foreground
          // Display Notification, pass null param for not displaying the notification
          event.complete(event.notification);
        });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver(
            (OSEmailSubscriptionStateChanges emailChanges) {
          // Will be called whenever then user's email subscription changes
          // (ie. OneSignal.setEmail(email) is called and the user gets registered
        });
  }

  Future<void> _loadData(bool reload) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Get.put(ApiClient(appBaseUrl: baseUrl));
      Get.find<CategoryController>().fetchHomeCategoryList('1', false);
      Get.find<HomeController>().fetchSliderList('1', reload);
      Get.find<HomeController>().fetchFlashSaleList('1', reload);
      Get.find<HomeController>().fetchTodaySellList('1', reload);
      Get.find<HomeController>().fetchBrandList('1', reload,);
      Get.find<HomeController>().fetchHomeProductList('1', reload);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<CategoryController>(
        builder: (homeController) {
          log('loggggggggggggggggggg cat........${homeController.isCategoryLoading}');
          return Container(
            child: homeController.isCategoryLoading
                ? Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(Images.homeLogo),
                    ),
                    kWidthBox10,
                    Expanded(
                      flex: 8,
                      child: InkWell(
                        onTap: () {
                          Get.to(
                                () => const SearchHomeScreen(),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: getProportionateScreenHeight(38),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Images.search,
                                height: 20,
                              ),
                              kWidthBox15,
                              Text(
                                'Search...'.tr,
                                style: kRegularText2.copyWith(
                                  color: kOrdinaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    kWidthBox10,
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          if (prefs.containsKey(token)) {
                            Get.to(
                                  () => SupportRoomScreen(
                                name: prefs.getString(userDisplayName) ??
                                    "",
                                email: prefs.getString(userEmail) ?? "",
                              ),
                            );
                          } else {
                            showCustomSnackBar('Please login first'.tr);
                          }
                        },
                        child: SvgPicture.asset(
                          Images.chat,
                          height: 25,
                          color:
                          Get.isDarkMode ? kWhiteColor : kBlackColor2,
                        ),
                      ),
                    ),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size(
                    SizeConfig.screenWidth!,
                    40,
                  ),
                  child: homeCategoryShimmer(),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  children: [
                    kHeightBox10,
                    sliderShimmer(),
                    const HomeMenus(),
                    Container(
                      padding: const EdgeInsets.all(
                        10,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          kOrdinaryShadow,
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Flash Deal'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              MoreWidgets(
                                onTap: () {},
                              ),
                            ],
                          ),
                          kHeightBox10,
                          homeProductShimmer(),
                        ],
                      ),
                    ),
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
                            'https://i.postimg.cc/9QXp0c6K/i-1.png',
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Container(
                                  decoration: BoxDecoration(
                                    color: kOrdinaryColor2,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                  ),
                                  child: Image.asset(
                                    Images.placeHolder,
                                    fit: BoxFit.cover,
                                  ),
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
                          child: Image.asset(
                            Images.placeHolder,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    kHeightBox10,
                    Container(
                      padding: const EdgeInsets.all(
                        10,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          kOrdinaryShadow,
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'TodayDeal'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                              const Spacer(),
                              MoreWidgets(
                                onTap: () {},
                              ),
                            ],
                          ),
                          kHeightBox10,
                          homeProductShimmer(),
                        ],
                      ),
                    ),
                    kHeightBox10,
                    Container(
                      padding: const EdgeInsets.all(
                        10,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          kOrdinaryShadow,
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Brands'.tr,
                                style: Theme.of(context).textTheme.headline1!.copyWith(
                                  color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              MoreWidgets(
                                onTap: () {},
                              ),
                            ],
                          ),
                          kHeightBox10,
                          brandShimmer(itemCount: 4),
                        ],
                      ),
                    ),
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
                            'https://i.postimg.cc/9QXp0c6K/i-1.png',
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Container(
                                  decoration: BoxDecoration(
                                    color: kOrdinaryColor2,
                                    borderRadius:
                                    BorderRadius.circular(5),
                                  ),
                                  child: Image.asset(
                                    Images.placeHolder,
                                    fit: BoxFit.cover,
                                  ),
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
                          child: Image.asset(
                            Images.placeHolder,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    kHeightBox15,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 1.5,
                              width: 70,
                              color: const Color(0xFFC4C4C4),
                            ),
                            Positioned(
                              right: -2,
                              top: -1.7,
                              child: Container(
                                height: 5,
                                width: 5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFC4C4C4),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        kWidthBox10,
                        Text(
                          'You May Like'.tr,
                          style: kAppBarText.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        kWidthBox10,
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 1.5,
                              width: 70,
                              color: const Color(0xFFC4C4C4),
                            ),
                            Positioned(
                              left: -2,
                              top: -1.7,
                              child: Container(
                                height: 5,
                                width: 5,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFC4C4C4),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    kHeightBox15,
                    productsGridShimmer(),
                  ],
                ),
              ),
            )
                : homeController.homeCategoryList.isNotEmpty
                ? DefaultTabController(
              length: homeController.homeCategoryList.length,
              initialIndex: 0,
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  title: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(Images.homeLogo),
                      ),
                      kWidthBox10,
                      Expanded(
                        flex: 8,
                        child: InkWell(
                          onTap: () {
                            Get.to(
                                  () => const SearchHomeScreen(),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kPrimaryColor,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            height: getProportionateScreenHeight(38),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  Images.search,
                                  height: 20,
                                ),
                                kWidthBox15,
                                Text(
                                  'Search...'.tr,
                                  style: kRegularText2.copyWith(
                                    color: kOrdinaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      kWidthBox10,
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            if (prefs.containsKey(token)) {
                              Get.to(
                                    () => SupportRoomScreen(
                                  name: prefs.getString(
                                      userDisplayName) ??
                                      "",
                                  email: prefs.getString(userEmail) ??
                                      "",
                                ),
                              );
                            } else {
                              showCustomSnackBar(
                                  'Please login first'.tr);
                            }
                          },
                          child: SvgPicture.asset(
                            Images.chat,
                            height: 25,
                            color: Get.isDarkMode
                                ? kWhiteColor
                                : kBlackColor2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  bottom: TabBar(
                      indicatorColor: kPrimaryColor,
                      labelColor: kPrimaryColor,
                      isScrollable: true,
                      unselectedLabelColor:
                      Get.isDarkMode ? kWhiteColor : kBlackColor2,
                      unselectedLabelStyle:
                      Theme.of(context).textTheme.headline2,
                      labelStyle: Theme.of(context)
                          .textTheme
                          .headline1!
                          .copyWith(
                        color: Get.isDarkMode
                            ? kWhiteColor
                            : kBlackColor2,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      indicator: const MD2Indicator(
                        indicatorSize: MD2IndicatorSize.normal,
                        indicatorHeight: 4.0,
                        indicatorColor: kPrimaryColor,
                      ),
                      tabs:
                      homeController.homeCategoryList.map((item) {
                        // get index
                        int index = homeController.homeCategoryList
                            .indexOf(item);
                        if (index == 0) {
                          return const Tab(
                            text: 'All',
                          );
                        } else {
                          return Tab(
                            text: index ==
                                homeController
                                    .homeCategoryList.length -
                                    1
                                ? (homeController
                                .homeCategoryList[index]
                                .name ??
                                '').replaceAll(htmlValidatorRegExp, '')
                                : (homeController.homeCategoryList[index - 1].name ?? '').replaceAll(htmlValidatorRegExp, ''),
                          );
                        }
                      }).toList()),
                ),
                body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children:
                  homeController.homeCategoryList.map((item) {
                    // get index
                    int index =
                    homeController.homeCategoryList.indexOf(item);
                    if (index == 0) {
                      return const AllScreens();
                    } else {
                      return WatchScreens(
                        categoryId: index ==
                            homeController
                                .homeCategoryList.length -
                                1
                            ? (homeController
                            .homeCategoryList[index].id)
                            .toString()
                            : (homeController
                            .homeCategoryList[index - 1].id)
                            .toString(),
                      );
                    }
                  }).toList(),
                ),
              ),
            )
                : Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.asset(Images.homeLogo),
                    ),
                    kWidthBox10,
                    Expanded(
                      flex: 8,
                      child: InkWell(
                        onTap: () {
                          Get.to(
                                () => const SearchHomeScreen(),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kPrimaryColor,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: getProportionateScreenHeight(38),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Images.search,
                                height: 20,
                              ),
                              kWidthBox15,
                              Text(
                                'Search...'.tr,
                                style: kRegularText2.copyWith(
                                  color: kOrdinaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    kWidthBox10,
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          if (prefs.containsKey(token)) {
                            Get.to(
                                  () => SupportRoomScreen(
                                name: prefs
                                    .getString(userDisplayName) ??
                                    "",
                                email:
                                prefs.getString(userEmail) ?? "",
                              ),
                            );
                          } else {
                            showCustomSnackBar(
                                'Please login first'.tr);
                          }
                        },
                        child: SvgPicture.asset(
                          Images.chat,
                          height: 25,
                          color: Get.isDarkMode
                              ? kWhiteColor
                              : kBlackColor2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: const AllScreens(),
            ),
          );
        },
      ),
    );
  }
}
