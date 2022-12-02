import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:woogoods/models/response/review_model.dart';
import 'package:woogoods/services/api/api_checker.dart';
import 'package:woogoods/services/repository/review_repo.dart';

class ReviewController extends GetxController {
  final ReviewRepo reviewRepo;
  ReviewController({
    required this.reviewRepo,
  });
  //Init model
  List<ReviewModel> reviewList = [];
  //Init
  var isLoading = false.obs;

  Future<void> fetchReviewList({
    required String id,
  }) async {
    try {
      isLoading(true);
      log('=================>> review log');
      final response = await reviewRepo.getReviewList(id: id);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<ReviewModel> posts = body
            .map(
              (dynamic item) => ReviewModel.fromJson(item),
            )
            .toList();
        log(response.body);
        reviewList.assignAll(posts);
      } else {
        isLoading(false);
        ApiChecker.checkApi(response);
      }
    } finally {
      isLoading(false);
    }
  }
}
