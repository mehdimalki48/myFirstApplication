import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:woogoods/constants/strings.dart';
import 'constants/theme/dark_theme.dart';
import 'constants/theme/light_theme.dart';
import 'controllers/theme_controller.dart';
import 'services/api/app_config.dart';
import 'helper/get_di.dart';
import 'services/localization_services.dart';
import 'view/screens/splash/splash_screen.dart';

late SharedPreferences prefs;
late SharedPreferences intro;

Future<void> main() async {
  //init flutter binding
  WidgetsFlutterBinding.ensureInitialized();
  //Stripe.publishableKey = kPublishableKey;
  //Stripe.merchantIdentifier = "App Identifier";
  //await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  //init get storage
  await GetStorage.init();
  //Single ton
  await init();
  //Init my app ,,,
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            },
          ),
          theme: themeController.darkTheme ? dark : light,
          translations: LocalizationService(), // your translations
          locale: LocalizationService()
              .getCurrentLocale(), // translations will be displayed in that locale
          fallbackLocale: const Locale(
            'en',
            'US',
          ),
          home: const SplashScreen(),
          defaultTransition: Transition.rightToLeft,
          transitionDuration: const Duration(
            milliseconds: 200,
          ), // default: 300
        );
      },
    );
  }
}
