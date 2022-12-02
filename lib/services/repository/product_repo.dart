import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/services/api/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:woogoods/services/api/app_config.dart';

class ProductRepo {
  final ApiClient apiClient;

  ProductRepo({
    required this.apiClient,
  });

  Future<http.Response> getProductList({
    bool onSale = false,
    bool feature = false,
    bool? order = true,
    String? orderBy,
    String offset = '1',
    String? parentId,
    String? search,
    String? minPrice,
    String? maxPrice,
    String? brandId,
  }) async {
    var url = productList + '?page=$offset&stock_status=instock&$authCCToken&';
    if (onSale == true) {
      url += 'on_sale=true&';
    }
    if (feature == true) {
      url += 'featured=$feature&';
    }
    if (parentId != null) {
      url += 'category=$parentId&';
    }
    if (order == false) {
      url += 'order=asc&';
    }
    if (orderBy != null) {
      url += 'orderby=$orderBy&';
    }
    if (search != null) {
      url += 'search=$search&';
    }
    if (brandId != null) {
      url += 'attribute=pa_brands&attribute_term=$brandId&';
    }
    if (minPrice != null && maxPrice != null) {
      url += 'min_price=$minPrice&max_price=$maxPrice&';
    } else {}
    return await apiClient.getData(url);
  }


  ///Home Repo
  //get slider data
  Future<http.Response> getSliderList({
    String offset = '1',
    String perPage = '20',
  }) async {
    var url = sliderListUri + '?page=$offset&per_page=$perPage&_embed&';
    return await apiClient.getData(url);
  }

  //get brand list
  Future<http.Response> getBrandList({
    String offset = '1',
    String perPage = '8',
  }) async {
    var url = brandListUri + '?per_page=$perPage&';
    return await apiClient.getData(url);
  }

  //get image from wordpress
  Future<http.Response> getWordpressImage(String id,) async {
    var url = kWordpressImageUri + '/$id?';
    return await apiClient.getData(url);
  }
}
