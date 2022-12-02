import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/view/widgets/custom_text_field.dart';
import 'package:woogoods/view/widgets/default_btn.dart';

class ChangePassScreen extends StatelessWidget {
  static const routeName = 'change_password_screen';

  const ChangePassScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    //Text controller
    final oldController = TextEditingController();
    final passController = TextEditingController();
    final confirmPassController = TextEditingController();
    return Scaffold(
      backgroundColor: Get.isDarkMode ? const Color(0xFF232323) : kWhiteColor,
      appBar: AppBar(
        title: Text('Change Password'.tr),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                CustomTextField(
                  labelText: 'Old Password'.tr,
                  controller: oldController,
                  // focusNode: phoneController,
                  // nextFocus: _passwordFocus,
                  isPassword: true,
                  inputType: TextInputType.text,
                  divider: true,
                ),
                kHeightBox25,
                CustomTextField(
                  labelText: 'New Password'.tr,
                  controller: passController,
                  // focusNode: phoneController,
                  // nextFocus: _passwordFocus,
                  isPassword: true,
                  inputType: TextInputType.text,
                  divider: true,
                ),
                kHeightBox25,
                CustomTextField(
                  labelText: 'Confirm Password'.tr,
                  controller: confirmPassController,
                  // focusNode: phoneController,
                  // nextFocus: _passwordFocus,
                  isPassword: true,
                  inputType: TextInputType.text,
                  divider: true,
                ),
                kHeightBox40,
                DefaultBtn(
                  width: SizeConfig.screenWidth,
                  radius: 10.0,
                  title: 'Change Password'.tr,
                  onPress: () {},
                ),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

