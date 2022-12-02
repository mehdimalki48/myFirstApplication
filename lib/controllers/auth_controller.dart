import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/body/login_body.dart';
import 'package:woogoods/models/body/registration.dart';
import 'package:woogoods/models/response/login_response.dart';
import 'package:woogoods/models/response/single_user.dart';
import 'package:woogoods/models/response/users.dart';
import 'package:woogoods/services/api/api_checker.dart';
import 'package:woogoods/services/repository/auth_repo.dart';
import 'package:woogoods/view/screens/auth/login_screen.dart';
import 'package:woogoods/view/screens/dashboard/dashboard_screen.dart';

import '../main.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  //Init Google sing in
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  //Init model
  late SingleUser _sliderUser;
  late Users _users;
  bool _isNotification = true;
  //Init
  bool _isLoading = false;
  bool _forgotCode = false;
  bool _forgotIsEmail = true;

  ///Encapsulation
  SingleUser get sliderUser => _sliderUser;

  Users get users => _users;

  bool get isLoading => _isLoading;
  bool get forgotCode => _forgotCode;
  bool get forgotIsEmail => _forgotIsEmail;
  bool get isNotification => _isNotification;

  @override
  void onInit() {
    //check is subscribe for topic
    checkNotification();

    super.onInit();
  }

  //check is subscribe for topic
  void checkNotification() {
    if (prefs.containsKey('notification')) {
      if (prefs.getBool('notification') == true) {
        changeNotification(true);
      } else {
        changeNotification(false);
      }
    } else {
      changeNotification(true);
    }
  }

  //Register user Email userId and password
  Future<void> emailRegistration(
      Registration signupBody, BuildContext context, String pass) async {
    _isLoading = true;
    update();
    final response = await authRepo.emailRegister(signupBody);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      if (foundation.kDebugMode) {
        log('====> Http Response: $body');
      }
      LoginBody loginData = LoginBody(
          username: signupBody.username ?? "",
          password: signupBody.password ?? "");

      ///login
      emailLogin(loginData, context, pass);
      _isLoading = false;
      update();
    } else {
      //Dialog dismiss
      Navigator.of(context).pop();
      ApiChecker.checkApi(response);
    }
  }

  //Login user Email and userId,  password
  Future<void> emailLogin(
      LoginBody body, BuildContext context, String pass) async {
    _isLoading = true;
    update();
    final response = await authRepo.emailLogin(body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (foundation.kDebugMode) {
        log('====> Http Response: $body');
      }

      LoginResponse loginResponse = LoginResponse.fromJson(body);
      saveUserInfoShared(loginResponse);
      saveUserPasswordShared(pass);
      //Dialog dismiss
      Navigator.of(context).pop();
      //open new class
      Get.offAll(() => const DashBoardScreen());
      _isLoading = false;

      update();
    } else {
      //Dialog dismiss
      Navigator.of(context).pop();
      ApiChecker.checkApi(response);
    }
  }

  ///Google Login
  Future<void> handleGoogleSignIn(BuildContext context) async {
    try {
      _isLoading = true;
      update();

      await _googleSignIn.signIn().then((value) {
        log('displayName: ${value?.displayName ?? ""}');
        log('displayEmail: ${value?.email ?? ""}');
        log('id: ${value?.id ?? ""}');
        log('PhotoUrl: ${value?.photoUrl ?? ""}');

        value?.authentication.then((value2) async {
          log('id token: ${value2.idToken ?? ""}');

          Registration signupBody = Registration(
            username: value.id,
            email: value.email,
            password: value.id,

            ///use password in google account id
          );
          final response = await authRepo.emailRegister(signupBody);
          if (response.statusCode == 200 || response.statusCode == 201) {
            final body = jsonDecode(response.body);
            if (foundation.kDebugMode) {
              log('====> Http Response: $body');
            }

            ///login data
            LoginBody loginData = LoginBody(
                username: signupBody.username ?? "",
                password: signupBody.password ?? "");
            //Login
            emailLogin(loginData, context, value.id);
            _isLoading = false;
            update();
          } else {
            final responseJson = jsonDecode(response.body);
            if (responseJson['code'] == 406) {
              log('Already register');

              ///login data
              LoginBody loginData =
                  LoginBody(username: value.email, password: value.id);
              //Login
              emailLogin(loginData, context, value.id);
              _isLoading = false;
              update();
            } else {
              //Dialog dismiss
              Navigator.of(context).pop();
              ApiChecker.checkApi(response);
            }
          }
        });
      });
    } catch (error) {
      log(error.toString());
      Navigator.of(context).pop();
      showCustomSnackBar(error.toString());
    }
  }

  Future<void> facebookLogin(BuildContext context) async {
    final LoginResult result = await FacebookAuth.instance.login(permissions: [
      "email",
    ]); // by default we request the email and the public profile

    if (result.status == LoginStatus.success) {
      //_accessToken = result.accessToken;
      //_printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      //final userData = await FacebookAuth.instance.getUserData();

      final userData = await FacebookAuth.instance.getUserData();
      //_userData = userData;

      if (kDebugMode) {
        log(userData.toString());
      }
      //String name = userData['name'] ?? '';
      String id = userData['id'] ?? '';
      String picture = userData['picture']['data']['url'] ?? '';
      log(picture);
      Registration signupBody = Registration(
        username: id,
        email: id + '@gmail.com',
        password: id,

        ///use password in google account id
      );
      final response = await authRepo.emailRegister(signupBody);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final body = jsonDecode(response.body);
        if (foundation.kDebugMode) {
          log('====> Http Response: $body');
        }

        ///login data
        LoginBody loginData = LoginBody(
            username: signupBody.username ?? "",
            password: signupBody.password ?? "");
        //Login
        emailLogin(loginData, context, id);
        _isLoading = false;
        update();
      } else {
        final responseJson = jsonDecode(response.body);
        if (responseJson['code'] == 406) {
          log('Already register');

          ///login data
          LoginBody loginData = LoginBody(username: id, password: id);
          //Login
          emailLogin(loginData, context, id);
          _isLoading = false;
          update();
        } else {
          //Dialog dismiss
          Navigator.of(context).pop();
          ApiChecker.checkApi(response);
        }
      }
    } else {
      if (kDebugMode) {
        log(result.status.toString());
        log(result.message.toString());
      }
      //
      log('message');
      Navigator.of(context).pop();
      showCustomSnackBar(result.message ?? "");
    }
  }

  ///Login user Email and userId,  password
  Future<void> updateInfo(Users users, BuildContext context) async {
    _isLoading = true;
    update();
    final response = await authRepo.updateInfo(users, getUserId(),
        headers: currentUserHeader());
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (foundation.kDebugMode) {
        log('====> Http Response: $body');
      }

      Users data = Users(
        firstName: users.firstName,
        lastName: users.lastName,
      );
      saveNameShared(data);
      //Dialog dismiss
      Navigator.of(context).pop();
      Get.back();
      //open new class
      _isLoading = false;

      showCustomSnackBar('User Info Updated Successfully!', isError: false);
      update();
    } else {
      //Dialog dismiss
      Navigator.of(context).pop();
      ApiChecker.checkApi(response);
    }
  }

  ///Update user name
  Future<void> updateUserName(Users users, BuildContext context) async {
    _isLoading = true;
    update();

    final response = await authRepo.updateUserName(users, getUserId(),
        headers: currentUserHeader());
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (foundation.kDebugMode) {
        log('====> Http Response: $body');
      }

      Users data = Users(
        username: users.username,
      );
      saveUserNameShared(data);
      //Dialog dismiss
      Navigator.of(context).pop();
      //open new class
      _isLoading = false;

      showCustomSnackBar('Username Updated successfully!', isError: false);
      update();
    } else {
      //Dialog dismiss
      Navigator.of(context).pop();
      ApiChecker.checkApi(response);
    }
  }

  ///Update user name
  Future<void> updatePassword(String password, BuildContext context) async {
    _isLoading = true;
    update();
    final response = await authRepo.updatePassword(password, getUserId(),
        headers: currentUserHeader());
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (foundation.kDebugMode) {
        log('====> Http Response: $body');
      }

      saveUserPasswordShared(password);
      //Dialog dismiss
      Navigator.of(context).pop();
      //open new class
      _isLoading = false;

      showCustomSnackBar('Password Updated successfully!', isError: false);
      update();
    } else {
      //Dialog dismiss
      Navigator.of(context).pop();
      ApiChecker.checkApi(response);
    }
  }

  ///Get single user info
  Future<void> getCurrentUserInfo(
    Map<String, String> headers,
  ) async {
    _isLoading = true;
    update();

    _users = Users();
    final response = await authRepo.getCurrentUserInfo(headers);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      _users = Users.fromJson(body);
      _isLoading = false;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  ///Get current user header
  Map<String, String> currentUserHeader() {
    Map<String, String> _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${getUserToken()}',
    };
    return _mainHeaders;
  }

  ///Get slider user info
  Future<void> fetchSliderUser(
    String id,
  ) async {
    _sliderUser = SingleUser();
    final response = await authRepo.getSingleUser(id);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      _sliderUser = SingleUser.fromJson(body);
      _isLoading = false;
      update();
    } else {
      ApiChecker.checkApi(response);
    }
  }

  ///Reset Password Email and userId,  password
  Future<void> resetPassword(String email, BuildContext context) async {
    _isLoading = true;
    update();
    final response = await authRepo.restPassword(email);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (foundation.kDebugMode) {
        log('====> Http Response: $body');
      }

      //Dialog dismiss
      Navigator.of(context).pop();
      //forgot is email
      forgotIsEmailUpdate(false);
      //forgot is code
      forgotStatusUpdate(true);

      //open new class
      showCustomSnackBar(
          'A password reset email has been sent to your email address.',
          isError: false);
      _isLoading = false;
      update();
    } else {
      //Dialog dismiss
      Navigator.of(context).pop();
      ApiChecker.checkApi(response);
    }
  }

  ///Reset Password Email and userId,  password
  Future<void> resetNewPassword(
    BuildContext context, {
    required String email,
    required String password,
    required String code,
  }) async {
    _isLoading = true;
    update();
    final response = await authRepo.restNewPassword(
        email: email, password: password, code: code);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      if (foundation.kDebugMode) {
        log('====> Http Response: $body');
      }

      //Dialog dismiss
      Navigator.of(context).pop();
      //forgot is email
      forgotIsEmailUpdate(true);
      //forgot is code
      forgotStatusUpdate(false);
      //open new class
      Get.offAll(() => LoginScreen());

      showCustomSnackBar('Password reset successfully!', isError: false);

      _isLoading = false;
      update();
    } else {
      //Dialog dismiss
      Navigator.of(context).pop();
      ApiChecker.checkApi(response);
    }
  }

  void forgotStatusUpdate(bool status) {
    _forgotCode = status;
    update();
  }

  void forgotIsEmailUpdate(bool status) {
    _forgotIsEmail = status;
    update();
  }

  ///Save User Info Shared
  void saveUserInfoShared(LoginResponse loginResponse) {
    authRepo.saveUserInfoShared(loginResponse);
  }

  ///Save Name Info Shared
  void saveNameShared(Users response) {
    authRepo.saveNameShared(response);
  }

  ///Save UserName Info Shared
  void saveUserNameShared(Users response) {
    authRepo.saveUserNameShared(response);
  }

  ///Save UserPassword Info Shared
  void saveUserPasswordShared(String password) {
    authRepo.saveUserPasswordShared(password);
  }

  /// user login check
  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future changeNotification(bool check) async {
    await prefs.setBool('notification', check);
    if (check) {
      FirebaseMessaging.instance.subscribeToTopic(topicName);
    } else {
      FirebaseMessaging.instance.unsubscribeFromTopic(topicName);
    }
    _isNotification = check;
    update();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  ///User password
  String getUserPassword() {
    return authRepo.getUserPassword();
  }

  ///User info get
  String getUserDisplayName() {
    return authRepo.getUserDisplayName();
  }

  String getUserName() {
    return authRepo.getUserName();
  }

  String getUserEmail() {
    return authRepo.getUserEmail();
  }

  String getUserFName() {
    return authRepo.getUserFName();
  }

  String getUserLName() {
    return authRepo.getUserLName();
  }

  String getUserId() {
    return authRepo.getUserId();
  }

  String getUserAvatar() {
    return authRepo.getUserAvatar();
  }
}
