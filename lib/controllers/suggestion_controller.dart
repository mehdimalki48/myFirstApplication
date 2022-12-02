import 'dart:developer';
import 'package:get/get.dart';
import 'package:woogoods/helper/sqlite_db_helper.dart';
import 'package:woogoods/models/response/suggestion_model.dart';

class SuggestionController extends GetxController {
  //Init model
  final List<SuggestionModel> _suggestionList = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;
  //Init
  var isLoading = false.obs;

  ///Encapsulation
  List<SuggestionModel> get suggestionList => _suggestionList;

  ///Suggestion
  void addToSuggestion(String title) async {
    //for adding existing items to the cart and increase quantity
    var isExist =
        _suggestionList.indexWhere((element) => element.title == title);
    log('Exist : $isExist');
    if (isExist >= 0) {
      log('already in suggestion!');
    } else {
      //for adding new items to the cart
      SuggestionModel rpShopFavoriteModel = SuggestionModel(
        // id: rpSingleFavoriteModel.id,
        title: title,
      );
      _databaseHelper.insertSuggestion(rpShopFavoriteModel);

      var result = await _databaseHelper.getAllSuggestions();
      if (result.isNotEmpty) {
        _suggestionList.assignAll(result);
        getSuggestionList();
      }
    }
  }

  Future<void> removeFromSuggestion(String id) async {
    try {
      isLoading(true);
      await _databaseHelper.deleteSuggestion(id);
      getSuggestionList();
    } finally {
      isLoading(false);
      update();
    }
  }

  ///Get  all Suggestion
  Future<void> getSuggestionList() async {
    try {
      isLoading(true);
      var product = await _databaseHelper.getAllSuggestions();
      _suggestionList.assignAll(product);
    } finally {
      isLoading(false);
      update();
    }
  }

  /// remove suggestion list
  void removeSuggestionList() async {
    try {
      isLoading(true);
      await _databaseHelper.emptySuggestionList();
      await getSuggestionList();
    } finally {
      isLoading(false);
    }
  }

  bool isAlreadyAdd(int id) {
    var isExist = _suggestionList.indexWhere((element) => element.id == id);
    log('Exist : $isExist');
    if (isExist >= 0) {
      return true;
    } else {
      return false;
    }
  }

  void showBottomLoader() {
    isLoading(true);
    update();
  }
}
