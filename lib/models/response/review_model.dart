import 'package:woogoods/models/response/product_list.dart';

class ReviewModel {
  ReviewModel({
    int? id,
    String? dateCreated,
    String? dateCreatedGmt,
    int? productId,
    String? status,
    String? reviewer,
    String? reviewerEmail,
    String? review,
    int? rating,
    bool? verified,
    ReviewerAvatarUrls? reviewerAvatarUrls,
    ProductList? productList,
  }) {
    _id = id;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _productId = productId;
    _status = status;
    _reviewer = reviewer;
    _reviewerEmail = reviewerEmail;
    _review = review;
    _rating = rating;
    _verified = verified;
    _reviewerAvatarUrls = reviewerAvatarUrls;
    _productList = productList;
  }

  ReviewModel.fromJson(dynamic json) {
    _id = json['id'];
    _dateCreated = json['date_created'];
    _dateCreatedGmt = json['date_created_gmt'];
    _productId = json['product_id'];
    _status = json['status'];
    _reviewer = json['reviewer'];
    _reviewerEmail = json['reviewer_email'];
    _review = json['review'];
    _rating = json['rating'];
    _verified = json['verified'];
    _reviewerAvatarUrls = json['reviewer_avatar_urls'] != null ? ReviewerAvatarUrls.fromJson(json['reviewer_avatar_urls']) : null;
    _productList = json['productList'] != null ? ProductList.fromJson(json['productList']) : null;
  }
  int? _id;
  String? _dateCreated;
  String? _dateCreatedGmt;
  int? _productId;
  String? _status;
  String? _reviewer;
  String? _reviewerEmail;
  String? _review;
  int? _rating;
  bool? _verified;
  ReviewerAvatarUrls? _reviewerAvatarUrls;
  ProductList? _productList;

  int? get id => _id;
  String? get dateCreated => _dateCreated;
  String? get dateCreatedGmt => _dateCreatedGmt;
  int? get productId => _productId;
  String? get status => _status;
  String? get reviewer => _reviewer;
  String? get reviewerEmail => _reviewerEmail;
  String? get review => _review;
  int? get rating => _rating;
  bool? get verified => _verified;
  ReviewerAvatarUrls? get reviewerAvatarUrls => _reviewerAvatarUrls;
  ProductList? get productList => _productList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date_created'] = _dateCreated;
    map['date_created_gmt'] = _dateCreatedGmt;
    map['product_id'] = _productId;
    map['status'] = _status;
    map['reviewer'] = _reviewer;
    map['reviewer_email'] = _reviewerEmail;
    map['review'] = _review;
    map['rating'] = _rating;
    map['verified'] = _verified;
    if (_reviewerAvatarUrls != null) {map['reviewer_avatar_urls'] = _reviewerAvatarUrls?.toJson();}
    if (_productList != null) {map['productList'] = _productList?.toJson();}
    return map;
  }
}

class ReviewerAvatarUrls {
  ReviewerAvatarUrls({
    String? firstImage,
    String? secondImage,
    String? thirdImage,
  }) {
    _firstImage = firstImage;
    _secondImage = secondImage;
    _thirdImage = thirdImage;
  }

  ReviewerAvatarUrls.fromJson(dynamic json) {
    _firstImage = json['24'];
    _secondImage = json['48'];
    _thirdImage = json['96'];
  }
  String? _firstImage;
  String? _secondImage;
  String? _thirdImage;

  String? get firstImage => _firstImage;
  String? get secondImage => _secondImage;
  String? get thirdImage => _thirdImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['24'] = _firstImage;
    map['48'] = _secondImage;
    map['96'] = _thirdImage;
    return map;
  }
}
