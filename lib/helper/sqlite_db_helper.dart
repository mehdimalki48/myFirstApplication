import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:woogoods/models/response/address_book.dart';
import 'package:woogoods/models/response/cart_model.dart';
import 'package:woogoods/models/response/recents_model.dart';
import 'package:woogoods/models/response/suggestion_model.dart';
import 'package:woogoods/services/api/app_config.dart';

import '../models/response/favorite_model.dart';

class DatabaseHelper {
  static const _dbName = '$appName.db';
  static const _suggestionTable = 'suggestion';
  static const _favoriteTable = 'favorite';
  static const _recentTable = 'recent';
  static const _tableCartName = 'cart';
  static const _addressTable = 'address_book';
  static const _dbVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initiateDatabase();
    return _database;
  }

  Future<Database> _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    var database = await openDatabase(path, version: _dbVersion,
        onCreate: (Database db, int version) async {
      ///suggestion table
      await db.execute('''
            CREATE TABLE $_suggestionTable(
             ${SuggestionColumn.columnTitle} TEXT
            
            )
            
        ''');

      ///new favorite table
      await db.execute('''
            CREATE TABLE $_favoriteTable(
             ${RecentColumn.columnId} INTEGER,
             ${RecentColumn.columnProducts} TEXT
            
            )
            
        ''');

      /*///favorite table
      await db.execute('''
            CREATE TABLE $_favoriteTable(
             ${FavouriteColumn.columnId} INTEGER,
             ${FavouriteColumn.columnName} TEXT,
             ${FavouriteColumn.columnDescription} TEXT,
             ${FavouriteColumn.columnSku} TEXT,
             ${FavouriteColumn.columnPrice} TEXT,
             ${FavouriteColumn.columnRegularPrice} TEXT,
             ${FavouriteColumn.columnSalePrice} TEXT,
             ${FavouriteColumn.columnAverageRating} TEXT,
             ${FavouriteColumn.columnRatingCount} INTEGER,
             ${FavouriteColumn.columnImage} TEXT,
             ${FavouriteColumn.columnStockStats} TEXT
            
            )
            
        ''');*/

      //Cart table
      await db.execute('''
            CREATE TABLE $_tableCartName(
            ${CartColumn.columnId} INTEGER,
            ${CartColumn.columnQty} INTEGER,
            ${CartColumn.price} INTEGER,
            ${CartColumn.columnImage} TEXT,
            ${CartColumn.columnTitle} TEXT,
            ${CartColumn.columnVariation} TEXT,
            ${CartColumn.columnBrand} TEXT,
            ${CartColumn.product} TEXT
            
            )
            
        ''');

      //Address book table
      await db.execute('''
            CREATE TABLE $_addressTable(
            ${AddressColumn.columnId} INTEGER PRIMARY KEY,
            ${AddressColumn.columnFirstName} TEXT,
            ${AddressColumn.columnLastName} TEXT,
            ${AddressColumn.columnAddress} TEXT,
            ${AddressColumn.columnCity} TEXT,
            ${AddressColumn.columnState} TEXT,
            ${AddressColumn.columnPostCode} TEXT,
            ${AddressColumn.columnCounty} TEXT,
            ${AddressColumn.columnLabel} TEXT,
            ${AddressColumn.columnIsSelect} INTEGER,
            ${AddressColumn.columnEmail} TEXT,
            ${AddressColumn.columnPhone} TEXT,
            ${AddressColumn.columnCountyCode} TEXT
            
            )
            
        ''');

      ///recent table
      await db.execute('''
            CREATE TABLE $_recentTable(
             ${RecentColumn.columnId} INTEGER,
             ${RecentColumn.columnProducts} TEXT
            
            )
            
        ''');
    });
    return database;
  }

  /// Favorite function start here ///

  ///Get All all row
  Future<List<FavoriteModel>> getAllFavorite() async {
    List<FavoriteModel> _products = [];
    Database? db = await instance.database;
    var results = await db!.query(_favoriteTable);
    for (var element in results) {
      var posts = FavoriteModel.fromJson(element);
      _products.add(posts);
    }
    return _products;
  }

  ///Insert row
  Future insertFavorite(FavoriteModel favoriteModel) async {
    Database? db = await instance.database;
    var result = await db!.insert(
      _favoriteTable,
      favoriteModel.toJson(),
    );
    log('result : $result');
  }

  ///Delete row
  Future<int> deleteFavorite(int id) async {
    Database? db = await instance.database;
    return await db!.delete(_favoriteTable,
        where: '${FavouriteColumn.columnId} = ?', whereArgs: [id]);
  }

  ///remove table
  Future<void> emptyFavoriteList() async {
    Database? db = await instance.database;
    db?.delete(_favoriteTable);
  }

  /// Favorite function end here ///

  /// Suggestion function start here ///

  ///Get All all row
  Future<List<SuggestionModel>> getAllSuggestions() async {
    List<SuggestionModel> _posts = [];
    Database? db = await instance.database;
    var results = await db!.query(_suggestionTable);
    for (var element in results) {
      var posts = SuggestionModel.fromJson(element);
      _posts.add(posts);
    }
    return _posts;
  }

  ///Insert row
  Future insertSuggestion(SuggestionModel suggestionModel) async {
    Database? db = await instance.database;
    var result = await db!.insert(
      _suggestionTable,
      suggestionModel.toJson(),
    );
    log('result : $result');
  }

  ///Delete row
  Future<int> deleteSuggestion(String id) async {
    Database? db = await instance.database;
    return await db!.delete(_suggestionTable,
        where: '${SuggestionColumn.columnTitle} = ?', whereArgs: [id]);
  }

  ///remove table
  Future<void> emptySuggestionList() async {
    Database? db = await instance.database;
    db?.delete(_suggestionTable);
  }

  /// Suggestion function end here ///
  /////////========Recent Functions=========//////////////////
  /// Recent function start here ///

  ///Get All all row
  Future<List<RecentPostModel>> getAllRecent() async {
    List<RecentPostModel> _products = [];
    Database? db = await instance.database;
    var results = await db!.query(_recentTable);
    for (var element in results) {
      var posts = RecentPostModel.fromJson(element);
      _products.add(posts);
    }
    return _products;
  }

  ///Insert row
  Future insertRecent(RecentPostModel recentModel) async {
    Database? db = await instance.database;
    var result = await db!.insert(
      _recentTable,
      recentModel.toJson(),
    );
    log('result : $result');
  }

  ///Delete row
  Future<int> deleteRecent(int id) async {
    Database? db = await instance.database;
    return await db!.delete(_recentTable,
        where: '${RecentColumn.columnId} = ?', whereArgs: [id]);
  }

  ///remove table
  Future<void> emptyRecentList() async {
    Database? db = await instance.database;
    db?.delete(_recentTable);
  }

  /// Favorite function end here ///
  //===
  //=======
  ///=----Start Cart ----=======////
  //Get All all row
  Future<List<CartModel>> getAllCartList() async {
    List<CartModel> _posts = [];
    Database? db = await instance.database;
    var results = await db!.query(_tableCartName);
    for (var element in results) {
      var posts = CartModel.fromJson(element);
      _posts.add(posts);
    }
    return _posts;
  }

  //Insert row
  Future insertCart(CartModel model) async {
    Database? db = await instance.database;
    var result = await db!.insert(
      _tableCartName,
      model.toJson(),
    );
    log('result : $result');
  }

  //Delete row
  Future<int> deleteCart(int id) async {
    Database? db = await instance.database;
    return await db!.delete(_tableCartName,
        where: '${CartColumn.columnId} = ?', whereArgs: [id]);
  }

  //update row
  Future updateCart(int id, int qty) async {
    Database? db = await instance.database;
    Map<String, dynamic> row = {
      CartColumn.columnQty: qty,
    };
    return await db?.update(_tableCartName, row,
        where: '${CartColumn.columnId} = ?', whereArgs: [id]);
  }

  //remove table
  Future<void> emptyShopCart() async {
    Database? db = await instance.database;
    db?.delete(_tableCartName);
  }

  ///=----End Cart ----=======////

  /// AddressBook function start here ///

  ///Get All all row
  Future<List<AddressBook>> getAllAddress() async {
    List<AddressBook> _products = [];
    Database? db = await instance.database;
    var results = await db!.query(_addressTable);
    for (var element in results) {
      var posts = AddressBook.fromJson(element);
      _products.add(posts);
    }
    return _products;
  }

  ///Insert row
  Future insertAddress(AddressBook model) async {
    Database? db = await instance.database;
    var result = await db!.insert(
      _addressTable,
      model.toJson(),
    );
    log('result : $result');
  }

  //update row
  Future updateAddress(int id, AddressBook model) async {
    Database? db = await instance.database;
    return await db?.update(_addressTable, model.toMap(),
        where: '${AddressColumn.columnId} = ?', whereArgs: [id]);
  }
  //update row

  Future updateIsSelectAddress(int id, int select) async {
    Database? db = await instance.database;
    Map<String, dynamic> row = {
      AddressColumn.columnIsSelect: select,
    };
    return await db?.update(_addressTable, row,
        where: '${AddressColumn.columnId} = ?', whereArgs: [id]);
  }

  ///Delete row
  Future<int> deleteAddress(int id) async {
    Database? db = await instance.database;
    return await db!.delete(_addressTable,
        where: '${AddressColumn.columnId} = ?', whereArgs: [id]);
  }

  ///remove table
  Future<void> emptyAddressList() async {
    Database? db = await instance.database;
    db?.delete(_addressTable);
  }

  /// AddressBook function end here ///
}

