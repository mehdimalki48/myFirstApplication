import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/controllers/auth_controller.dart';
import 'package:woogoods/view/widgets/custom_text_field.dart';
import 'package:woogoods/view/widgets/default_btn.dart';
import 'package:woogoods/view/widgets/input_form_widget.dart';

import 'change_password_screen.dart';
import 'widgets/account_info_widgets.dart';
import 'widgets/gender_widgets.dart';

class AccountInfoScreen extends StatefulWidget {
  static const routeName = 'account_information_screen';

  const AccountInfoScreen({Key? key}) : super(key: key);

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final firstNameController = TextEditingController();

  DateTime selectedBirthDayDate = DateTime.now();

  DateTime selectedLastDay = DateTime.now();

  final _dateBirthDay = TextEditingController();

  Future<void> _selectBirthDayDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: kPrimaryColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Get.isDarkMode ? kWhiteColor : kBlackColor2,
              // body text color
            ),
            dialogBackgroundColor: Get.isDarkMode ? kBlackColor2 : kWhiteColor,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: kPrimaryColor, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: selectedBirthDayDate,
      firstDate: DateTime(1901, 1),
      lastDate: DateTime(2500),
    );

    if (picked != selectedBirthDayDate) {
      setState(() {
        selectedBirthDayDate = picked!;

        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        String string = dateFormat.format(selectedBirthDayDate);
        _dateBirthDay.value = TextEditingValue(text: string);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account Information'.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: GetBuilder<AuthController>(builder: (authController){
            return Column(
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
                      AccountInfoWidgets(
                          title: 'Name'.tr,
                          subTitle: authController.getUserName().isNotEmpty ? authController.getUserName() : null,
                          onTap: () {
                            addNameSheet(context);
                          }),
                      AccountInfoWidgets(
                          title: 'Change Password'.tr,
                          subTitle: ' ',
                          onTap: () => Get.to(() => const ChangePassScreen(),)),
                    /*  AccountInfoWidgets(
                          title: 'Change Number'.tr,
                          onTap: () {
                            // addPhoneSheet(context);
                          }),*/
                      AccountInfoWidgets(
                          title: 'Email'.tr,
                          subTitle: authController.getUserEmail().isNotEmpty ? authController.getUserEmail() : null,
                          onTap: () {
                           // addEmailSheet(context);
                          }),
                      AccountInfoWidgets(
                          title: 'Gender'.tr,
                          onTap: () {
                            addGenderSheet(context);
                          }),
                      AccountInfoWidgets(
                          title: 'Birthday'.tr,
                          divide: false,
                          onTap: () {
                            _selectBirthDayDate(context);
                          }),
                    ],
                  ),
                ),
                kHeightBox40,
              ],
            );
          },),
        ),
      ),
    );
  }

  Future addNameSheet(BuildContext context) {
    return Get.bottomSheet(
      Container(
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Name'.tr,
                          style:
                              kBoldStyle.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.topRight,
                          height: 12,
                          width: 12,
                          margin: const EdgeInsets.only(top: 15),
                          child: SvgPicture.asset(
                            Images.close,
                            width: 20,
                            height: 20,
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                kHeightBox15,
                CustomTextField(
                  labelText: 'First Name'.tr,
                  controller: firstNameController,
                  // focusNode: phoneController,
                  // nextFocus: _passwordFocus,
                  inputType: TextInputType.text,
                  divider: true,
                ),
                kHeightBox15,
                CustomTextField(
                  labelText: 'Last Name'.tr,
                  controller: firstNameController,
                  // focusNode: phoneController,
                  // nextFocus: _passwordFocus,
                  inputType: TextInputType.text,
                  divider: true,
                ),
                kHeightBox20,
                DefaultBtn(
                  width: SizeConfig.screenWidth,
                  radius: 10.0,
                  title: 'Save'.tr,
                  onPress: () {},
                ),
                kHeightBox10,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addEmailSheet(BuildContext context) {
    return Get.bottomSheet(
      Container(
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Email Address'.tr,
                          style:
                              kBoldStyle.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.topRight,
                          height: 12,
                          width: 12,
                          margin: const EdgeInsets.only(top: 15),
                          child: SvgPicture.asset(
                            Images.close,
                            width: 20,
                            height: 20,
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                kHeightBox15,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Email Address'.tr,
                        controller: firstNameController,
                        // focusNode: phoneController,
                        // nextFocus: _passwordFocus,
                        inputType: TextInputType.text,
                        divider: true,
                      ),
                    ),
                    kWidthBox10,
                    DefaultBtn(
                      height: 40,
                      radius: 5.0,
                      title: 'Send'.tr,
                      btnColor: Theme.of(context).backgroundColor,
                      btnColor2: Theme.of(context).backgroundColor,
                      borderColor: Theme.of(context).hintColor,
                      textColor: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                      onPress: () {},
                    ),
                    kWidthBox10,
                  ],
                ),
                kHeightBox15,
                Text(
                  'Verification Code'.tr,
                  style: kRegularText2.copyWith(
                    color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                  ),
                ),
                kHeightBox10,
                SizedBox(
                  width: SizeConfig.screenWidth,
                  height: 55,
                  child: Row(
                    children: [
                      Expanded(
                        child: InputFormWidget(
                          //  fieldController: nameController,
                          hintText: 'Enter the code you received'.tr,
                          height: 40,
                          maxLines: 1,
                        ),
                      ),
                      kWidthBox10,
                      /*DefaultBtn(
                        height: 40,
                        radius: 5.0,
                        title: 'APPLY'.tr,
                        btnColor: Theme.of(context).backgroundColor,
                        btnColor2: Theme.of(context).backgroundColor,
                        borderColor: Theme.of(context).hintColor,
                        textColor: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                        onPress: () {},
                      ),
                      kWidthBox10,*/
                    ],
                  ),
                ),
                kHeightBox15,
                DefaultBtn(
                  width: SizeConfig.screenWidth,
                  radius: 10.0,
                  title: 'Save'.tr,
                  onPress: () {},
                ),
                kHeightBox10,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addPhoneSheet(BuildContext context) {
    return Get.bottomSheet(
      Container(
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Change Number'.tr,
                          style:
                              kBoldStyle.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.topRight,
                          height: 12,
                          width: 12,
                          margin: const EdgeInsets.only(top: 15),
                          child: SvgPicture.asset(
                            Images.close,
                            width: 20,
                            height: 20,
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                kHeightBox15,
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        labelText: 'Number'.tr,
                        controller: firstNameController,
                        // focusNode: phoneController,
                        // nextFocus: _passwordFocus,
                        inputType: TextInputType.text,
                        divider: true,
                      ),
                    ),
                    kWidthBox10,
                    DefaultBtn(
                      height: 40,
                      radius: 5.0,
                      title: 'Send'.tr,
                      btnColor: Theme.of(context).backgroundColor,
                      btnColor2: Theme.of(context).backgroundColor,
                      borderColor: Theme.of(context).hintColor,
                      textColor: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                      onPress: () {},
                    ),
                    kWidthBox10,
                  ],
                ),
                kHeightBox15,
                Text(
                  'Verification Code'.tr,
                  style: kRegularText2.copyWith(
                    color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                  ),
                ),
                kHeightBox10,
                SizedBox(
                  width: SizeConfig.screenWidth,
                  height: 55,
                  child: Row(
                    children: [
                      Expanded(
                        child: InputFormWidget(
                          //  fieldController: nameController,
                          hintText: 'Enter the code you received'.tr,
                          height: 40,
                          maxLines: 1,
                        ),
                      ),
                      kWidthBox10,
                      /*DefaultBtn(
                        height: 40,
                        radius: 5.0,
                        title: 'APPLY'.tr,
                        btnColor: Theme.of(context).backgroundColor,
                        btnColor2: Theme.of(context).backgroundColor,
                        borderColor: Theme.of(context).hintColor,
                        textColor: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                        onPress: () {},
                      ),
                      kWidthBox10,*/
                    ],
                  ),
                ),
                kHeightBox15,
                DefaultBtn(
                  width: SizeConfig.screenWidth,
                  radius: 10.0,
                  title: 'Save'.tr,
                  onPress: () {},
                ),
                kHeightBox10,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future addGenderSheet(BuildContext context) {
    return Get.bottomSheet(
      Container(
        color: Theme.of(context).cardColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Gender'.tr,
                          style:
                              kBoldStyle.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.topRight,
                          height: 12,
                          width: 12,
                          margin: const EdgeInsets.only(top: 15),
                          child: SvgPicture.asset(
                            Images.close,
                            width: 20,
                            height: 20,
                            color: Get.isDarkMode ? kWhiteColor : kBlackColor2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                kHeightBox15,
                GendersWidgets(
                    title: 'Male'.tr,
                    selected: true,
                    onTap: () {
                      // addNameSheet(context);
                    }),
                GendersWidgets(
                    title: 'Female'.tr,
                    onTap: () {
                      // addNameSheet(context);
                    }),
                GendersWidgets(
                    title: 'Others'.tr,
                    onTap: () {
                      // addNameSheet(context);
                    }),
                kHeightBox10,
                DefaultBtn(
                  width: SizeConfig.screenWidth,
                  radius: 10.0,
                  title: 'Save'.tr,
                  onPress: () {},
                ),
                kHeightBox10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
