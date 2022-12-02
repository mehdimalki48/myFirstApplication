import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:woogoods/constants/style_data.dart';
import 'package:woogoods/models/response/product_list.dart';
import 'package:woogoods/services/api/api_checker.dart';
import 'package:woogoods/services/repository/product_details_repo.dart';

import '../models/response/review_model.dart';
import '../services/repository/review_repo.dart';

class HomeReviewController extends GetxController {
  final ReviewRepo reviewRepo;
  final ProductDetailsRepo productDetailsRepo;

  HomeReviewController({
    required this.reviewRepo,
    required this.productDetailsRepo,
  });

  //Init model
  List<ReviewModel> _reviewList = [];

  //Init
  bool _isLoading = false;
  bool _isShimmerLoading = true;
  bool _noMoreData = false;
  late int _popularPageSize;
  List<String> _offsetList = [];
  int _offset = 1;

  ///Encapsulation
  List<ReviewModel> get reviewList => _reviewList;

  bool get isLoading => _isLoading;

  bool get isShimmerLoading => _isShimmerLoading;
  bool get noMoreData => _noMoreData;

  int get popularPageSize => _popularPageSize;

  int get offset => _offset;

  void setOffset(int offset) {
    _offset = offset;
  }

  ///Get review
  Future<void> fetchAllReviews(
    String offset,
    bool reload,
  ) async {
    if (offset == '1' || reload) {
      _offsetList = [];
      _offset = 1;

      if (reload) {
        _reviewList = [];
        _isShimmerLoading = true;
      }
      update();
    }
    if (!_offsetList.contains(offset)) {
      _offsetList.add(offset);
      final response = await reviewRepo.getAllReviewList(
        offset: offset,
      );
      if (response.statusCode == 200) {
        if (offset == '1') {
          _reviewList = [];
        }
        log(response.body);

        List<dynamic> body = jsonDecode(response.body);
        List<ReviewModel> posts = body
            .map(
              (dynamic item) => ReviewModel.fromJson(item),
            )
            .toList();
        if (body.isEmpty) {
          if (offset == '1') {
            _isLoading = false;
            _isShimmerLoading = false;
            _noMoreData = false;
          } else {
            _noMoreData = true;
            showCustomSnackBar('No more review');
          }
          update();
        } else {

          for (int i = 0; i < posts.length; i++) {
            final response = await productDetailsRepo.getProductDetails(
              id: (posts[i].productId ?? 0).toString(),
            );
            var detailsResponse = jsonDecode(response.body);
            if (response.statusCode == 200) {
              ProductList products = ProductList.fromJson(detailsResponse);
              log(response.body);
              if (detailsResponse.isNotEmpty) {
                _reviewList.add(ReviewModel(
                  id: posts[i].id,
                  dateCreated: posts[i].dateCreated,
                  dateCreatedGmt: posts[i].dateCreatedGmt,
                  productId: posts[i].productId,
                  status: posts[i].status,
                  reviewer: posts[i].reviewer,
                  reviewerEmail: posts[i].reviewerEmail,
                  review: posts[i].review,
                  rating: posts[i].rating,
                  verified: posts[i].verified,
                  reviewerAvatarUrls: posts[i].reviewerAvatarUrls,
                  productList: products,
                ));
                log('=================>>product-details log');
              }

            } else {
              log(detailsResponse['message'].toString());
            }
            /*_reviewList.addAll(newProductsList);
            _popularPageSize = newProductsList.length;*/
            _isLoading = false;
            _isShimmerLoading = false;

            update();
          }
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } else {
      if (isLoading) {
        _isLoading = false;
        update();
      }
    }
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }
}