class FavouriteColumn {
  static const columnId = 'id';
  static const columnProduct = 'product';
  static const columnName = 'name';
  static const columnDescription = 'description';
  static const columnSku = 'sku';
  static const columnImage = 'image';
  static const columnPrice = 'price';
  static const columnSalePrice = 'sale_price';
  static const columnRegularPrice = 'regular_price';
  static const columnAverageRating = 'average_rating';
  static const columnRatingCount = 'rating_count';
  static const columnStockStats = 'stock_status';
}

class RecentColumn {
  static const columnId = 'id';
  static const columnProducts = 'product';
}

class SuggestionColumn {
  static const columnTitle = 'title';
  static const columnId = 'id';
}

class CartColumn {
  static const columnId = 'id';
  static const price = 'price';
  static const columnQty = 'quantity';
  static const columnImage = 'image';
  static const columnTitle = 'title';
  static const columnVariation = 'variations';
  static const columnBrand = 'brand';
  static const product = 'product';
}

class AddressColumn {
  static const columnId = 'id';
  static const columnFirstName = 'first_name';
  static const columnLastName = 'last_name';
  static const columnAddress = 'address';
  static const columnCity = 'city';
  static const columnState = 'state';
  static const columnPostCode = 'postcode';
  static const columnCounty = 'country';
  static const columnLabel = 'label_as';
  static const columnIsSelect = 'is_select';
  static const columnEmail = 'email';
  static const columnPhone = 'phone';
  static const columnCountyCode = 'countyCode';
}
