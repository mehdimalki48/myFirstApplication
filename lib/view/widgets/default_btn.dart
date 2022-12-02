import 'package:flutter/material.dart';
import 'package:woogoods/constants/colors_data.dart';

class DefaultBtn extends StatelessWidget {
  final String title;
  final Function? onPress;
  final bool isChange;
  final double radius;
  final double border;
  final Color borderColor;
  final Color textColor;
  final Color btnColor;
  final Color btnColor2;
  final double? width;
  final double height;
  const DefaultBtn({
    Key? key,
    required this.title,
    this.width,
    this.height = 40,
    this.textColor = Colors.white,
    this.btnColor = kSecondaryColor,
    this.btnColor2 = kPrimaryColor,
    this.borderColor = kWhiteColor,
    this.border = 0,
    this.onPress,
    this.isChange = false,
    this.radius = 30,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: const [0.1, 0.9],
          colors: [
            btnColor,
            btnColor2,
          ],
        ),
        border: Border.all(
          width: border,
          color: border == 0 ? Colors.transparent : borderColor,
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: TextButton(
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headline1!.copyWith(
                color: textColor,
                fontSize: 16,
              ),
        ),
        onPressed: onPress as void Function()?,
      ),
    );
  }
}
