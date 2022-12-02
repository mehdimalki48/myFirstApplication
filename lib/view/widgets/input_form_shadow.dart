import 'package:flutter/material.dart';
class InputFormShadow extends StatelessWidget {
  final String? hintText;
  final TextEditingController? fieldController;
  final TextInputType? keyType;

  const InputFormShadow({
    Key? key,
    this.hintText,
    this.fieldController,
    this.keyType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.centerLeft,
        margin:
        const EdgeInsets.only(right: 16, left: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF000000)
                  .withOpacity(.10),
              blurRadius: 4,
              spreadRadius: 0,
              offset: const Offset(1, -4),
            ),
          ],
        ),
        padding: const EdgeInsets.only(right: 15),
        child: TextFormField(
          controller: fieldController,
          textAlign: TextAlign.start,
          keyboardType: keyType,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                color: Theme.of(context).hintColor, height: 0.50),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
