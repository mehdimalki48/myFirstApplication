import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/auth_controller.dart';
import 'package:woogoods/controllers/orders_controller.dart';
import 'package:woogoods/view/screens/account/components/language_screen.dart';
import 'package:woogoods/view/screens/address_book/address_book_list_screen.dart';
import 'package:woogoods/view/screens/auth/login_screen.dart';
import 'package:woogoods/view/screens/order/my_orders_home_screen.dart';
import 'package:woogoods/view/screens/product/recent_view_screen.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/default_btn.dart';
import 'package:woogoods/view/widgets/input_form_widget.dart';

import '../../../controllers/favorite_controller.dart';
import '../message/support_room_screen.dart';
import '../notifications/notification_screen.dart';
import '../wishlist/wishlist_screen.dart';
import 'components/coupon/coupon_home_screen.dart';
import 'components/customer_support/support_screen.dart';
import 'components/settings_screen.dart';
import 'components/ticket/create_ticket_screen.dart';
import 'widgets/icon_column_text_widget.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = 'settings_screen';

  const AccountScreen({Key? key}) : super(key: key);

  @override
  YourPageState createState() => YourPageState();
}

class YourPageState extends State<AccountScreen> {

  final picker = ImagePicker();
  File? thumbnailImage;
  String? thumbnailBase64;

