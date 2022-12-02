import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/auth_controller.dart';
import 'package:woogoods/models/body/registration.dart';
import 'package:woogoods/view/widgets/custom_loader.dart';
import 'package:woogoods/view/widgets/custom_text_field.dart';
import 'package:woogoods/view/widgets/default_btn.dart';
import 'package:woogoods/view/widgets/pin_filed_widget.dart';
import 'package:woogoods/view/widgets/social_btn.dart';

import 'widgets/icon_text_widget.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'signup_screen';

  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  //Text controller
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passController = TextEditingController();
  final pinController = TextEditingController();
  final phoneController = TextEditingController();
  final countryCodeController = TextEditingController();

  bool email = false, code = false, selectedPhone = true, selectedEmail = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Get.isDarkMode ? const Color(0xFF232323) : const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Form(
            key: _formKey,
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
                  code ? 'Confirm Code' : 'Sign up to join'.tr,
                  style: kRegularText2.copyWith(
                    fontWeight: FontWeight.w300,
                    color: Get.isDarkMode
                        ? const Color(0xFFFFFFFF)
                        : const Color(0xFF303030),
                  ),
                ),
                const SizedBox(
                  height: 21,
                ),
                Container(
                  child: code
                      ? selectedPhone
                          ? IconTextWidget(
                              icon: Images.phone,
                              title: 'Phone No.'.tr,
                              selected: selectedPhone,
                              onTap: () {},
                            )
                          : IconTextWidget(
                              icon: Images.email,
                              title: 'Email'.tr,
                              selected: true,
                              onTap: () {},
                            )
                      : const SizedBox(),
                ),
                Visibility(
                  visible: code ? false : true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconTextWidget(
                          icon: Images.phone,
                          title: 'Phone No.'.tr,
                          selected: selectedPhone,
                          onTap: () {
                            setState(() {
                              email = false;
                              selectedPhone = true;
                              selectedEmail = false;
                            });
                          }),
                      IconTextWidget(
                          icon: Images.email,
                          title: 'Email'.tr,
                          selected: selectedEmail,
                          onTap: () {
                            setState(() {
                              email = true;
                              selectedPhone = false;
                              selectedEmail = true;
                            });
                          }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 47,
                ),
                /*Visibility(
                  visible: code ? false : true,
                  child: Container(
                    child: email
                        ? CustomTextField(
                            labelText: 'Email Address'.tr,
                            controller: emailController,
                            // focusNode: phoneController,
                            // nextFocus: _passwordFocus,
                            inputType: TextInputType.emailAddress,
                            divider: true,
                          )
                        : Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CountryCodePicker(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    onChanged: print,
                                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                    initialSelection: 'IT',

                                    dialogBackgroundColor: Get.isDarkMode
                                        ? kBlackColor2
                                        : kWhiteColor,
                                    showFlagDialog: true,
                                    comparator: (a, b) =>
                                        b.name!.compareTo(a.name ?? ""),
                                    //Get the country information relevant to the initial selection
                                    onInit: (code) => log(
                                        "on init ${code!.name} ${code.dialCode} ${code.name}"),
                                  ),
                                  Expanded(
                                      child: CustomTextField(
                                    labelText: 'Phone No.'.tr,
                                    controller: phoneController,
                                    // focusNode: phoneController,
                                    // nextFocus: _passwordFocus,
                                    inputType: TextInputType.phone,
                                    divider: false,
                                  )),
                                ],
                              ),
                              kHeightBox5,
                              Container(
                                margin: const EdgeInsets.only(left: 0.0),
                                height: .3,
                                color: kStUnderLineColor,
                              ),
                            ],
                          ),
                  ),
                ),*/
                CustomTextField(
                  labelText: 'User Name'.tr,
                  controller: userNameController,
                  // focusNode: phoneController,
                  // nextFocus: _passwordFocus,
                  inputType: TextInputType.text,
                  divider: true,
                ),
                /* Container(
                    child: code
                        ? CustomTextField(
                            absorbing: true,
                            labelText: selectedPhone
                                ? 'Phone No.'.tr
                                : 'Email Address'.tr,
                            controller: userNameController,
                            // focusNode: phoneController,
                            // nextFocus: _passwordFocus,
                            inputType: TextInputType.text,
                            divider: false,
                          )
                        : const SizedBox()),*/
                Container(
                  child: code
                      ? const SizedBox()
                      : Column(
                          children: [
                            kHeightBox15,
                            CustomTextField(
                              labelText: 'Email Address'.tr,
                              controller: emailController,
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
                          ],
                        ),
                ),
                Container(
                  child: code
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              kHeightBox30,
                              PintFiledWidget(
                                labelText: 'Pin'.tr,
                                fieldController: pinController,
                                icon: Icons.visibility,
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter password'.tr;
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ),
                kHeightBox40,
                DefaultBtn(
                  width: SizeConfig.screenWidth,
                  radius: 10.0,
                  title: code ? 'Submit'.tr : 'Sign Up'.tr,
                  onPress: () {
                    if (userNameController.text.isEmpty) {
                      showCustomSnackBar('Please enter your username!');
                    } else if (emailController.text.isEmpty) {
                      showCustomSnackBar('Please enter your email!');
                    } else if (passController.text.isEmpty) {
                      showCustomSnackBar('Please enter your password!');
                    } else {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const CustomLoader());

                      ///Email Register
                      emailRegister(userNameController, emailController,
                          passController, context);
                    }
                  },
                ),
                const SizedBox(
                  height: 80,
                ),
                Visibility(
                  visible: code ? false : true,
                  child: Column(
                    children: [
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Have an account?'.tr,
                                style: kRegularText2.copyWith(
                                    color: const Color(0xFF808080)),
                              ),
                              TextSpan(
                                text: 'Login'.tr,
                                style: kAppBarText.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: kPrimaryColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.back(),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  void emailRegister(
      TextEditingController userNameController,
      TextEditingController emailController,
      TextEditingController passController,
      BuildContext context) {
    log(userNameController.text);
    Registration body = Registration(
        username: userNameController.text,
        email: emailController.text,
        password: passController.text);

    Get.find<AuthController>()
        .emailRegistration(body, context, passController.text);
  }
}
