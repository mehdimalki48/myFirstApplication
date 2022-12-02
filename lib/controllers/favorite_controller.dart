import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:woogoods/helper/sqlite_db_helper.dart';
import 'package:woogoods/models/response/favorite_model.dart';
import 'package:woogoods/models/response/product_list.dart';

class FavoriteController extends GetxController {
  //Init model
  final List<FavoriteModel> _favoriteList = [];
  late List<bool> _tempList;
  bool _isDelete = false;
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  //Init
  var isLoading = false.obs;

  ///Encapsulation
  List<FavoriteModel> get favoriteList => _favoriteList;
  List<bool> get tempList => _tempList;
  bool get isDelete => _isDelete;

  @override
  void onInit() {
    getFavoriteList();
    _isDelete = false;
    _tempList = List.filled(_favoriteList.length, true);
    super.onInit();
  }

  @override
  void dispose() {
    FavoriteController().dispose();
    super.dispose();
  }

  ///add temp List
  void addToTemp(bool value) {
    try {
      isLoading(true);
      _tempList = List.filled(
        favoriteList.length,
        value,
      );
    } finally {
      isLoading(false);
    }
  }

  ///add remove List
  void removeFromTemp(int value) {
    try {
      isLoading(true);
      _tempList[value] = !_tempList[value];
    } finally {
      isLoading(false);
    }
  }

  ///temp List
  void showDelete() {
    try {
      isLoading(true);
      _isDelete = !_isDelete;
    } finally {
      isLoading(false);
    }
  }

  ///favorite
  void addToFavorite(ProductList tempModel) async {
    //for adding existing items to the cart and increase quantity
    var isExist =
        _favoriteList.indexWhere((element) => element.id == tempModel.id!);
    log('Exist : $isExist');
    if (isExist >= 0) {
      removeFromFavorite(tempModel.id!);
      log('delete from favorite!');
    } else {
      var product = jsonEncode(tempModel);
      //for adding new items to the cart
      FavoriteModel rpFavoriteModel = FavoriteModel(
        id: tempModel.id,
        product: product);
      _databaseHelper.insertFavorite(rpFavoriteModel);
      var result = await _databaseHelper.getAllFavorite();
      if (result.isNotEmpty) {
        _favoriteList.assignAll(result);
        getFavoriteList();
      }
    }
  }

  Future<void> removeFromFavorite(int id) async {
    try {
      isLoading(true);
      await _databaseHelper.deleteFavorite(id);
      getFavoriteList();
    } finally {
      isLoading(false);
      update();
    }
  }

  ///Get  all Favorite
  Future<void> getFavoriteList() async {
    try {
      isLoading(true);
      var product = await _databaseHelper.getAllFavorite();
      _favoriteList.assignAll(product);
      update();
    } finally {
      isLoading(false);
      update();
    }
  }

  /// remove Favorite list
  void removeFavoriteList() async {
    try {
      isLoading(true);
      await _databaseHelper.emptyFavoriteList();
      await getFavoriteList();
    } finally {
      isLoading(false);
    }
  }

  bool isAlreadyAdd(int id) {
    try {
      isLoading(true);
      var isExist = _favoriteList.indexWhere((element) => element.id == id);
      log('Exist : $isExist');
      if (isExist >= 0) {
        return true;
      } else {
        return false;
      }
    } finally {
      isLoading(false);
    }
  }

  void showBottomLoader() {
    isLoading(true);
    update();
  }
}
