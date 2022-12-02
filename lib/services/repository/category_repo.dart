import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/services/api/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:woogoods/services/api/app_config.dart';

class CategoryRepo {
  final ApiClient apiClient;

  CategoryRepo({
    required this.apiClient,
  });

  Future<http.Response> getParentCategoryList({
    String parent = '0',
    String perPage = '100',
    String order = 'desc',
    bool isSubCat = false,
  }) async {
    var url = categoryList + '?per_page=$perPage&parent=$parent&$authCCToken&';
    if(parent == '0'){
      url += 'hide_empty=true&orderby=id&';
    }
    if (isSubCat) {
      url += 'display=subcategories&';
    }

    return await apiClient.getData(url);
  }
}
