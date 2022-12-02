import 'package:http/http.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/models/body/login_body.dart';
import 'package:woogoods/models/body/registration.dart';
import 'package:woogoods/models/response/login_response.dart';
import 'package:woogoods/models/response/users.dart';
import 'package:woogoods/services/api/api_client.dart';
import 'package:woogoods/services/api/app_config.dart';

import '../../main.dart';

class AuthRepo {
  final ApiClient apiClient;

  AuthRepo({required this.apiClient});

  ///Get single user info
  Future<Response> getSingleUser(String id) async {
    return await apiClient.getData('$singleUserUri/$id');
  }

  ///Register user Email userId and password
  Future<Response> emailRegister(Registration registration) async {
    return await apiClient.postDataBodyJson('$emailRegisterUri?',
        body: registration);
  }

  ///Login user Email and userId,  password
  Future<Response> emailLogin(LoginBody body) async {
    return await apiClient.postData(
        '$emailLoginUri?username=${body.username ?? ""}&password=${body.password ?? ""}&');
  }

  ///Login user Email and userId,  password
  Future<Response> updateInfo(
    Users body,
    String userId, {
    Map<String, String>? headers,
  }) async {
    return await apiClient.postData(
        '$updateProfileUri/$userId?first_name=${body.firstName ?? ""}&last_name=${body.lastName ?? ""}&name=${body.firstName ?? ""} ${body.lastName ?? ""}',
        headers: headers);
  }

  ///update user name
  Future<Response> updateUserName(
    Users body,
    String userId, {
    Map<String, String>? headers,
  }) async {
    return await apiClient.postData(
        '$updateProfileUri/$userId?username=${body.username ?? ""}',
        headers: headers);
  }

  ///Update Password
  Future<Response> updatePassword(
    String password,
    String userId, {
    Map<String, String>? headers,
  }) async {
    return await apiClient.postData(
        '$updateProfileUri/$userId?password=$password',
        headers: headers);
  }

  ///Get current user info
  Future<Response> getCurrentUserInfo(
    Map<String, String>? headers,
  ) async {
    return await apiClient.getData(currentUserProfileUri, headers: headers);
  }

  ///Reset Password
  Future<Response> restPassword(String email) async {
    return await apiClient.postData('$resetPasswordUri?email=$email&');
  }

  ///Reset New Password
  Future<Response> restNewPassword({
    required String email,
    required String password,
    required String code,
  }) async {
    return await apiClient.postData(
        '$resetNewPasswordUri?email=$email&password=$password&code=$code&');
  }

  ///Save User Info Shared
  Future<void> saveUserInfoShared(LoginResponse response) async {
    try {
      await prefs.setString(token, response.token ?? "");
      await prefs.setString(userId, response.userId.toString());
      await prefs.setString(userAvatar, response.avatar ?? "");
      await prefs.setString(userDisplayName, response.userDisplayName ?? "");
      await prefs.setString(userName, response.userDisplayName ?? "");
      await prefs.setString(userEmail, response.userEmail ?? "");
      await prefs.setString(firstName, response.firstName ?? "");
      await prefs.setString(lastName, response.lastName ?? "");
    } catch (e) {
      rethrow;
    }
  }

  ///Save Name Shared
  Future<void> saveNameShared(Users response) async {
    try {
      await prefs.setString(
          userDisplayName, '${response.firstName} ${response.lastName}');
      await prefs.setString(firstName, response.firstName ?? "");
      await prefs.setString(lastName, response.lastName ?? "");
    } catch (e) {
      rethrow;
    }
  }

  ///Save User name Shared
  Future<void> saveUserNameShared(Users response) async {
    try {
      await prefs.setString(userName, response.username ?? "");
    } catch (e) {
      rethrow;
    }
  }

  ///Save User name Shared
  Future<void> saveUserPasswordShared(String pass) async {
    try {
      await prefs.setString(userPassword, pass);
    } catch (e) {
      rethrow;
    }
  }

  ///Is login
  bool isLoggedIn() {
    return prefs.containsKey(token);
  }

  ///Clear Shared data
  bool clearSharedData() {
    prefs.remove(token);
    return true;
  }

  String getUserToken() {
    return prefs.getString(token) ?? "";
  }

  ///User password
  String getUserPassword() {
    return prefs.getString(userPassword) ?? "";
  }

  ///User info get
  String getUserDisplayName() {
    return prefs.getString(userDisplayName) ?? "";
  }

  String getUserName() {
    return prefs.getString(userName) ?? "";
  }

  String getUserEmail() {
    return prefs.getString(userEmail) ?? "";
  }

  String getUserFName() {
    return prefs.getString(firstName) ?? prefs.getString(userDisplayName) ?? "";
  }

  String getUserLName() {
    return prefs.getString(lastName) ?? "";
  }

  String getUserId() {
    return prefs.getString(userId) ?? "";
  }

  String getUserAvatar() {
    return prefs.getString(userAvatar) ?? "";
  }
}
