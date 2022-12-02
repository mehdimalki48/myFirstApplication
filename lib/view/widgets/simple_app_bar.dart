import 'package:get/get.dart';
import 'package:woogoods/constants/colors_data.dart';
import 'package:flutter/material.dart';

class SimpleAppBar {

  static AppBar appBar({
    required title,
    titleColor = Colors.white,
    backColor = kPrimaryColor,
    bool centerTitle = true
  }){
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: centerTitle,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: const TextStyle(color: Colors.black),
      ),
      elevation: 1.0,
      titleSpacing: 0,
    );
  }

}
