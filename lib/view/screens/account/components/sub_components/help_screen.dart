import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:woogoods/constants/strings.dart';

import 'policies_screen.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = 'help_screen';
  const HelpScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Help'.tr),),
    body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    var data = const PoliciesScreen();
    return data.buildPolicies(context, kPrivacyPolices);
  }
}
