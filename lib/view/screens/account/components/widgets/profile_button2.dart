import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/style_data.dart';

class ProfileButton2 extends StatelessWidget {
  final IconData? icon;
  final String title;
  final bool isButtonActive;
  final bool isSwitchActive;
  final Function onTap;
  final Color? bgColor;
  final double? width;
  final double? height;
  final double radius;
  final double elevation;

  const ProfileButton2(
      {Key? key,
      this.icon,
      required this.title,
      required this.onTap,
        this.isButtonActive = false,
      this.isSwitchActive = true,
      this.bgColor,
      this.width,
      this.height,
      this.radius = 0,
      this.elevation = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as void Function()?,
      child: Card(
        color: bgColor,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        elevation: elevation,
        child: Container(
          width: width,
          height: height,
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(children: [
            SizedBox(
                child: icon == null
                    ? const SizedBox.shrink()
                    : SizedBox(
                        width: 20, height: 20, child: Icon(icon, size: 25))),
            SizedBox(
              child: icon == null ? const SizedBox.shrink() : kWidthBox20,
            ),
            Expanded(
                child: Text(title,
                    style: kRegularText2.copyWith(
                        color: Get.isDarkMode
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF303030)))),
            Container(
              child: isSwitchActive
                  ? Switch(
                      value: isButtonActive,
                      onChanged: (bool isActive) => onTap(),
                      activeColor: Theme.of(context).primaryColor,
                      activeTrackColor:
                          Theme.of(context).primaryColor.withOpacity(0.5),
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 18.0,
                        color: Color(0xFF707070),
                      ),
                    ),
            ),
          ]),
        ),
      ),
    );
  }
}
