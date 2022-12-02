import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:woogoods/constants/colors_data.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool absorbing;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final Function? onChanged;
  final Function? onSubmit;
  final bool isEnabled;
  final int maxLines;
  final TextCapitalization capitalization;
  final String? prefixIcon;
  final bool divider;

  const CustomTextField(
      {Key? key,
      this.hintText = 'Write something...',
      required this.labelText,
      required this.controller,
      this.focusNode,
      this.nextFocus,
      this.isEnabled = true,
      this.absorbing = false,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.maxLines = 1,
      this.onSubmit,
      this.onChanged,
      this.prefixIcon,
      this.capitalization = TextCapitalization.none,
      this.isPassword = false,
      this.divider = false})
      : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AbsorbPointer(
          absorbing: widget.absorbing,
          child: TextField(
            maxLines: widget.maxLines,
            controller: widget.controller,
            focusNode: widget.focusNode,
            // style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
            textInputAction: widget.inputAction,
            keyboardType: widget.inputType,
            textCapitalization: widget.capitalization,
            enabled: widget.isEnabled,
            autofocus: false,
            cursorColor: Theme.of(context).hintColor,
            textAlign: TextAlign.start,
            obscureText: widget.isPassword ? _obscureText : false,
            inputFormatters: widget.inputType == TextInputType.phone
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ]
                : null,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: const BorderSide(style: BorderStyle.none, width: 0),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              labelText: widget.labelText,
              labelStyle: TextStyle(
                color: Theme.of(context).hintColor,
              ),
              /*prefixIcon: widget.prefixIcon != null ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset(widget.prefixIcon!, height: 20, width: 20),
              ) : null,*/
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Theme.of(context).hintColor.withOpacity(0.3),
                        size: 20,
                      ),
                      onPressed: _toggle,
                    )
                  : null,
            ),
            onSubmitted: (text) => widget.nextFocus != null
                ? FocusScope.of(context).requestFocus(widget.nextFocus)
                : widget.onSubmit != null
                    ? widget.onSubmit!(text)
                    : null,
            // onChanged: widget.onChanged,
          ),
        ),
        widget.divider
            ? Container(
                margin: const EdgeInsets.only(top: 5.0),
                height: .3,
                color: kStUnderLineColor,
              )
            : const SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
