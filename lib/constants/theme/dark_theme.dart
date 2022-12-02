import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:woogoods/constants/colors_data.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: kWhiteColor,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    backgroundColor: kCardDarkColor,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: kWhiteColor,
    ),
    actionsIconTheme: IconThemeData(
      color: kBlackColor2,
    ),
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: kCardDarkColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: kWhiteColor,
      systemNavigationBarDividerColor: kWhiteColor,
    ),
  ),
  primaryColor: kPrimaryColor,
  secondaryHeaderColor: kSecondaryColor,
  disabledColor: const Color(0xffa2a7ad),
  backgroundColor: kBgDarkColor,
  scaffoldBackgroundColor: kBgDarkColor,
  errorColor: const Color(0xFFdd3135),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: kCardDarkColor,
  colorScheme: const ColorScheme.dark(
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
        color: kWhiteColor,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.25,
        fontStyle: FontStyle.normal,
      ),
      headline2: TextStyle(
        color: kWhiteColor,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.25,
        fontStyle: FontStyle.normal,
      )),
);
