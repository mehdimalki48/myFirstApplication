import 'package:flutter/material.dart';

import 'components/body.dart';

class IntroPages extends StatelessWidget {
  static const routeName = 'intro_screen';

  const IntroPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}
