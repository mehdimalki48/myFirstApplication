class CartModel {
  CartModel({
    int? id,
    int? price,
    int? quantity,
    String? product,
    String? title,
    String? image,
    String? variations,
    String? brand,
  }) {
    _id = id;
    _price = price;
    _quantity = quantity;
    _title = title;
    _image = image;
    _variations = variations;
    _brand = brand;
    _product = product;
  }

  CartModel.fromJson(dynamic json) {
    _id = json['id'];
    _price = json['price'];
    _quantity = json['quantity'];
    _title = json['title'];
    _image = json['image'];
    _variations = json['variations'];
    _brand = json['brand'];
    _product = json['product'];
  }
  int? _id;
  int? _price;
  int? _quantity;
  String? _title;
  String? _image;
  String? _brand;
  String? _variations;
  String? _product;

  int? get id => _id;
  int? get price => _price;
  int? get quantity => _quantity;
  String? get title => _title;
  String? get image => _image;
  String? get brand => _brand;
  String? get variations => _variations;
  String? get product => _product;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['price'] = _price;
    map['quantity'] = _quantity;
    map['title'] = _title;
    map['image'] = _image;
    map['brand'] = _brand;
    map['variations'] = _variations;
    map['product'] = _product;
    return map;
  }
}
