import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/auth_controller.dart';
import 'package:woogoods/models/body/login_body.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/custom_text_field.dart';
import 'package:woogoods/view/widgets/default_btn.dart';
import 'package:woogoods/view/widgets/social_btn.dart';
import 'forgot_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'login_screen';

  LoginScreen({Key? key}) : super(key: key);

  final userNameController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? const Color(0xFF232323) : const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              kHeightBox40,
              Center(
                child: Image.asset(
                  Get.isDarkMode ? Images.largeLogoDark : Images.largeLogo,
                  width: SizeConfig.screenWidth! / 2,
                ),
              ),
              kHeightBox20,
              Text(
                'Login with password'.tr,
                style: kRegularText2.copyWith(
                  fontWeight: FontWeight.w300,
                  color: Get.isDarkMode
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF303030),
                ),
              ),
              const SizedBox(
                height: 86,
              ),
              CustomTextField(
                labelText: 'Email / Phone No'.tr,
                controller: userNameController,
                // focusNode: phoneController,
                // nextFocus: _passwordFocus,
                inputType: TextInputType.emailAddress,
                divider: true,
              ),
              kHeightBox15,
              CustomTextField(
                labelText: 'Password'.tr,
                controller: passController,
                // focusNode: phoneController,
                // nextFocus: _passwordFocus,
                isPassword: true,
                inputType: TextInputType.emailAddress,
                divider: true,
              ),
              kHeightBox40,
              DefaultBtn(
                width: SizeConfig.screenWidth,
                radius: 10.0,
                title: 'Login'.tr,
                onPress: () {
                  if (userNameController.text.isEmpty) {
                    showCustomSnackBar('Please enter your user name or email!');
                  } else if (passController.text.isEmpty) {
                    showCustomSnackBar('Please enter your password!');
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const CustomLoader());

                    ///Email login
                    emailLogin(userNameController, passController, context);
                  }
                },
              ),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () => Get.to(
                  () => const ForgotScreen(),
                ),
                child: Text(
                  'Forgot your Password?'.tr,
                  style: kRegularText2.copyWith(
                    color: Get.isDarkMode
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF303030),
                  ),
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Don’t have an account?'.tr,
                        style: kRegularText2.copyWith(
                            color: const Color(0xFF808080)),
                      ),
                      TextSpan(
                        text: 'Sign Up'.tr,
                        style: kAppBarText.copyWith(
                            fontWeight: FontWeight.w600, color: kPrimaryColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.to(
                                () => const SignUpScreen(),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              kHeightBox8,
              Text(
                'Or'.tr,
                style: kRegularText2.copyWith(
                  color: theme.isNotEmpty
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF303030),
                ),
              ),
              /*kHeightBox8,
              SocialButton(
                width: 300,
                imageURL: Images.apple,
                btnColor: Colors.black,
                border: 0.0,
                radius: 25.0,
                title: 'Continue with Apple'.tr,
                textColor: Colors.white,
                onPress: () {
                  ///apple login request
                },
              ),*/
              kHeightBox8,
              SocialButton(
                width: 300,
                imageURL: Images.google,
                btnColor: const Color(0xFFDC3C2A),
                radius: 25.0,
                title: 'Continue with Google'.tr,
                textColor: Colors.white,
                onPress: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const CustomLoader());
                  ///google login request
                  Get.find<AuthController>().handleGoogleSignIn(
                    context,
                  );
                },
              ),
              kHeightBox8,
              SocialButton(
                width: 300,
                imageURL: Images.facebook,
                btnColor: const Color(0xFF3A559F),
                radius: 25.0,
                title: 'Continue with Facebook'.tr,
                textColor: Colors.white,
                onPress: () {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const CustomLoader());
                  ///facebook login requrst
                  Get.find<AuthController>().facebookLogin(
                    context,
                  );
                },
              ),
              kHeightBox20,
            ],
          ),
        ),
      ),
    );
  }

  void emailLogin(TextEditingController userNameController,
      TextEditingController passController, BuildContext context) {
    LoginBody body = LoginBody(
        username: userNameController.text, password: passController.text);

    Get.find<AuthController>().emailLogin(body, context, passController.text);
  }
}
