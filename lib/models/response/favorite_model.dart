class FavoriteModel {
  FavoriteModel({
    int? id,
    String? product,
  }) {
    _id = id;
    _product = product;
  }

  FavoriteModel.fromJson(dynamic json) {
    _id = json['id'];
    _product = json['product'];
  }
  int? _id;
  String? _product;

  int? get id => _id;
  String? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['product'] = _product;
    return map;
  }
}