import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/services/api/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:woogoods/services/api/app_config.dart';

class ReviewRepo {
  final ApiClient apiClient;

  ReviewRepo({
    required this.apiClient,
  });

  Future<http.Response> getReviewList({
    String id = '0',
  }) async {
    var url = reviewList + '?product=$id&$authCCToken&';

    return await apiClient.getData(url);
  }

  Future<http.Response> getAllReviewList({
    String offset = '1',
  }) async {
    var url = reviewList + '?per_page=10&page=$offset&$authCCToken&';
    return await apiClient.getData(url);
  }
}
