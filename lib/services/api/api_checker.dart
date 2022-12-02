import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/view/screens/auth/login_screen.dart';

import '../../controllers/auth_controller.dart';

class ApiChecker {
  static void checkApi(http.Response response) {
    if (response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();
      final responseJson = jsonDecode(response.body);
      Get.to(() => LoginScreen(),);
      if (responseJson['message'] != null) {
        showCustomSnackBar(responseJson['message']);
      } else {
        showCustomSnackBar(responseJson['error']);
      }
    } else {
      final responseJson = jsonDecode(response.body);
      if (responseJson['message'] != null) {
        showCustomSnackBar(responseJson['message']);
      } else {
        showCustomSnackBar(responseJson['error']);
      }
    }
  }
}
