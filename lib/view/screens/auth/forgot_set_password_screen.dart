import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/auth_controller.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/custom_text_field.dart';
import 'package:woogoods/view/widgets/default_btn.dart';

class ForgotSetPassScreen extends StatelessWidget {
  static const routeName = 'forgot_set_password_screen';

  final String email, code;

  const ForgotSetPassScreen({
    Key? key,
    required this.email,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Text controller
    final passController = TextEditingController();
    final confirmPassController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? const Color(0xFF232323) : const Color(0xFFFFFFFF),
      body: GetBuilder<AuthController>(
        builder: (authController) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    kHeightBox40,
                    Center(
                      child: Image.asset(
                        Images.largeLogo,
                        width: SizeConfig.screenWidth! / 2,
                      ),
                    ),
                    kHeightBox20,
                    Text(
                      'Forgot your Password'.tr,
                      style: kRegularText2.copyWith(
                        fontWeight: FontWeight.w300,
                        color: Get.isDarkMode
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF303030),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
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
                      title: 'Reset'.tr,
                      onPress: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => const CustomLoader());

                          authController.resetNewPassword(
                            context,
                            email: email,
                            password: passController.text,
                            code: code,
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 80,
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
}
