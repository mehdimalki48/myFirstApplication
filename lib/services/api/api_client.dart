import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart' as foundation;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/models/body/registration.dart';

import '../../main.dart';

class ApiClient {
  final String appBaseUrl;

  ApiClient({required this.appBaseUrl});

  String? currentToken = prefs.getString(token);
  Map<String, String>? _mainHeaders = {
    "Content-Type": "application/json",
  };

  void updateHeader(String token, String zoneID) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      "Accept": "application/json"
      //'Authorization': 'Bearer $token',
    };
  }

  Future<http.Response> getData(
    String uri, {
    Map<String, String>? headers,
    int? timeOut,
  }) async {
    if (foundation.kDebugMode) {
      log('====> Http Call: $appBaseUrl$uri\nToken: $currentToken');
    }
    http.Response response = await http
        .get(
          Uri.parse(appBaseUrl + uri),
          headers: headers ?? _mainHeaders,
        )
        .timeout(Duration(seconds: timeOut ?? timeoutRequest));
    response = handleResponse(response);
    if (foundation.kDebugMode) {
      log('====> Http Response: [${response.statusCode}] $uri\n${response.body}');
    }
    return response;
  }

  Future<http.Response> postData(
    String uri, {
    dynamic body,
    Map<String, String>? headers,
    int? timeOut,
  }) async {
    if (foundation.kDebugMode) {
      log('====> Http Call: $uri\nToken: $currentToken');
    }
    http.Response response = await http
        .post(
          Uri.parse(appBaseUrl + uri),
          body: body,
          headers: headers ?? _mainHeaders,
        )
        .timeout(Duration(seconds: timeOut ?? timeoutRequest));
    response = handleResponse(response);
    if (foundation.kDebugMode) {
      log('====> Http Response: [${response.statusCode}] $uri\n${response.body}');
    }
    return response;
  }

  Future<Response> postDataBodyJson(
    String uri, {
    Registration? body,
    Map<String, String>? headers,
    int? timeOut,
  }) async {
    if (foundation.kDebugMode) {
      log('====> Http Call: $uri\nToken: $currentToken');
      log('====> Http Call: ${body!.username}');
    }
    var bodyValue = json.encode({
      "username": body!.username ?? "",
      "email": body.email ?? "",
      "password": body.password ?? "",
    });
    Response response = await http
        .post(
          Uri.parse(appBaseUrl + uri),
          body: bodyValue,
          headers: headers ?? _mainHeaders,
        )
        .timeout(Duration(seconds: timeOut ?? timeoutRequest));
    response = handleResponse(response);
    if (foundation.kDebugMode) {
      log('====> Http Response: [${response.statusCode}] $uri\n${response.body}');
    }
    return response;
  }

  ///Handel request response
  http.Response handleResponse(http.Response response) {
    http.Response _response = response;
    return _response;
  }
}
