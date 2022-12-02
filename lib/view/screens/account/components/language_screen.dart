import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:woogoods/services/localization_services.dart';

class LanguageScreen extends StatefulWidget {
  static const routeName = 'language_screen';
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? currentLng = LocalizationService().getCurrentLang();
  late int selectedLang;

  @override
  void initState() {
    selectedLang = LocalizationService.langs
        .indexWhere((element) => currentLng == element['name']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Language'.tr,
        ),
      ),
      body: ListView.builder(
        itemCount: LocalizationService.langs.length,
        itemBuilder: (context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: kOrdinaryColor.withOpacity(.15),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: RadioListTile(
              activeColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LocalizationService.langs[index]['name'],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      LocalizationService.langs[index]['flag'],
                      width: 50,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              value: index,
              groupValue: selectedLang,
              onChanged: (value) {
                LocalizationService()
                    .changeLocale(LocalizationService.langs[index]['name']);
                setState(() {
                  selectedLang = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
