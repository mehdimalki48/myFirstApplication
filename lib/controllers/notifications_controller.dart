import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';

import '../models/response/rp_notifications.dart';
import '../services/api/api_checker.dart';
import '../services/repository/notification_repo.dart';

class NotificationsController extends GetxController {
  final NotificationRepo notificationRepo;
  NotificationsController({required this.notificationRepo});

  //Init model
  List<Notifications> _notificationList = [];
  //Init
  bool _isLoading = false;
  bool _isShimmerLoading = true;
  late int _popularPageSize;
  List<String> _offsetList = [];
  int _offset = 1;

  ///Encapsulation
  List<Notifications> get notificationList => _notificationList;

  bool get isLoading => _isLoading;
  bool get isShimmerLoading => _isShimmerLoading;
  int get popularPageSize => _popularPageSize;
  int get offset => _offset;

  void setOffset(int offset) {
    _offset = offset;
  }

  Future<void> getNotificationList(String offset, bool reload,) async {
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;

      if (reload) {
        _notificationList = [];
        _isShimmerLoading = true;
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final response = await notificationRepo.getNotificationList(offset, perPage: '15',);
      if (response.statusCode == 200) {
        if (offset == '1') {
          _notificationList = [];
        }
        var posts = RpNotifications.fromJson(jsonDecode(response.body));
        if (posts.notifications!.isEmpty) {
          _isLoading =  false;
          _isShimmerLoading =  false;
          update();
        } else {
          log('=================>> add log');
          _notificationList.addAll(posts.notifications!);
          _popularPageSize = posts.totalCount!;
          _isLoading = false;
          _isShimmerLoading = false;
          update();
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if (isLoading) {
        _isLoading = false;
        update();
      }
    }
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  void showShimmerLoader() {
    _isShimmerLoading = true;
    update();
  }

}
