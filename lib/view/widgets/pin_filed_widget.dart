import 'dart:developer';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/constants/size_config.dart';

class PintFiledWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? fieldController;
  final IconData? icon;
  final int? maxLines;
  final String? preText;
  final Color? fillColor;
  final bool? isProtected;
  final bool? isEditable;
  final bool? centerText;
  final FocusNode? focusNode;
  final TextInputType? keyType;
  final Function? validation;
  const PintFiledWidget({
    Key? key,
    this.preText,
    this.isEditable,
    this.maxLines,
    this.centerText = false,
    this.focusNode,
    this.labelText,
    this.fillColor,
    this.isProtected = false,
    this.hintText,
    this.icon = Icons.cancel,
    this.fieldController,
    this.keyType,
    this.validation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: getProportionateScreenHeight(50),
          fieldWidth: getProportionateScreenWidth(40),
          activeFillColor: Colors.white,
          activeColor: kPrimaryColor,
          inactiveColor: const Color(0xFFC4C4C4),
          inactiveFillColor: const Color(0xFFC4C4C4),
          selectedColor: kSecondaryColor,
          selectedFillColor: const Color(0xFFC4C4C4)),
      animationDuration: const Duration(milliseconds: 300),
      //backgroundColor: Colors.blue.shade50,
      enableActiveFill: true,
      controller: fieldController,
      onCompleted: (v) {
        log("Completed");
      },
      onChanged: (value) {
        log(value);
      },
      beforeTextPaste: (text) {
        log("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      },
      appContext: context,
    );
  }
}
