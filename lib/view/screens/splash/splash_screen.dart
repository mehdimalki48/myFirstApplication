import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:woogoods/constants/images.dart';
import 'package:woogoods/constants/size_config.dart';
import 'package:woogoods/view/screens/dashboard/dashboard_screen.dart';
import 'package:woogoods/view/screens/intro/intro_pages.dart';
import '../../../main.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    SharedPreferences.getInstance().then((pr) {
      prefs = pr;
      intro = pr;
    });
    // _getCurrentLocation();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.forward();
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );
    _animation.addListener(() => setState(() {}));
    _animationController.forward();
    Timer(const Duration(seconds: 3), () {
      navigation();
    });
    super.initState();
  }

  void navigation() async {
    if (intro.containsKey('intro')) {
      Get.offAll(() => const DashBoardScreen());
    } else {
      Get.offAll(() => const IntroPages());
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _animation as Animation<double>,
          child: Hero(
            tag: 'large_logo',
            child: Image.asset(
              Get.isDarkMode ? Images.largeLogoDark : Images.largeLogo,
              width: _animation.value * getProportionateScreenWidth(200),
              height: _animation.value * getProportionateScreenWidth(200),
            ),
          ),
        ),
      ),
    );
  }
}
