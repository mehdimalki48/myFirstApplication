import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/helper/sqlite_db_helper.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/models/response/recents_model.dart';
import 'package:woogoods/services/api/api_client.dart';

class RecentController extends GetxController {
  ApiClient apiClient;

  RecentController({required this.apiClient});

  //Init model
  final List<RecentPostModel> _recentList = [];
  final List<ProductList> _productList = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  //Init
  bool _isLoading = false;

  ///Encapsulation
  List<RecentPostModel> get recentList => _recentList;

  List<ProductList> get productList => _productList;

  bool get isLoading => _isLoading;

  ///Favourite
  void addToRecent(ProductList tempModel) async {
    List<RecentPostModel> data = await _databaseHelper.getAllRecent();
    ///add sqlite database assign
    _recentList.assignAll(data);
    //for adding existing items to the cart and increase quantity
    var isExist = _recentList.where((element) => element.id == tempModel.id);
    log('Exist : $isExist');

    if (isExist.isNotEmpty) {
      //removeFromRecent(tempModel.id ?? 0);
      log('product already exits');
    } else {
      if(_recentList.isNotEmpty && 20 < _recentList.length ){//21 ar opr hole
        log('Last item delete first ..');
        //list fist item delete and added new item.
        // table first item delete and new this item added
        removeFirstItemAndAdded(recentList.first.id ?? 0, tempModel);
      }else{
        log('added new data');
        var product = jsonEncode(tempModel);
        //for adding new items to the cart
        RecentPostModel rpShopFavoriteModel = RecentPostModel(
          id: tempModel.id,
          product: product,
        );
        _databaseHelper.insertRecent(rpShopFavoriteModel);

        var result = await _databaseHelper.getAllRecent();
        if (result.isNotEmpty) {
          _recentList.assignAll(result);
          getRecentList();
        }
      }

    }
  }

  Future<void> removeFromRecent(int id,) async {
    try {
      _isLoading = true;
      await _databaseHelper.deleteRecent(id);
      showCustomSnackBar('Remove from recent successfully!', );
      getRecentList();
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> removeFirstItemAndAdded(int id, ProductList tempModel) async {
    try {
      _isLoading = true;
      await _databaseHelper.deleteRecent(id);
      var product = jsonEncode(tempModel);
      //for adding new items to the cart
      RecentPostModel rpShopFavoriteModel = RecentPostModel(
        id: tempModel.id,
        product: product,
      );
      _databaseHelper.insertRecent(rpShopFavoriteModel);

      var result = await _databaseHelper.getAllRecent();
      if (result.isNotEmpty) {
        _recentList.assignAll(result);
        getRecentList();
      }
    } finally {
      _isLoading = false;
      update();
    }
  }

  //Get  all Favourite
  void getRecentList() async {
    try {
      _isLoading = true;
      ///product list added
      _productList.clear();
      List<RecentPostModel> data = await _databaseHelper.getAllRecent();

      ///add sqlite database assign
      _recentList.assignAll(data);
      update();



      for (int i = data.length - 1 ; i > -1; i--) {
        var productFab = jsonDecode(data[i].product!);
        ProductList productList = ProductList.fromJson(productFab);
        _productList.add(productList);
      }
      _isLoading = false;
      update();
    } finally {
      _isLoading = false;
      update();
    }
  }

  bool isAlreadyAdd(int id) {
    var isExist = _recentList.indexWhere((element) => element.id == id);
    log('Exist : $isExist');
    if (isExist >= 0) {
      return true;
    } else {
      return false;
    }
  }

  void emptyRecentView() async {
    try {
      _isLoading = false;
      await _databaseHelper.emptyRecentList();
      getRecentList();
      Get.back();
      showCustomSnackBar('Clear item form recent view successfully!', isError: false);
    } finally {
      _isLoading = false;
      update();
    }
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }
}
