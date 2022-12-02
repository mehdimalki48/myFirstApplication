import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:flutter/material.dart';
import 'package:woogoods/constants/style_data.dart';

class InputFormWidget extends StatelessWidget {
  ///Image picker
  final ImagePicker picker = ImagePicker();
  late final File? thumbnailImage;
  late final String? thumbnailBase64;

  ///input form
  final String? hintText;
  final TextEditingController? fieldController;
  final Function? onSaved;
  final Function? onConfirm;
  final Function? validation;
  //is country
  final Function? onCountryChange;
  final String? selectionCountryCode;
  final IconData? icon;
  final IconData? prefixIcon;
  final int? maxLines;
  final String? preText;
  final Color? fillColor;
  final double? elevation;
  final double borderWidth;
  final Color? shadowColor;
  final Color borderColor;
  final bool isProtected;
  final bool? isEditable;
  //is country
  final bool isCountry;
  final bool centerText;
  final bool autoFocus;
  final FocusNode? focusNode;
  final TextInputType? keyType;
  final double? height;
  final double radius;
  final bool absorbing;

  InputFormWidget({
    Key? key,
    this.preText,
    this.prefixIcon,
    this.isEditable,
    this.maxLines,
    this.shadowColor,
    this.elevation,
    this.centerText = false,
    this.validation,
    this.focusNode,
    this.autoFocus = false,
    this.fillColor,
    this.isProtected = false,
    this.isCountry = false,
    this.hintText,
    this.icon,
    this.fieldController,
    this.selectionCountryCode,
    this.keyType,
    this.onSaved,
    this.onCountryChange,
    this.onConfirm,
    this.height,
    this.borderColor = kStUnderLineColor,
    this.radius = 5,
    this.borderWidth = .3,
    this.absorbing = false,
    this.thumbnailImage,
    this.thumbnailBase64,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: SizeConfig.screenWidth,
        // padding: const EdgeInsets.symmetric(vertical: 10),
        height: maxLines == null ? getProportionateScreenHeight(38.0) : height,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Row(
          children: [
            SizedBox(
              child: isCountry
                  ? Row(
                      children: [
                        CountryCodePicker(
                          padding: EdgeInsets.zero,
                          onChanged:
                              onCountryChange as void Function(CountryCode)?,
                          dialogBackgroundColor:
                              Get.isDarkMode ? kBlackColor2 : kWhiteColor,
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: selectionCountryCode ?? 'IT',
                          showFlagDialog: true,
                          flagWidth: 24,
                          textStyle: Theme.of(context).textTheme.headline2,
                          comparator: (a, b) => b.name!.compareTo(a.name ?? ""),
                          //Get the country information relevant to the initial selection
                          onInit: (code) => log(
                              "on init ${code!.name} ${code.dialCode} ${code.name}"),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          width: .3,
                          height: maxLines == null
                              ? getProportionateScreenWidth(38.0)
                              : height,
                          color: kStUnderLineColor,
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
            Expanded(
              child: AbsorbPointer(
                absorbing: absorbing,
                child: TextFormField(
                  maxLines: maxLines ?? 1,
                  enabled: isEditable,
                  validator: validation as String? Function(String?)?,
                  controller: fieldController,
                  keyboardType: keyType,
                  obscureText: isProtected,
                  obscuringCharacter: '*',
                  onChanged: onSaved as void Function(String)?,
                  onFieldSubmitted: onConfirm as void Function(String?)?,
                  focusNode: focusNode,
                  textAlign:
                      centerText == true ? TextAlign.center : TextAlign.start,
                  autofocus: autoFocus,
                  cursorColor: kStUnderLineColor,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(fontSize: 11, height: 0.3),
                    focusedBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    prefixText: preText,
                    prefixStyle: const TextStyle(
                      fontSize: 16,
                    ),
                    prefixIcon: prefixIcon != null
                        ? Icon(
                            prefixIcon,
                            color: const Color(0xFFC4C4C4),
                          )
                        : null,
                    suffixIcon: icon != null
                        ? InkWell(
                            onTap: () {
                              if (icon == Icons.camera_alt_outlined ||
                                  absorbing == false) {
                                uploadImage(context);
                              }
                            },
                            child: Icon(
                              icon,
                              color: const Color(0xFFC4C4C4),
                            ),
                          )
                        : null,
                    // labelStyle: kSmallText.copyWith(color: kOrdinaryColor),
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: hintText,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: kStUnderLineColor, height: 1.0),
                    // filled: fillColor == null ? false : true,
                    // fillColor: fillColor ?? Colors.transparent,

                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    // hintStyle: kDescriptionText.copyWith(color: kWhiteColor),
                    alignLabelWithHint: false,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  uploadImage(BuildContext context) {
    return Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(15.0),
            topLeft: Radius.circular(15.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        : kStUnderLineColor2.withOpacity(.5),
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
            kHeightBox15,
            textRoboto(
              "Scan Image".tr,
              Get.isDarkMode ? kWhiteColor : kBlackColor,
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
                      color: kOrdinaryColor.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.camera_alt,
                        color: Get.isDarkMode ? kWhiteColor : kBlackColor,
                      ),
                    ),
                  ),
                  kWidthBox20,
                  textRoboto(
                      "From Camera", Get.isDarkMode ? kWhiteColor : kBlackColor,
                      fontSize: 18.0, fontWeight: FontWeight.w500),
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
                      color: kOrdinaryColor.withOpacity(0.2),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.perm_media,
                        color: Get.isDarkMode ? kWhiteColor : kBlackColor,
                      ),
                    ),
                  ),
                  kWidthBox20,
                  textRoboto("From Gallery",
                      Get.isDarkMode ? kWhiteColor : kBlackColor,
                      fontSize: 18.0, fontWeight: FontWeight.w500),
                ],
              ),
            ),
            kHeightBox20,
          ],
        ),
      ),
    );
  }

  Future<void> _getThumbnailImage({ImageSource? type}) async {
    final pickedFile = await picker.pickImage(source: type!);

    if (pickedFile != null) {
      thumbnailImage = File(pickedFile.path);
      thumbnailBase64 = base64Encode(thumbnailImage!.readAsBytesSync());
      log(thumbnailImage.toString());
    } else {
      kErrorSnack(
        msg: 'No Image Selected',
      );
    }
  }
}
