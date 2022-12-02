import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/response/brand_list.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/models/response/slider_list.dart';
import 'package:woogoods/services/api/api_checker.dart';
import 'package:woogoods/services/repository/auth_repo.dart';
import 'package:woogoods/services/repository/product_repo.dart';

import '../models/response/wordpress_image.dart';

class HomeController extends GetxController {
  final ProductRepo productRepo;
  final AuthRepo authRepo;

  HomeController({required this.productRepo, required this.authRepo});

  //Init model
  List<SliderList> _sliderList = [];
  List<ProductList> flashDeal = [];
  List<ProductList> _todayDeal = [];
  List<BrandList> _brandList = [];
  List<ProductList> featuredProduct = [];
  //Init
  bool _isLoading = false;
  bool _isFlashLoading = true;
  bool _isBrandLoading = true;
  bool _isTodayLoading = true;
  bool _isShimmerLoading = true;
  late int _popularPageSize;
  List<String> _offsetList = [];
  int _offset = 1;
  int _currentIndex = 0;

  ///Encapsulation
  List<SliderList> get sliderList => _sliderList;
  List<ProductList> get flashDeals => flashDeal;
  List<ProductList> get todayDeal => _todayDeal;
  List<BrandList> get brandList => _brandList;
  List<ProductList> get featuredProducts => featuredProduct;
  bool get isLoading => _isLoading;
  bool get isShimmerLoading => _isShimmerLoading;
  bool get isFlashLoading => _isFlashLoading;
  bool get isTodayLoading => _isTodayLoading;
  bool get isBrandLoading => _isBrandLoading;
  int get popularPageSize => _popularPageSize;
  int get offset => _offset;
  int get currentIndex => _currentIndex;

  void setOffset(int offset) {
    _offset = offset;
  }

  ///get Slider list data
  Future<void> fetchSliderList(
    String offset,
    bool reload, {
    String perPage = '20',
  }) async {
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;
      if (reload) {
        _sliderList = [];
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final response = await productRepo.getSliderList(
        offset: offset,
        perPage: perPage,
      );
      if (response.statusCode == 200) {
        if (offset == '1') {
          _sliderList = [];
        }
        List<dynamic> body = jsonDecode(response.body);
        List<SliderList> posts = body
            .map(
              (dynamic item) => SliderList.fromJson(item),
            )
            .toList();
        log(response.body);

        if (body.isEmpty) {
          _isLoading = false;
          update();
        } else {
          _sliderList.addAll(posts);
          _popularPageSize = posts.length;
          _isLoading = false;
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

  ///Get Today Sale data
  Future<void> fetchFlashSaleList(
    String offset,
    bool reload, {
    String perPage = '20',
  }) async {
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;
      if (reload) {
        flashDeal = [];
        _isFlashLoading = true;
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final response = await productRepo.getProductList(
        offset: '1',
        onSale: true,
      );
      if (response.statusCode == 200) {
        if (offset == '1') {
          flashDeal = [];
        }
        List<dynamic> body = jsonDecode(response.body);
        List<ProductList> posts = body
            .map(
              (dynamic item) => ProductList.fromJson(item),
            )
            .toList();
        log(response.body);

        if (body.isEmpty) {
          _isFlashLoading = false;
          update();
        } else {
          flashDeal.addAll(posts);
          _popularPageSize = posts.length;
          _isFlashLoading = false;
          update();
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if (_isFlashLoading) {
        _isFlashLoading = false;
        update();
      }
    }
  }

  ///Get feature product from server this product is featured product
  ///Featured product == today sell product
  Future<void> fetchTodaySellList(
    String offset,
    bool reload, {
    String perPage = '20',
  }) async {
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;
      if (reload) {
        _todayDeal = [];
        _isTodayLoading = true;
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final response = await productRepo.getProductList(
        offset: '1',
        feature: true,
      );
      if (response.statusCode == 200) {
        if (offset == '1') {
          _todayDeal = [];
        }
        List<dynamic> body = jsonDecode(response.body);
        List<ProductList> posts = body
            .map(
              (dynamic item) => ProductList.fromJson(item),
            )
            .toList();
        log(response.body);

        if (body.isEmpty) {
          _isTodayLoading = false;
          update();
        } else {
          _todayDeal.addAll(posts);
          _popularPageSize = posts.length;
          _isTodayLoading = false;
          update();
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if (_isTodayLoading) {
        _isTodayLoading = false;
        update();
      }
    }
  }

  //Get brand product data
  Future<void> fetchBrandList(
      String offset,
      bool reload, {
        String perPage = '8',
      }) async {
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;
      if (reload) {
        _brandList = [];
        _isBrandLoading = true;
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final response = await productRepo.getBrandList(perPage: perPage,);
      if (response.statusCode == 200) {
        if (offset == '1') {
          _brandList = [];
        }
        List<dynamic> body = jsonDecode(response.body);
        List<BrandList> posts = body
            .map(
              (dynamic item) => BrandList.fromJson(item),
        )
            .toList();
        log(response.body);

        if (body.isEmpty) {
          _isBrandLoading = false;
          update();
        } else {
          for (int i = 0; i < posts.length; i++) {
            final response = await productRepo.getWordpressImage(
              (posts[i].thumbnailId ?? 0).toString(),
            );
            var detailsResponse = jsonDecode(response.body);
            if (response.statusCode == 200) {
              WordpressImage imageData = WordpressImage.fromJson(detailsResponse);
              log(response.body);
              if (detailsResponse.isNotEmpty) {
                _brandList.add(BrandList(
                  id: posts[i].id,
                  count: posts[i].count,
                  description: posts[i].description,
                  name: posts[i].name,
                  slug: posts[i].slug,
                  taxonomy: posts[i].taxonomy,
                  thumbnailId: posts[i].thumbnailId,
                  thumbnailImage: imageData.guid?.rendered,
                ));
                log('=================>>product-details log');
              }
            } else {
              log(detailsResponse['message'].toString());
            }
          }
          _isBrandLoading = false;
          update();
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if (_isBrandLoading) {
        _isBrandLoading = false;
        update();
      }
    }
  }

  //Get home product this product is woo commerce popular (order by = popularity) product
  Future<void> fetchHomeProductList(
    String offset,
    bool reload,
  ) async {
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;

      if (reload) {
        featuredProduct = [];
        _isShimmerLoading = true;
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final response = await productRepo.getProductList(
          offset: offset, orderBy: 'popularity');
      if (response.statusCode == 200) {
        if (offset == '1') {
          featuredProduct = [];
        }
        List<dynamic> body = jsonDecode(response.body);
        List<ProductList> posts = body
            .map(
              (dynamic item) => ProductList.fromJson(item),
            )
            .toList();
        log(response.body);
        if (body.isEmpty) {
          _isLoading = false;
          _isShimmerLoading = false;
          update();
          if (offset == '1') {
          } else {
            showCustomSnackBar('No more products');
          }
        } else {
          featuredProduct.addAll(posts);
          _popularPageSize = posts.length;
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

  ///Slider update current index
  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }
}
