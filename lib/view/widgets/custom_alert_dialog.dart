import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/services/localization_services.dart';

class CustomAlertDialog {
  void changeLanguage() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                Images.close,
                color: kPrimaryColor,
                width: 40,
              ),
            ),
            kHeightBox5,
            Text(
              'Language',
              style: kAppBarText.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            kHeightBox10,
            Text(
              'Are you want to change language?',
              style: kRegularText.copyWith(
                color: kBlackColor.withOpacity(.6),
              ),
            ),
            kHeightBox30,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    if (LocalizationService().getCurrentLang() != 'English') {
                      LocalizationService().changeLocale('English');
                      Get.back();
                    } else {
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: LocalizationService().getCurrentLang() == 'English'
                          ? kPrimaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width:
                            LocalizationService().getCurrentLang() == 'English'
                                ? 0
                                : 1,
                        color:
                            LocalizationService().getCurrentLang() == 'English'
                                ? Colors.transparent
                                : kPrimaryColor,
                      ),
                    ),
                    child: Text(
                      "English",
                      style: kRegularText2.copyWith(
                        color:
                            LocalizationService().getCurrentLang() == 'English'
                                ? kWhiteColor
                                : kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                kWidthBox20,
                InkWell(
                  onTap: () {
                    if (LocalizationService().getCurrentLang() != 'Spanish') {
                      LocalizationService().changeLocale('Spanish');
                      Get.back();
                    } else {
                      Get.back();
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: LocalizationService().getCurrentLang() == 'Spanish'
                          ? kPrimaryColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width:
                            LocalizationService().getCurrentLang() == 'Spanish'
                                ? 0
                                : 1,
                        color:
                            LocalizationService().getCurrentLang() == 'Spanish'
                                ? Colors.transparent
                                : kPrimaryColor,
                      ),
                    ),
                    child: Text(
                      "Spanish",
                      style: kRegularText2.copyWith(
                        color:
                            LocalizationService().getCurrentLang() == 'Spanish'
                                ? kWhiteColor
                                : kPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            kHeightBox10,
          ],
        ),
      ),
    );
  }

  void logOut({
    Function? onPress,
  }) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        color: Get.isDarkMode ? kBlackColor2 : kWhiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.logout,
                color: kPrimaryColor,
                size: 40,
              ),
            ),
            kHeightBox5,
            Text(
              'Log Out'.tr,
              style: kAppBarText.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            kHeightBox10,
            Text(
              'Are you want to log out?'.tr,
              style: kRegularText.copyWith(
                color:
                    Get.isDarkMode ? kWhiteColor : kBlackColor.withOpacity(.6),
              ),
            ),
            kHeightBox20,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onPress as void Function(),
                  child: Text(
                    "Yes".tr,
                    style: kRegularText2.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                kWidthBox20,
                kWidthBox20,
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "No".tr,
                    style: kRegularText2.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Get.isDarkMode ? kWhiteColor : kBlackColor,
                    ),
                  ),
                ),
              ],
            ),
            kHeightBox10,
          ],
        ),
      ),
    );
  }

  customAlert({
    String? title,
    String? body,
    String confirmTitle = 'Confirm',
    String cancelTitle = 'Cancel',
    Color? color,
    BuildContext? context,
    Function? onPress,
  }) {
    String? currentLng = LocalizationService().getCurrentLang();
    return showDialog(
      context: context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: getProportionateScreenHeight(60),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        title ?? '',
                        style: kRegularText.copyWith(
                          fontWeight: FontWeight.w800,
                          color: Get.isDarkMode ? kWhiteColor : kBlackColor,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Get.isDarkMode ? kWhiteColor : kBlackColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: kStUnderLineColor,
                thickness: 0.3,
                height: 0.3,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 50),
                child: Text(
                  body ?? '',
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: onPress as void Function(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF32B17c),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                                currentLng == 'Arabic' ? 0 : 10),
                            bottomRight: Radius.circular(
                                currentLng == 'Arabic' ? 10 : 0),
                          ),
                        ),
                        child: Text(
                          confirmTitle,
                          style: kRegularText.copyWith(
                            color: kWhiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: kErrorColor,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(
                                currentLng == 'Arabic' ? 0 : 10),
                            bottomLeft: Radius.circular(
                                currentLng == 'Arabic' ? 10 : 0),
                          ),
                        ),
                        child: Text(
                          cancelTitle,
                          style: kRegularText.copyWith(
                            color: kWhiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  customAlert2({
    String? title,
    String? body,
    String confirmTitle = 'Confirm',
    String cancelTitle = 'Cancel',
    Color? color,
    BuildContext? context,
    Function? onPress,
  }) {
    return showDialog(
      context: context!,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          titlePadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 10, right: 10),
                  child: Center(
                    child: Text(
                      title ?? '',
                      style: Theme.of(context).textTheme.headline2?.copyWith(
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor,
                          ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 30),
                child: Text(
                  body ?? '',
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: [
                  kWidthBox10,
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: kBgColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          cancelTitle,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: kBlackColor,
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  kWidthBox10,
                  Expanded(
                    child: InkWell(
                      onTap: onPress as void Function(),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          confirmTitle,
                          style:
                              Theme.of(context).textTheme.headline2!.copyWith(
                                    color: kWhiteColor,
                                    fontSize: 14,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  kWidthBox10,
                ],
              ),
              kHeightBox5,
            ],
          ),
        );
      },
    );
  }
}
