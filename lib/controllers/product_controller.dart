import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/services/api/api_checker.dart';
import 'package:woogoods/services/repository/product_repo.dart';

class ProductController extends GetxController {
  final ProductRepo productRepo;
  ProductController({required this.productRepo});

  //Init model
  List<ProductList> productList = [];
  List<ProductList> flashDeal = [];
  List<ProductList> featuredProduct = [];
  //Init
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var isFlashLoading = false.obs;
  var isFeatureLoading = false.obs;
  var isSearch = false.obs;
  var isOffsetLoading = false.obs;
  late int _popularPageSize;
  List<String> _offsetList = [];
  String _searchText = '';
  int _offset = 1;

  ///Encapsulation
  List<ProductList> get productsList => productList;
  List<ProductList> get flashDeals => flashDeal;
  List<ProductList> get featuredProducts => featuredProduct;
  int get popularPageSize => _popularPageSize;
  int get offset => _offset;
  String get searchText => _searchText;

  void setOffset(int offset) {
    _offset = offset;
  }

  Future<void> fetchProductsList(
    String offset,
    bool reload, {
    String search = '',
    bool onSale = false,
    bool feature = false,
    bool order = true,
    String? orderBy,
    String? parentId,
    String? minPrice,
    String? maxPrice,
        String? brandId,
  }) async {
    try {
      // isOffsetLoading(true);
      if (_offset.toString() == '1' || reload) {
        isLoading(true);

        _offsetList = [];
        if (reload) {
          productList.clear();
        }
        // update();
      }
      if (!_offsetList.contains(offset)) {
        _offsetList.add(offset);
        log('=================>> controller log' + _offset.toString());
        final response = await productRepo.getProductList(
          onSale: onSale,
          feature: feature,
          offset: _offset.toString(),
          parentId: parentId,
          search: search,
          minPrice: minPrice,
          maxPrice: maxPrice,
          order: order,
          orderBy: orderBy,
          brandId: brandId,
        );
        if (response.statusCode == 200) {
          if (_offset.toString() == '1') {
            productList.clear();
          }
          List<dynamic> body = jsonDecode(response.body);
          List<ProductList> posts = body
              .map(
                (dynamic item) => ProductList.fromJson(item),
              )
              .toList();
          log(response.body);
          if (body.isEmpty && _offset.toString() != '1') {
            isLoading(false);
            isLoadingMore(false);
            update();
            showCustomSnackBar('No more Products');
          } else {
            isLoading(true);

            log('=================>> add log');
            productList.addAll(posts);
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

  Future<void> fetchFeaturedProductsList(
    String offset,
    bool reload, {
    String search = '',
    String? parentId,
    bool todayDell = false,
  }) async {
    log('xxxxxxxxxxxxxxxxx$todayDell');
    if (offset == '1' || reload) {
      isFeatureLoading(true);

      _offsetList = [];
      _offset = 1;
      if (reload) {
        featuredProduct.clear();
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final response = await productRepo.getProductList(
        feature: true,
        parentId: parentId,
      );
      if (response.statusCode == 200) {
        if (offset == '1') {
          featuredProduct.clear();
        }
        List<dynamic> body = jsonDecode(response.body);
        List<ProductList> posts = body
            .map(
              (dynamic item) => ProductList.fromJson(item),
            )
            .toList();
        log(response.body);
        if (body.isEmpty) {
          isFeatureLoading(false);
          isLoadingMore(false);
          update();
          showCustomSnackBar('No more categories');
        } else {
          featuredProduct.addAll(posts);
          _popularPageSize = posts.length;
          isFeatureLoading(false);
          isLoadingMore(false);
          update();
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if (isFeatureLoading.isTrue) {
        isFeatureLoading(false);
        update();
      }
    }
  }

  Future<void> fetchSaleProductsList(String offset, bool reload,
      {String search = '', String? parentId}) async {
    if (offset == '1' || reload) {
      isFlashLoading(true);
      _offsetList = [];
      _offset = 1;
      if (reload) {
        flashDeal.clear();
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final response = await productRepo.getProductList(
        onSale: true,
        parentId: parentId,
      );
      if (response.statusCode == 200) {
        if (offset == '1') {
          flashDeal.clear();
        }
        List<dynamic> body = jsonDecode(response.body);
        List<ProductList> posts = body
            .map(
              (dynamic item) => ProductList.fromJson(item),
            )
            .toList();
        log(response.body);
        if (body.isEmpty) {
          isFlashLoading(false);
          isLoadingMore(false);
          update();
          showCustomSnackBar('No more categories');
        } else {
          flashDeal.addAll(posts);
          _popularPageSize = posts.length;
          isFlashLoading(false);
          isLoadingMore(false);
          update();
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if (isFlashLoading.isTrue) {
        isFlashLoading(false);
        update();
      }
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
    productList.clear();
    flashDeal.clear();
    featuredProduct.clear();
    super.dispose();
  }
}
