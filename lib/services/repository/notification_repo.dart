import 'package:http/http.dart';

import '../../constants/strings.dart';
import '../api/api_client.dart';

class NotificationRepo {
  final ApiClient apiClient;
  NotificationRepo({required this.apiClient});

  Future<Response> getNotificationList(String offset,
      {String perPage = '15',}) async {
    return await apiClient.getData(
        '?offset=$offset&limit=$perPage&app_id=$onesignalAppId', headers: addHeader(),);
  }


  ///Get current user header
  Map<String, String> addHeader() {
    Map<String, String> _mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic \u003c$onesignalRestKey\u003e',
    };
    return _mainHeaders;
  }
}
