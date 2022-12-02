import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors_data.dart';

ThemeData light = ThemeData(
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: kBlackColor2,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    color: kWhiteColor,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: kBlackColor2,
    ),
    actionsIconTheme: IconThemeData(
      color: kBlackColor2,
    ),
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: kWhiteColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: kBlackColor2,
      systemNavigationBarDividerColor: kBlackColor2,
    ),
  ),
  fontFamily: 'Roboto',
  primaryColor: kPrimaryColor,
  secondaryHeaderColor: kSecondaryColor,
  disabledColor: const Color(0xFFBABFC4),
  backgroundColor: kBgColor,
  scaffoldBackgroundColor: kBgColor,
  errorColor: const Color(0xFFE84D4F),
  brightness: Brightness.light,
  hintColor: const Color(0xFF808080),
  cardColor: kWhiteColor,
  colorScheme: const ColorScheme.light(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: kPrimaryColor,
    ),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
      color: kBlackColor2,
      fontSize: 15,
      fontWeight: FontWeight.w500,
      height: 1.25,
      fontStyle: FontStyle.normal,
    ),
    headline2: TextStyle(
      color: kBlackColor2,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.25,
      fontStyle: FontStyle.normal,
    ),
  ),
);
