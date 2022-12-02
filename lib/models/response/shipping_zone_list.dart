class ShippingZoneList {
  ShippingZoneList({
    int? id,
    String? name,
    int? order,
  }) {
    _id = id;
    _name = name;
    _order = order;
  }

  ShippingZoneList.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _order = json['order'];
  }
  int? _id;
  String? _name;
  int? _order;

  int? get id => _id;
  String? get name => _name;
  int? get order => _order;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['order'] = _order;
    return map;
  }
}
