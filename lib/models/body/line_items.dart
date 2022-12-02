class LineItems {
  LineItems({
      int? productId, 
      int? quantity, 
      List<MetaCartData>? metaData,}){
    _productId = productId;
    _quantity = quantity;
    _metaData = metaData;
}

  LineItems.fromJson(dynamic json) {
    _productId = json['product_id'];
    _quantity = json['quantity'];
    if (json['meta_data'] != null) {
      _metaData = [];
      json['meta_data'].forEach((v) {
        _metaData?.add(MetaCartData.fromJson(v));
      });
    }
  }
  int? _productId;
  int? _quantity;
  List<MetaCartData>? _metaData;

  int? get productId => _productId;
  int? get quantity => _quantity;
  List<MetaCartData>? get metaData => _metaData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['quantity'] = _quantity;
    if (_metaData != null) {
      map['meta_data'] = _metaData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class MetaCartData {
  MetaCartData({
      String? key, 
      String? value,}){
    _key = key;
    _value = value;
}

  MetaCartData.fromJson(dynamic json) {
    _key = json['key'];
    _value = json['value'];
  }
  String? _key;
  String? _value;

  String? get key => _key;
  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['key'] = _key;
    map['value'] = _value;
    return map;
  }
}