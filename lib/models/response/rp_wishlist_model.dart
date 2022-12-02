class RpWishlistModel {
  RpWishlistModel({
    int? id,
    String? product,
  }) {
    _id = id;
    _product = product;
  }

  RpWishlistModel.fromJson(dynamic json) {
    _id = json['id'];
    _product = json['product'];
  }
  int? _id;
  String? _product;
  RpWishlistModel copyWith({
    int? id,
    String? product,
  }) =>
      RpWishlistModel(
        id: id ?? _id,
        product: product ?? _product,
      );
  int? get id => _id;
  String? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['product'] = _product;
    return map;
  }
}
