import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/response/order_list.dart';
import 'package:woogoods/services/api/api_checker.dart';
import 'package:woogoods/services/repository/auth_repo.dart';
import 'package:woogoods/services/repository/order_repo.dart';
import 'package:woogoods/view/screens/order/orders_details_screen.dart';

class OrdersController extends GetxController {
  final OrdersRepo ordersRepo;
  final AuthRepo authRepo;
  OrdersController({required this.ordersRepo, required this.authRepo});

  //Init model
  List<OrderList> ordersList = [];
  //Init
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var isSearch = false.obs;
  var isOffsetLoading = false.obs;
  late int _popularPageSize;
  List<String> _offsetList = [];
  String _searchText = '';
  int _offset = 1;

  ///Encapsulation
  List<OrderList> get ordersListData => ordersList;
  int get popularPageSize => _popularPageSize;
  int get offset => _offset;
  String get searchText => _searchText;

  void setOffset(int offset) {
    _offset = offset;
  }

  ///get order list
  Future<void> fetchOrdersListData(
    String offset,
    bool reload, {
    String search = '',
    String status = 'any',
    bool order = true,
    String? orderBy,
    String? parentId,
    String? minPrice,
    String? maxPrice,
  }) async {
    try {
      // isOffsetLoading(true);
      if (_offset.toString() == '1' || reload) {
        isLoading(true);

        _offsetList = [];
        if (reload) {
          ordersList.clear();
        }
        // update();
      }
      if (!_offsetList.contains(offset)) {
        _offsetList.add(offset);
        log('=================>> controller log' + _offset.toString());
        final response = await ordersRepo.getOrderList(
          offset: _offset.toString(),
          status: status,
          parentId: parentId,
          search: search,
          minPrice: minPrice,
          maxPrice: maxPrice,
          order: order,
          orderBy: orderBy,
          customer: authRepo.getUserId(),
        );
        if (response.statusCode == 200) {
          if (_offset.toString() == '1') {
            ordersList.clear();
          }
          List<dynamic> body = jsonDecode(response.body);
          List<OrderList> posts = body
              .map(
                (dynamic item) => OrderList.fromJson(item),
              )
              .toList();
          log(response.body);
          if (body.isEmpty && _offset.toString() != '1') {
            isLoading(false);
            isLoadingMore(false);
            update();
            showCustomSnackBar('No more orders');
          } else {
            isLoading(true);

            log('=================>> add log');
            ordersList.addAll(posts);
            _popularPageSize = posts.length;
            isLoadingMore(false);
            // isLoading(false);
          }
        } else {
          ApiChecker.checkApi(response);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  ///get single order data
  Future<void> fetchSingleOrders(BuildContext context,
      {required String id}) async {
    final response = await ordersRepo.getSingleOrder(id: id);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      OrderList orderList = OrderList.fromJson(body);
      //Dialog dismiss
      Navigator.of(context).pop();
      //open new class
      int statusInx = 0;
      bool isOrder = false;
      String status = orderList.status ?? '';
      if (status == 'pending') {
        statusInx = 0;
      } else if (status == 'on-hold') {
        statusInx = 1;
      } else if (status == 'processing') {
        statusInx = 2;
      } else if (status == 'completed') {
        statusInx = 4;
      } else if (status == 'cancelled') {
        statusInx = 4;
      } else if (status == 'refunded') {
        statusInx = 5;
      } else if (status == 'failed') {
        statusInx = 4;
      }

      //check order status cancel return and failed
      if (status == 'cancelled' || status == 'refunded' || status == 'failed') {
        isOrder = false;
      } else {
        isOrder = true;
      }
      Get.to(
        () => OrderDetailsScreen(
          processIndex: statusInx,
          isCanceled: status == 'cancelled' ? true : false,
          isReturned: status == 'refunded' ? true : false,
          isFailed: status == 'failed' ? true : false,
          isTracking: true,
          isOrder: isOrder,
          orderList: orderList,
        ),
      );
    } else {
      //Dialog dismiss
      Navigator.of(context).pop();
      ApiChecker.checkApi(response);
    }
  }

  void showBottomLoader() {
    isLoadingMore(true);
    update();
  }

  void changeOffset() {
    try {
      isOffsetLoading(true);
      ++_offset;
    } finally {
      isOffsetLoading(false);
    }
  }

  void changeSearchStatus() {
    if (isSearch.isFalse) {
      isSearch(true);
    } else {
      isSearch(false);
    }
    update();
  }

  void searchCategories(String search) {
    _searchText = _searchText;
    update();
  }

  @override
  void dispose() {
    ordersList.clear();
    super.dispose();
  }

}
