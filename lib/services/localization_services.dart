import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/language/ar_ae.dart';
import 'package:woogoods/language/bn_bd.dart';
import 'package:woogoods/language/en_us.dart';
import 'package:woogoods/language/es_es.dart';
import 'package:woogoods/language/fr_fr.dart';
import 'package:woogoods/language/ja_jp.dart';
import 'package:woogoods/language/jh_cn.dart';

class LocalizationService extends Translations {
  /// flag start here ///
  static const String bdFlag = kImageDir + 'bangladesh.png';
  static const String usaFlag = kImageDir + 'us.png';
  static const String arabFlag = kImageDir + 'arab.png';
  static const String japanFlag = kImageDir + 'japan.png';
  static const String chinaFlag = kImageDir + 'china.png';
  static const String spainFlag = kImageDir + 'spain.png';
  static const String franceFlag = kImageDir + 'france.png';

  /// flag start end here ///
  // Default locale
  static const locale = Locale('en', 'US');

  // fallbackLocale saves the day when the locale gets in trouble
  static const fallbackLocale = Locale('en', 'US');

  // Supported languages
  // Needs to be same order with locales
  static final List<Map> langs = [
    {
      'name': 'English',
      'flag': usaFlag,
    },
    {
      'name': 'Bangla',
      'flag': bdFlag,
    },
    {
      'name': 'Arabic',
      'flag': arabFlag,
    },
    {
      'name': 'Spanish',
      'flag': spainFlag,
    },
    {
      'name': 'Franch',
      'flag': franceFlag,
    },
    {
      'name': 'China',
      'flag': chinaFlag,
    },
    {
      'name': 'Japan',
      'flag': japanFlag,
    },
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    const Locale('en', 'US'),
    const Locale('bn', 'BD'),
    const Locale('ar', 'AE'),
    const Locale('es', 'ES'),
    const Locale('fr', 'FR'),
    const Locale('zh', 'CN'),
    const Locale('ja', 'JP'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': enUS, // language/en_us.dart
        'bn_BD': bnBD, // language/bn_bd.dart
        'ar_AE': arAE, // language/ar_ae.dart
        'es_ES': esES, // language/es_es.dart
        'fr_FR': frFR, // language/fr_fr.dart
        'zh_CN': zhCN, // language/jh_cn.dart
        'ja_JP': jaJP, // language/ja_jp.dart
      };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = getLocaleFromLanguage(lang)!;

    final box = GetStorage();
    box.write('lng', lang);

    Get.updateLocale(locale);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? getLocaleFromLanguage(String? lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]['name']) return locales[i];
    }
    return Get.locale;
  }

  Locale? getCurrentLocale() {
    final box = GetStorage();
    Locale? defaultLocale;

    if (box.read('lng') != null) {
      final locale =
          LocalizationService().getLocaleFromLanguage(box.read('lng'));

      defaultLocale = locale;
    } else {
      defaultLocale = const Locale(
        'en',
        'US',
      );
    }

    return defaultLocale;
  }

  String? getCurrentLang() {
    final box = GetStorage();

    return box.read('lng') ?? 'English';
  }
}
