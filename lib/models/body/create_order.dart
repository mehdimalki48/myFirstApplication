import 'package:woogoods/models/body/line_items.dart';

class CreateOrder {
  CreateOrder({
    String? paymentMethod,
    String? status,
    String? paymentMethodTitle,
    bool? setPaid,
    int? customerId,
    String? total,
    Billing? billing,
    Shipping? shipping,
    List<LineItems>? lineItems,
    List<ShippingLines>? shippingLines,
    List<CouponLines>? couponLines,
  }) {
    _paymentMethod = paymentMethod;
    _status = status;
    _paymentMethodTitle = paymentMethodTitle;
    _setPaid = setPaid;
    _customerId = customerId;
    _total = total;
    _billing = billing;
    _shipping = shipping;
    _lineItems = lineItems;
    _shippingLines = shippingLines;
    _couponLines = couponLines;
  }

  CreateOrder.fromJson(dynamic json) {
    _paymentMethod = json['payment_method'];
    _status = json['status'];
    _paymentMethodTitle = json['payment_method_title'];
    _setPaid = json['set_paid'];
    _customerId = json['customer_id'];
    _total = json['total'];
    _billing =
        json['billing'] != null ? Billing.fromJson(json['billing']) : null;
    _shipping =
        json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    if (json['line_items'] != null) {
      _lineItems = [];
      json['line_items'].forEach((v) {
        _lineItems?.add(LineItems.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      _shippingLines = [];
      json['shipping_lines'].forEach((v) {
        _shippingLines?.add(ShippingLines.fromJson(v));
      });
    }
    if (json['coupon_lines'] != null) {
      _couponLines = [];
      json['coupon_lines'].forEach((v) {
        _couponLines?.add(CouponLines.fromJson(v));
      });
    }
  }
  String? _paymentMethod;
  String? _status;
  String? _paymentMethodTitle;
  bool? _setPaid;
  int? _customerId;
  String? _total;
  Billing? _billing;
  Shipping? _shipping;
  List<LineItems>? _lineItems;
  List<ShippingLines>? _shippingLines;
  List<CouponLines>? _couponLines;

  String? get paymentMethod => _paymentMethod;
  String? get status => _status;
  String? get paymentMethodTitle => _paymentMethodTitle;
  bool? get setPaid => _setPaid;
  int? get customerId => _customerId;
  String? get total => _total;
  Billing? get billing => _billing;
  Shipping? get shipping => _shipping;
  List<LineItems>? get lineItems => _lineItems;
  List<ShippingLines>? get shippingLines => _shippingLines;
  List<CouponLines>? get couponLines => _couponLines;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['payment_method'] = _paymentMethod;
    map['status'] = _status;
    map['payment_method_title'] = _paymentMethodTitle;
    map['set_paid'] = _setPaid;
    map['customer_id'] = _customerId;
    map['total'] = _total;
    if (_billing != null) {
      map['billing'] = _billing?.toJson();
    }
    if (_shipping != null) {
      map['shipping'] = _shipping?.toJson();
    }
    if (_lineItems != null) {
      map['line_items'] = _lineItems?.map((v) => v.toJson()).toList();
    }
    if (_shippingLines != null) {
      map['shipping_lines'] = _shippingLines?.map((v) => v.toJson()).toList();
    }
    if (_couponLines != null) {
      map['coupon_lines'] = _couponLines?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CouponLines {
  CouponLines({
    String? code,
  }) {
    _code = code;
  }

  CouponLines.fromJson(dynamic json) {
    _code = json['code'];
  }
  String? _code;

  String? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    return map;
  }
}

class ShippingLines {
  ShippingLines({
    String? methodId,
    String? methodTitle,
    String? total,
  }) {
    _methodId = methodId;
    _methodTitle = methodTitle;
    _total = total;
  }

  ShippingLines.fromJson(dynamic json) {
    _methodId = json['method_id'];
    _methodTitle = json['method_title'];
    _total = json['total'];
  }
  String? _methodId;
  String? _methodTitle;
  String? _total;

  String? get methodId => _methodId;
  String? get methodTitle => _methodTitle;
  String? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['method_id'] = _methodId;
    map['method_title'] = _methodTitle;
    map['total'] = _total;
    return map;
  }
}

class MetaData {
  MetaData({
    String? key,
    String? value,}){
    _key = key;
    _value = value;
  }

  MetaData.fromJson(dynamic json) {
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

class Shipping {
  Shipping({
    String? firstName,
    String? lastName,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _state = state;
    _postcode = postcode;
    _country = country;
  }

  Shipping.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _address1 = json['address_1'];
    _address2 = json['address_2'];
    _city = json['city'];
    _state = json['state'];
    _postcode = json['postcode'];
    _country = json['country'];
  }
  String? _firstName;
  String? _lastName;
  String? _address1;
  String? _address2;
  String? _city;
  String? _state;
  String? _postcode;
  String? _country;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get city => _city;
  String? get state => _state;
  String? get postcode => _postcode;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['address_1'] = _address1;
    map['address_2'] = _address2;
    map['city'] = _city;
    map['state'] = _state;
    map['postcode'] = _postcode;
    map['country'] = _country;
    return map;
  }
}

class Billing {
  Billing({
    String? firstName,
    String? lastName,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? email,
    String? phone,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _state = state;
    _postcode = postcode;
    _country = country;
    _email = email;
    _phone = phone;
  }

  Billing.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _address1 = json['address_1'];
    _address2 = json['address_2'];
    _city = json['city'];
    _state = json['state'];
    _postcode = json['postcode'];
    _country = json['country'];
    _email = json['email'];
    _phone = json['phone'];
  }
  String? _firstName;
  String? _lastName;
  String? _address1;
  String? _address2;
  String? _city;
  String? _state;
  String? _postcode;
  String? _country;
  String? _email;
  String? _phone;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get city => _city;
  String? get state => _state;
  String? get postcode => _postcode;
  String? get country => _country;
  String? get email => _email;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['address_1'] = _address1;
    map['address_2'] = _address2;
    map['city'] = _city;
    map['state'] = _state;
    map['postcode'] = _postcode;
    map['country'] = _country;
    map['email'] = _email;
    map['phone'] = _phone;
    return map;
  }
}
