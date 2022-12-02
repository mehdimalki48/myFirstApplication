import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../../constants/images.dart';
import '../../../../../constants/size_config.dart';
import '../../../../../constants/strings.dart';
import '../../../../../constants/style_data.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/default_btn.dart';

class CustomerSupportScreen extends StatelessWidget {
  const CustomerSupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final nameController = TextEditingController();
    final messageController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Service'.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  Images.contactUS,
                  height: SizeConfig.screenWidth! / 2,
                  width: SizeConfig.screenWidth!,
                ),
              ),
              kHeightBox20,
              CustomTextField(
                labelText: 'Email'.tr,
                controller: emailController,
                // focusNode: phoneController,
                // nextFocus: _passwordFocus,
                inputType: TextInputType.emailAddress,
                divider: true,
              ),
              kHeightBox15,
              CustomTextField(
                labelText: 'Full Name'.tr,
                controller: nameController,
                // focusNode: phoneController,
                // nextFocus: _passwordFocus,
                inputType: TextInputType.name,
                divider: true,
              ),
              kHeightBox15,
              CustomTextField(
                labelText: 'Message'.tr,
                controller: messageController,
                // focusNode: phoneController,
                // nextFocus: _passwordFocus,
                inputType: TextInputType.name,
                maxLines: 3,
                divider: true,
              ),
              kHeightBox40,
              DefaultBtn(
                width: SizeConfig.screenWidth,
                radius: 10.0,
                title: 'Send Email'.tr,
                onPress: () async {
                  if (emailController.text.isEmpty) {
                    showCustomSnackBar(
                      'Please enter email'.tr,
                    );
                  } else if (nameController.text.isEmpty) {
                    showCustomSnackBar(
                      'Please enter name'.tr,
                    );
                  } else if (messageController.text.isEmpty) {
                    showCustomSnackBar(
                      'Please enter support message'.tr,
                    );
                  } else {
                    final String _email =
                        'mailto:${emailController.text}?subject=Support for App&body=Hi, i\'m${nameController.text}.\n${messageController.text}';

                    await launchUrlString(_email);
                  }
                },
              ),
              kHeightBox40,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      await launchUrlString(supportWebsite);
                    },
                    child: SvgPicture.asset(
                      Images.world,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  kWidthBox20,
                  InkWell(
                    onTap: () async {
                      var messengerUrl = supportFacebook;
                      await canLaunchUrlString(messengerUrl)
                          ? launchUrlString(messengerUrl)
                          : showCustomSnackBar(
                              'Please install facebook',
                            );
                    },
                    child: SvgPicture.asset(
                      Images.facebook,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  kWidthBox20,
                  InkWell(
                    onTap: () async {
                      var messengerUrl = supportMessenger;
                      await canLaunchUrlString(messengerUrl)
                          ? await launchUrlString(messengerUrl)
                          : showCustomSnackBar(
                              'Please install messenger',
                            );
                    },
                    child: SvgPicture.asset(
                      Images.messenger,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  kWidthBox20,
                  InkWell(
                    onTap: () async {
                      await launchUrlString('tel:$supportPhoneNumber');
                    },
                    child: SvgPicture.asset(
                      Images.call,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  kWidthBox20,
                  InkWell(
                    onTap: () async {
                      await launchUrlString('https://wa.me/$supportWhatsappNumber');
                    },
                    child: SizedBox(
                      child: SvgPicture.asset(
                        Images.whatsapp,
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                ],
              ),
              kHeightBox40,
            ],
          ),
        ),
      ),
    );
  }
}
