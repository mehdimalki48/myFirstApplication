import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/response/product_details.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/services/api/api_checker.dart';
import 'package:woogoods/services/repository/order_repo.dart';
import 'package:woogoods/services/repository/product_details_repo.dart';

import '../models/response/shipping_method_list.dart';
import '../models/response/shipping_zone_list.dart';

class ProductDetailsController extends GetxController {
  final ProductDetailsRepo productDetailsRepo;
  final OrdersRepo ordersRepo;

  ProductDetailsController({
    required this.productDetailsRepo,
    required this.ordersRepo,
  });

  //Init model
  ProductDetails? _details;
  List<String> attr = [];

  //Init
  var isSingLoading = false.obs;

//Init
  final List<ShippingZoneList> _shippingZoneList = [];
  final List<ShippingMethodList> _shippingMethodList = [];
  bool _isShippingLoading = false;
  int _shippingFee = 0;
  String _specification = '';
  var isLoadingMore = false.obs;
  var isSearch = false.obs;
  var isOffsetLoading = false.obs;
  bool _isLoading = false;

  ///Encapsulation
  bool get isShippingLoading => _isShippingLoading;
  bool get isLoading => _isLoading;

  int get shippingFee => _shippingFee;

  String get specification => _specification;

  ///Encapsulation
  ProductDetails? get product => _details;

  Future<void> fetchProductDetails({
    required String id,
  }) async {
    try {
      isSingLoading(true);
      log('=================>>product-details log');
      final response = await productDetailsRepo.getProductDetails(
        id: id,
      );
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        ProductDetails posts = ProductDetails.fromJson(body);
        log(response.body);
        if (body.isEmpty) {
          isSingLoading(false);
          showCustomSnackBar('Details not found');
        }
        if (_details != null) {
          _details = null;
        } else {
          _details = posts;
          getAttribute();
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isSingLoading(false);
    }
  }

  getAttribute() {
    for (int i = 0; i < product!.attributes!.length; i++) {
      if (product?.attributes![i].name == 'color') {
        attr.assignAll(product!.attributes![i].options!);
      }
    }
    log(attr.toString());
  }

  //get single order data
  Future<void> fetchShippingZone() async {
    _isShippingLoading = true;
    update();

    final response = await ordersRepo.getShippingZone();
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ShippingZoneList> posts = body
          .map(
            (dynamic item) => ShippingZoneList.fromJson(item),
      )
          .toList();
      log(response.body);
      if (body.isEmpty) {
        _isShippingLoading = false;
        update();
        update();
        showCustomSnackBar('No more orders');
      } else {
        log('=================>> add log');
        _shippingZoneList.addAll(posts);
        _isShippingLoading = false;
        update();

        if (_shippingZoneList.isNotEmpty) {
          for (int i = 0; i < _shippingZoneList.length; i++) {
            if ((_shippingZoneList[i].name ?? '') == 'Flat rate' ||
                (_shippingZoneList[i].name ?? '') == 'Flat Rate') {
              fetchShippingMethod(id: _shippingZoneList[i].id.toString());
            }
          }
        }
      }
    } else {
      //Dialog dismiss
      ApiChecker.checkApi(response);
    }
  }

  //get single order data
  Future<void> fetchShippingMethod({required String id}) async {
    _isShippingLoading = true;
    update();

    final response = await ordersRepo.getShippingMethod(id: id);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<ShippingMethodList> posts = body
          .map(
            (dynamic item) => ShippingMethodList.fromJson(item),
      )
          .toList();
      log(response.body);
      if (body.isEmpty) {
        _isShippingLoading = false;
        update();
      } else {
        log('=================>> add log');
        _shippingMethodList.addAll(posts);
        _isShippingLoading = false;
        update();
        updateShippingFee();
      }
    } else {
      //Dialog dismiss
      ApiChecker.checkApi(response);
    }
  }

  //calculate
  void updateShippingFee() {
    int value = 0;
    if (_shippingMethodList.isNotEmpty) {
      for (int i = 0; i < _shippingMethodList.length; i++) {
        if ((_shippingMethodList[i].methodTitle ?? '') == 'Flat rate' ||
            (_shippingMethodList[i].methodTitle ?? '') == 'Flat Rate') {
          value =
              int.parse(_shippingMethodList[i].settings?.cost?.value ?? '0');
          log('=================>> update shipping' +
              _shippingMethodList[i].methodId.toString());
          _shippingFee = value;
          update();
        } else {
          _shippingFee = 0;
          update();
        }
      }
    }
  }

  void addedSpecification({required ProductList product}) {
    try{
      _isLoading = true;
      for (var data in product.metaData!) {
        log('ddddddddddd__________log: ${data.value}');
        if ((data.key ?? '') == '_specifications') {
          log('specifications__________log: ${data.value}');
          _specification = data.value ?? '';
        }
      }
      update();
    }finally{
      _isLoading = false;
      update();
    }
  }
}