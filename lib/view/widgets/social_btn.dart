import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woogoods/constants/colors_data.dart';

class SocialButton extends StatelessWidget {
  final String title;
  final Function? onPress;
  final bool isChange;
  final double radius;
  final double border;
  final Color borderColor;
  final Color textColor;
  final Color btnColor;
  final double? width;
  final double? height;
  final String? imageURL;

  const SocialButton({
    Key? key,
    required this.title,
    this.width,
    this.height = 40,
    this.textColor = Colors.white,
    this.btnColor = kPrimaryColor,
    this.borderColor = kWhiteColor,
    this.border = 0,
    this.onPress,
    this.isChange = false,
    this.radius = 30,
    this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: TextButton(
        child: Row(
          children: [
            const Expanded(child: SizedBox()),
            Expanded(
              child: SvgPicture.asset(
                imageURL!,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      color: textColor,
                    ),
              ),
            ),
          ],
        ),
        onPressed: onPress as void Function()?,
      ),
    );
  }
}
