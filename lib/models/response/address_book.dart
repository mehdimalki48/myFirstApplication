class AddressBook {
  AddressBook({
    int? id,
    String? firstName,
    String? lastName,
    String? address,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? labelAs,
    int? isSelect,
    String? email,
    String? phone,
    String? countyCode,
  }) {
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _address = address;
    _city = city;
    _state = state;
    _postcode = postcode;
    _country = country;
    _labelAs = labelAs;
    _isSelect = isSelect;
    _email = email;
    _phone = phone;
    _countyCode = countyCode;
  }

  AddressBook.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _address = json['address'];
    _city = json['city'];
    _state = json['state'];
    _postcode = json['postcode'];
    _country = json['country'];
    _labelAs = json['label_as'];
    _isSelect = json['is_select'];
    _email = json['email'];
    _phone = json['phone'];
    _countyCode = json['countyCode'];
  }
  int? _id;
  String? _firstName;
  String? _lastName;
  String? _address;
  String? _city;
  String? _state;
  String? _postcode;
  String? _country;
  String? _labelAs;
  int? _isSelect;
  String? _email;
  String? _phone;
  String? _countyCode;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get address => _address;
  String? get city => _city;
  String? get state => _state;
  String? get postcode => _postcode;
  String? get country => _country;
  String? get labelAs => _labelAs;
  int? get isSelect => _isSelect;
  String? get email => _email;
  String? get phone => _phone;
  String? get countyCode => _countyCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['address'] = _address;
    map['city'] = _city;
    map['state'] = _state;
    map['postcode'] = _postcode;
    map['country'] = _country;
    map['label_as'] = _labelAs;
    map['is_select'] = _isSelect;
    map['email'] = _email;
    map['phone'] = _phone;
    map['countyCode'] = _countyCode;
    return map;
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': _firstName,
      'last_name': _lastName,
      'address': _address,
      'city': _city,
      'state': _state,
      'postcode': _postcode,
      'country': _country,
      'label_as': _labelAs,
      'is_select': _isSelect,
      'email': _email,
      'phone': _phone,
      'countyCode': _countyCode,
    };
  }
}
