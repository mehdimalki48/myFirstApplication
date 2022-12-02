import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:woogoods/controllers/cart_controller.dart';

import '../models/body/line_items.dart';
import '../models/response/cart_model.dart';
import '../models/response/product_list.dart';

class OthersMethod {
  static void sharePost({
    required String title,
    String? subTitle,
    String? subject,
  }) {
    Share.share('$title ${subTitle ?? ''}', subject: subject ?? '');
  }

  static Future<dynamic> fetchTest() async {
    Map<String, String>? _mainHeaders = {
      'Accept': 'application/json;',
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var client = http.Client();
    var response = await client.get(
        Uri.parse('https://blog.speechtherapybd.com/wp-json/wp/v2/categories'),
        headers: _mainHeaders);
    if (response.statusCode == 200) {
      var posts = jsonDecode(response.body);
      log(response.statusCode.toString());
      log('====>' + posts.toString());
      return posts;
    } else {
      log(response.statusCode.toString());
      throw Exception('Fail to load');
    }
  }

  String postType(String type) {
    return type == 'true' ? 'news_fav' : 'magazine_fav';
  }

  ///get variation for cart data
  static String variationsShow(List<MetaCartData> variations) {
    String atr = '';
    for (int i = 0; i < variations.length; i++) {
      if ((variations[i].key ?? '') == 'pa_color') {
        atr = ', ${variations[i].value ?? ''}';
      }
      if ((variations[i].key ?? '') == 'Size') {
        atr += ', ${variations[i].value ?? ''}';
      }
    }
    return atr;
  }

  ///product price
  static int productPriceCalculate(ProductList product) {
    int finalPrice = 0;
    double price = (product.price!.isNotEmpty
        ? double.parse(product.price ?? '0.0')
        : double.parse(
            product.regularPrice == "" ? "0.0" : product.regularPrice!));
    finalPrice = price.toInt();
    return finalPrice;
  }

  static List<MetaCartData> getCartVariationList({String? variations}) {
    List<MetaCartData> variationsList = [];
    if (variations != null) {
      variationsList.clear();
      List<dynamic> body = jsonDecode(variations);
      List<MetaCartData> posts = body
          .map(
            (dynamic item) => MetaCartData.fromJson(item),
          )
          .toList();
      variationsList.addAll(posts);
    } else {
      variationsList = [];
    }
    return variationsList;
  }

  List<CartModel> setBuyNowData(
    ProductList product, {
    required int quantity,
    required int price,
    List<MetaCartData>? variations,
    String? brand,
  }) {
    List<CartModel> data = [];
    var productList = jsonEncode(product);
    var variationsList = jsonEncode(variations ?? '');
    //add model

    data.add(CartModel(
      id: product.id ?? 0,
      price: price,
      quantity: quantity,
      product: productList,
      title: product.name ?? '',
      brand: brand ?? 'No Brand',
      variations: variations != null ? variationsList : null,
      image:
          product.images![0].src != null ? product.images![0].src ?? '' : null,
    ));
    return data;
  }

  static List<MetaCartData> setVariationDataInCart(
      CartController cartController) {
    ///added variations
    List<MetaCartData> data = [];
    //added color
    if (!(cartController.colorSelected == '')) {
      data.add(MetaCartData(
        key: 'pa_color',
        value: cartController.colorSelected,
      ));
    }
    //added size
    if (!(cartController.sizeSelected == '')) {
      data.add(
        MetaCartData(
          key: 'Size',
          value: cartController.sizeSelected,
        ),
      );
    }
    return data;
  }

  ///check variations if null empty
  static bool variationsIsEmptyCheck(ProductList productDetailsController) {
    bool empty = false;
    for (int i = 0; i < productDetailsController.attributes!.length; i++) {
      if ((productDetailsController.attributes?[i].name ?? '') == 'color' ||
          (productDetailsController.attributes?[i].name ?? '') == 'size') {
        empty = true;
      }
    }
    return empty;
  }

  ///default variation setup
  static variationsSelected(ProductList productDetailsController) {
    Get.find<CartController>().updateCartQuantity(
      clear: true,
    );

    for (int i = 0; i < productDetailsController.attributes!.length; i++) {
      if ((productDetailsController.attributes?[i].name ?? '') == 'color') {
        Get.find<CartController>().updateCartColor(
            productDetailsController.attributes?[i].options![0] ?? '');
      }
      if ((productDetailsController.attributes?[i].name ?? '') == 'size') {
        Get.find<CartController>().updateCartSize(
            productDetailsController.attributes?[i].options![0] ?? '');
      }
      if ((productDetailsController.attributes?[i].name ?? '') == 'brands') {
        Get.find<CartController>().updateCartBrand(
            productDetailsController.attributes?[i].options![0] ?? '');
      }
    }
    log('test');
  }

  static String selectedBrands(ProductList productDetailsController) {
    String brand = 'No Brand';
    for (int i = 0; i < productDetailsController.attributes!.length; i++) {
      if ((productDetailsController.attributes?[i].name ?? '') == 'brands') {
        brand = productDetailsController.attributes?[i].options![0] ?? '';
      }
    }
    return brand;
  }
}
