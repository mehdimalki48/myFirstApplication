import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/main.dart';

class ThemeController extends GetxController implements GetxService {
  ThemeController() {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  void toggleTheme() {
    _darkTheme = !_darkTheme;
    prefs.setBool(theme, _darkTheme);
    update();
  }

  void _loadCurrentTheme() async {
    var brightness = WidgetsBinding.instance.window.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    log('is Dark ${Get.isDarkMode} ${ThemeData.dark()} mode $isDarkMode');
    _darkTheme = prefs.getBool(theme) ?? isDarkMode ? true : false;
    log(_darkTheme.toString());
    update();
  }

  void updateTheme(bool isDark) {
    _darkTheme = isDark;
    prefs.setBool(theme, isDark);
    update();
  }
}
