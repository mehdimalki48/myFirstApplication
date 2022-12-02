import 'package:woogoods/constants/colors_data.dart';
import 'package:flutter/material.dart';
import 'package:woogoods/constants/size_config.dart';

class InputFormWidgetNullIcon extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? fieldController;
  final Function? onSaved;
  final Function? validation;
  final IconData? icon;
  final int? maxLines;
  final String? preText;
  final Color? fillColor;
  final double? elevation;
  final Color? shadowColor;
  final bool isProtected;
  final bool? isEditable;
  final bool centerText;
  final FocusNode? focusNode;
  final TextInputType? keyType;
  const InputFormWidgetNullIcon({
    Key? key,
    this.preText,
    this.isEditable,
    this.maxLines,
    this.shadowColor,
    this.elevation,
    this.centerText = false,
    this.validation,
    this.focusNode,
    this.labelText,
    this.fillColor,
    this.isProtected = false,
    this.hintText,
    this.icon,
    this.fieldController,
    this.keyType,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        height: getProportionateScreenWidth(38.0),
        child: TextFormField(
          maxLines: maxLines ?? 1,
          enabled: isEditable,
          validator: validation as String? Function(String?)?,
          controller: fieldController,
          keyboardType: keyType,
          obscureText: isProtected,
          obscuringCharacter: '*',
          onChanged: onSaved as void Function(String)?,
          focusNode: focusNode,
          textAlign: centerText == true ? TextAlign.center : TextAlign.start,
          autofocus: false,
          cursorColor: kStUnderLineColor,
          decoration: InputDecoration(
            errorStyle: const TextStyle(fontSize: 11, height: 0.3),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              borderSide: BorderSide(
                color: kPrimaryColor,
                width: .3
              ),
            ),

            prefixText: preText,
            prefixStyle: const TextStyle(
              fontSize: 16,
            ),
            suffixIcon: Icon(
              icon,
              color: kBlackColor2,
            ),
            // labelStyle: kSmallText.copyWith(color: kOrdinaryColor),
            // floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.headline2!.copyWith(color: kStUnderLineColor),
            // filled: fillColor == null ? false : true,
            // fillColor: fillColor ?? Colors.transparent,

            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            // hintStyle: kDescriptionText.copyWith(color: kWhiteColor),
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  const BorderSide(color: kStUnderLineColor, width: .3),
              gapPadding: 3,
            ),
          ),
        ),
      ),
    );
  }
}
