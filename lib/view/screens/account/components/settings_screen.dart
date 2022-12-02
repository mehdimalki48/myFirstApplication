import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/theme_controller.dart';
import 'package:woogoods/view/screens/address_book/address_book_list_screen.dart';
import 'package:woogoods/view/screens/auth/login_screen.dart';
import 'package:woogoods/view/widgets/custom_alert_dialog.dart';

import '../../../../constants/strings.dart';
import '../../../../main.dart';
import 'customer_support/support_screen.dart';
import 'language_screen.dart';
import 'sub_components/account_information_screen.dart';
import 'sub_components/help_screen.dart';
import 'sub_components/policies_screen.dart';
import 'widgets/profile_button.dart';
import 'widgets/profile_button2.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = 'settings_screen';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  YourPageState createState() => YourPageState();
}

class YourPageState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings'.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              Card(
                color: Theme.of(context).cardColor,
                margin: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                elevation: 1.0,
                child: Column(
                  children: [
                    ProfileButton(
                        icon: Images.accountInfo,
                        title: 'Account Information'.tr,
                        subTitle: 'View and update your account information'.tr,
                        onTap: () {
                          Get.to(
                            () => const AccountInfoScreen(),
                          );
                        }),
                    ProfileButton(
                        icon: Images.addressBook,
                        title: 'Address Book'.tr,
                        subTitle: 'View your shipping address'.tr,
                        onTap: () => Get.to(
                              const AddressBookListScreen(),
                            )),
                    ProfileButton(
                        icon: Images.customerSupport,
                        title: 'Customer Service'.tr,
                        subTitle: '24 hour support customer service'.tr,
                        onTap: () => Get.to(
                              const CustomerSupportScreen(),
                            )),
                    ProfileButton(
                        icon: Images.language,
                        title: 'Language'.tr,
                        onTap: () {
                          Get.to(
                            () => const LanguageScreen(),
                          );
                        }),
                    ProfileButton(
                      icon: Images.policies,
                      title: 'Policies'.tr,
                      onTap: () => Get.to(
                        () => const PoliciesScreen(),
                      ),
                    ),
                    ProfileButton(
                        icon: Images.helps,
                        title: 'Help'.tr,
                        onTap: () => Get.to(() => const HelpScreen())),
                    ProfileButton2(
                      icon: Icons.dark_mode,
                      title: 'Dark Mode'.tr,
                      radius: 5,
                      isButtonActive: Get.isDarkMode,
                      onTap: () {
                        Get.find<ThemeController>().toggleTheme();
                      },
                    ),
                  ],
                ),
              ),
              kHeightBox40,
              if((prefs.containsKey(token)))
              InkWell(
                onTap: () {
                  CustomAlertDialog().logOut(
                    onPress: () async {
                      await prefs.clear();
                      setState(() {});
                      Get.back();
                      Get.to(
                        () => LoginScreen(),
                      );
                    },
                  );
                },
                child: SizedBox(
                  width: SizeConfig.screenWidth,
                  child: Card(
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 1.0,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Logout'.tr,
                          style: kBoldStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).errorColor),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              kHeightBox40,
            ],
          ),
        ),
      ),
    );
  }
}
