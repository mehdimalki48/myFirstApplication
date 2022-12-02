
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../constants/strings.dart';
import '../../widgets/custom_shimmer.dart';


class SupportRoomScreen extends StatelessWidget {
  static const routeName = 'support_room_screen';

  final String name, email;

  const SupportRoomScreen({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Support'.tr),
      ),
      body: Tawk(
        directChatLink: tawkMsgKey,
        visitor: TawkVisitor(
          name: name,
          email: email,
        ),
        onLoad: () {
          log('Hello Tawk!');
        },
        onLinkTap: (String url) {
          log(url);
        },
        placeholder:  chartScreenShimmer(),
      ),
    );
  }
}
