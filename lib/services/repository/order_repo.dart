import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:woogoods/constants/strings.dart';
import 'package:woogoods/models/body/create_order.dart';
import 'package:woogoods/services/api/api_client.dart';
import 'package:woogoods/services/api/app_config.dart';

class OrdersRepo {
  final ApiClient apiClient;

  OrdersRepo({required this.apiClient});

  ///Fetch Magazine product
  Future<http.Response> createOrder({
    required CreateOrder createOrder,
    bool payment = false,
  }) async {
    var url = orderUri + '?$authCCToken&';
    var data = jsonEncode(createOrder);
    return await apiClient.postData(url, body: data);
  }

  Future<http.Response> getOrderList({
    String search = '',
    String status = 'any',
    String offset = '1',
    bool order = true,
    String? orderBy,
    required String customer,
    String? parentId,
    String? minPrice,
    String? maxPrice,
  }) async {
    var url = orderUri +
        '?page=$offset&status=$status&customer=$customer&$authCCToken&';
    return await apiClient.getData(
      url,
    );
  }

  Future<http.Response> getSingleOrder({required String id}) async {
    var url = orderUri + '/$id?$authCCToken&';
    return await apiClient.getData(
      url,
    );
  }

  Future<http.Response> getShippingZone() async {
    var url = shippingZoneUri + '?$authCCToken&';
    return await apiClient.getData(
      url,
    );
  }

  Future<http.Response> getShippingMethod({required String id}) async {
    var url = shippingZoneUri + '/$id/methods?$authCCToken&';
    return await apiClient.getData(
      url,
    );
  }
}