  @override
  Widget build(BuildContext context) {
    TextEditingController orderIdController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0.0,
        backgroundColor: const Color(0xFFFF6D27),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFF6D27),
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: kWhiteColor,
          systemNavigationBarDividerColor: kWhiteColor,
        ),
      ),
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFF6D27),
                        Color(0xFFFF3A27),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: SizeConfig.screenWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => Get.to(
                                  () => const SettingsScreen(),
                                ),
                                child: Container(
                                  alignment: Alignment.topRight,
                                  height: 20,
                                  width: 20,
                                  margin: const EdgeInsets.only(top: 15),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      Images.settings,
                                      width: 20,
                                      height: 20,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        kHeightBox10,
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.bottomSheet(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 10.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(15.0),
                                        topLeft: Radius.circular(15.0),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: 80,
                                            height: 5,
                                            decoration: BoxDecoration(
                                                color: Get.isDarkMode
                                                    ? kWhiteColor
                                                    : kStUnderLineColor2
                                                        .withOpacity(.5),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                        ),
                                        kHeightBox15,
                                        textRoboto(
                                          "Upload Profile Picture".tr,
                                          Get.isDarkMode
                                              ? kWhiteColor
                                              : kBlackColor,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        kHeightBox10,
                                        const Divider(
                                          thickness: .3,
                                          height: .3,
                                          color: kStUnderLineColor2,
                                        ),
                                        kHeightBox20,
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                            _getThumbnailImage(
                                              type: ImageSource.camera,
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: kOrdinaryColor
                                                      .withOpacity(0.2),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.camera_alt,
                                                    color: Get.isDarkMode
                                                        ? kWhiteColor
                                                        : kBlackColor,
                                                  ),
                                                ),
                                              ),
                                              kWidthBox20,
                                              textRoboto(
                                                  "From Camera",
                                                  Get.isDarkMode
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w500),
                                            ],
                                          ),
                                        ),
                                        kHeightBox20,
                                        InkWell(
                                          onTap: () {
                                            Get.back();
                                            _getThumbnailImage(
                                              type: ImageSource.gallery,
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: kOrdinaryColor
                                                      .withOpacity(0.2),
                                                ),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.perm_media,
                                                    color: Get.isDarkMode
                                                        ? kWhiteColor
                                                        : kBlackColor,
                                                  ),
                                                ),
                                              ),
                                              kWidthBox20,
                                              textRoboto(
                                                  "From Gallery",
                                                  Get.isDarkMode
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.w500),
                                            ],
                                          ),
                                        ),
                                        kHeightBox20,
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 40,
                                width: 40,
                                margin: const EdgeInsets.only(top: 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: thumbnailImage == null
                                      ? const DecorationImage(
                                          image: AssetImage(
                                            Images.addImage,
                                          ),
                                        )
                                      : DecorationImage(
                                          image: FileImage(
                                            thumbnailImage!,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                // child: const Center(
                                //   child: Icon(
                                //     Icons.add,
                                //     size: 18,
                                //     color: kPrimaryColor,
                                //   ),
                                // ),
                              ),
                            ),
                            kWidthBox20,
                            InkWell(
                              onTap: () {
                                if (!authController.isLoggedIn()) {
                                  Get.to(
                                    () => LoginScreen(),
                                  );
                                }
                              },
                              child: Text(
                                authController.isLoggedIn()
                                    ? authController.getUserEmail()
                                    : 'Register / Login'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    ?.copyWith(
                                      color: kWhiteColor,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        kHeightBox20,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () => Get.to(
                                () => const WishListScreen(),
                              ),
                              child: Column(
                                children: [
                                  GetBuilder<FavoriteController>(
                                      builder: (favoriteController) {
                                    return Text(
                                      favoriteController.favoriteList.length
                                          .toString(),
                                      style: kRegularText2.copyWith(
                                        color: kWhiteColor,
                                      ),
                                    );
                                  }),
                                  kHeightBox5,
                                  Text(
                                    'My Wishlist'.tr,
                                    style: kRegularText2.copyWith(
                                        color: kWhiteColor, fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                            /* InkWell(
                              onTap: () => Get.to(
                                () => const StoreListScreen(),

                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '0',
                                    style: kRegularText2.copyWith(
                                      color: kWhiteColor,
                                    ),
                                  ),
                                  kHeightBox5,
                                  Text(
                                    'Followed Stores'.tr,
                                    style: kRegularText2.copyWith(
                                        color: kWhiteColor, fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),*/
                            InkWell(
                              onTap: () => Get.to(
                                () => const CouponHomeScreen(),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    '0',
                                    style: kRegularText2.copyWith(
                                      color: kWhiteColor,
                                    ),
                                  ),
                                  kHeightBox5,
                                  Text(
                                    'Coupon'.tr,
                                    style: kRegularText2.copyWith(
                                        color: kWhiteColor, fontSize: 12.0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        kHeightBox20,
                      ],
                    ),
                  ),
                ),
                kHeightBox10,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: SizeConfig.screenWidth,
                  child: Card(
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Order'.tr,
                              style: kRegularText2.copyWith(
                                color:
                                    Get.isDarkMode ? kWhiteColor : kBlackColor2,
                              ),
                            ),
                          ),
                          kHeightBox10,
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.myOrder,
                                      title: 'My Order'.tr,
                                      onTap: () {
                                        if (authController.isLoggedIn()) {
                                          Get.to(
                                            () => const MyOrdersHomeScreen(),
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first'.tr);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.pending,
                                      title: 'Pending'.tr,
                                      onTap: () {
                                        if (authController.isLoggedIn()) {
                                          Get.to(
                                            () => const MyOrdersHomeScreen(
                                              initialIndex: 1,
                                            ),
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first'.tr);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.picked,
                                      title: 'On Hold'.tr,
                                      onTap: () {
                                        if (authController.isLoggedIn()) {
                                          Get.to(
                                            () => const MyOrdersHomeScreen(
                                              initialIndex: 2,
                                            ),
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first'.tr);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.processing,
                                      title: 'Processing'.tr,
                                      onTap: () {
                                        if (authController.isLoggedIn()) {
                                          Get.to(
                                            () => const MyOrdersHomeScreen(
                                              initialIndex: 3,
                                            ),
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first'.tr);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          kHeightBox5,
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.delivered,
                                      title: 'Delivered'.tr,
                                      onTap: () {
                                        if (authController.isLoggedIn()) {
                                          Get.to(
                                            () => const MyOrdersHomeScreen(
                                              initialIndex: 4,
                                            ),
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first'.tr);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.returned,
                                      title: 'Returned'.tr,
                                      onTap: () {
                                        if (authController.isLoggedIn()) {
                                          Get.to(
                                            () => const MyOrdersHomeScreen(
                                              initialIndex: 5,
                                            ),
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first'.tr);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.cancelled,
                                      title: 'Cancelled'.tr,
                                      onTap: () {
                                        if (authController.isLoggedIn()) {
                                          Get.to(
                                            () => const MyOrdersHomeScreen(
                                              initialIndex: 6,
                                            ),
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first'.tr);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.freeDelivery,
                                      title: 'Failed'.tr,
                                      onTap: () {
                                        if (authController.isLoggedIn()) {
                                          Get.to(
                                            () => const MyOrdersHomeScreen(
                                              initialIndex: 7,
                                            ),
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first'.tr);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          kHeightBox15,
                          InkWell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Tracking Order'.tr,
                                style: kRegularText2.copyWith(
                                  color: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth,
                            child: Row(
                              children: [
                                kWidthBox10,
                                Expanded(
                                  child: InputFormWidget(
                                    fieldController: orderIdController,
                                    hintText: 'Order Id'.tr,
                                    height: 40,
                                    maxLines: 1,
                                  ),
                                ),
                                kWidthBox10,
                                DefaultBtn(
                                  radius: 5.0,
                                  title: 'Track'.tr,
                                  btnColor: Theme.of(context).backgroundColor,
                                  btnColor2: Theme.of(context).backgroundColor,
                                  borderColor: Theme.of(context).hintColor,
                                  textColor: Get.isDarkMode
                                      ? kWhiteColor
                                      : kBlackColor2,
                                  onPress: () {
                                    if (authController.isLoggedIn()) {
                                      if (orderIdController.text.isEmpty) {
                                        showCustomSnackBar(
                                            'Please enter order tracking id!');
                                      } else {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) =>
                                                const CustomLoader());
                                        Get.find<OrdersController>()
                                            .fetchSingleOrders(context,
                                                id: orderIdController.text);
                                        orderIdController.clear();
                                      }
                                    } else {
                                      showCustomSnackBar(
                                          'Please login first'.tr);
                                    }
                                  },
                                ),
                                kWidthBox10,
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                kHeightBox10,
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  width: SizeConfig.screenWidth,
                  child: Card(
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Service'.tr,
                              style: kRegularText2.copyWith(
                                color:
                                    Get.isDarkMode ? kWhiteColor : kBlackColor2,
                              ),
                            ),
                          ),
                          kHeightBox10,
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.notification,
                                      title: 'Notification'.tr,
                                      onTap: () {
                                        Get.to(() => const NotificationScreen(),);
                                      //  Get.to(() => const MyPayTestApp(),);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.communication,
                                      title: 'Live Chat'.tr,
                                      onTap: () {
                                        if (authController.isLoggedIn()) {
                                          Get.to(
                                                () =>  SupportRoomScreen(name: authController.getUserDisplayName(), email: authController.getUserEmail(),),
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first'.tr);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.ticket,
                                      title: 'Ticket'.tr,
                                      onTap: () {
                                        if (authController.isLoggedIn()) {
                                          Get.to(
                                            () => const CreateTicketScreen(),
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first'.tr);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.addressBook,
                                      title: 'Address Book'.tr,
                                      onTap: () {
                                        if (authController.isLoggedIn()) {
                                          Get.to(
                                            () => const AddressBookListScreen(),
                                          );
                                        } else {
                                          showCustomSnackBar(
                                              'Please login first'.tr);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          kHeightBox5,
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.recent,
                                      title: 'Recent Views'.tr,
                                      onTap: () {
                                        Get.to(
                                          () => const RecentViewScreen(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.customerSupport,
                                      title: 'Customer Service'.tr,
                                      onTap: () {
                                        Get.to(
                                          () => const CustomerSupportScreen(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.language,
                                      title: 'Language'.tr,
                                      onTap: () {
                                        Get.to(
                                          () => const LanguageScreen(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  width: SizeConfig.screenWidth! / 4 - 7.5,
                                  height: 65,
                                  child: Center(
                                    child: IconColumnTextWidget(
                                      icon: Images.settings,
                                      title: 'Settings'.tr,
                                      onTap: () {
                                        Get.to(
                                          () => const SettingsScreen(),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

  Future<void> _getThumbnailImage({ImageSource? type}) async {
    final pickedFile = await picker.pickImage(source: type!);

    if (pickedFile != null) {
      setState(() {
        thumbnailImage = File(pickedFile.path);
        thumbnailBase64 = base64Encode(thumbnailImage!.readAsBytesSync());
        log(thumbnailImage.toString());
      });
    } else {
      Get.snackbar('No Image Selected', '', colorText: kWhiteColor);
    }
  }
}
