class OrderList {
  OrderList({
    int? id,
    int? parentId,
    String? status,
    String? currency,
    String? version,
    bool? pricesIncludeTax,
    String? dateCreated,
    String? dateModified,
    String? discountTotal,
    String? discountTax,
    String? shippingTotal,
    String? shippingTax,
    String? cartTax,
    String? total,
    String? totalTax,
    int? customerId,
    String? orderKey,
    Billing? billing,
    Shipping? shipping,
    String? paymentMethod,
    String? paymentMethodTitle,
    String? transactionId,
    String? customerIpAddress,
    String? customerUserAgent,
    String? createdVia,
    String? customerNote,
    dynamic dateCompleted,
    String? datePaid,
    String? cartHash,
    String? number,
    List<LineItems>? lineItems,
    List<ShippingLines>? shippingLines,
    String? dateCreatedGmt,
    String? dateModifiedGmt,
    String? dateCompletedGmt,
    String? datePaidGmt,
    String? currencySymbol,
  }) {
    _id = id;
    _parentId = parentId;
    _status = status;
    _currency = currency;
    _version = version;
    _pricesIncludeTax = pricesIncludeTax;
    _dateCreated = dateCreated;
    _dateModified = dateModified;
    _discountTotal = discountTotal;
    _discountTax = discountTax;
    _shippingTotal = shippingTotal;
    _shippingTax = shippingTax;
    _cartTax = cartTax;
    _total = total;
    _totalTax = totalTax;
    _customerId = customerId;
    _orderKey = orderKey;
    _billing = billing;
    _shipping = shipping;
    _paymentMethod = paymentMethod;
    _paymentMethodTitle = paymentMethodTitle;
    _transactionId = transactionId;
    _customerIpAddress = customerIpAddress;
    _customerUserAgent = customerUserAgent;
    _createdVia = createdVia;
    _customerNote = customerNote;
    _dateCompleted = dateCompleted;
    _datePaid = datePaid;
    _cartHash = cartHash;
    _number = number;
    _lineItems = lineItems;
    _shippingLines = shippingLines;
    _dateCreatedGmt = dateCreatedGmt;
    _dateModifiedGmt = dateModifiedGmt;
    _dateCompletedGmt = dateCompletedGmt;
    _datePaidGmt = datePaidGmt;
    _currencySymbol = currencySymbol;
  }

  OrderList.fromJson(dynamic json) {
    _id = json['id'];
    _parentId = json['parent_id'];
    _status = json['status'];
    _currency = json['currency'];
    _version = json['version'];
    _pricesIncludeTax = json['prices_include_tax'];
    _dateCreated = json['date_created'];
    _dateModified = json['date_modified'];
    _discountTotal = json['discount_total'];
    _discountTax = json['discount_tax'];
    _shippingTotal = json['shipping_total'];
    _shippingTax = json['shipping_tax'];
    _cartTax = json['cart_tax'];
    _total = json['total'];
    _totalTax = json['total_tax'];
    _customerId = json['customer_id'];
    _orderKey = json['order_key'];
    _billing =
        json['billing'] != null ? Billing.fromJson(json['billing']) : null;
    _shipping =
        json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    _paymentMethod = json['payment_method'];
    _paymentMethodTitle = json['payment_method_title'];
    _transactionId = json['transaction_id'];
    _customerIpAddress = json['customer_ip_address'];
    _customerUserAgent = json['customer_user_agent'];
    _createdVia = json['created_via'];
    _customerNote = json['customer_note'];
    _dateCompleted = json['date_completed'];
    _datePaid = json['date_paid'];
    _cartHash = json['cart_hash'];
    _number = json['number'];
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
    _dateCreatedGmt = json['date_created_gmt'];
    _dateModifiedGmt = json['date_modified_gmt'];
    _dateCompletedGmt = json['date_completed_gmt'];
    _datePaidGmt = json['date_paid_gmt'];
    _currencySymbol = json['currency_symbol'];
  }
  int? _id;
  int? _parentId;
  String? _status;
  String? _currency;
  String? _version;
  bool? _pricesIncludeTax;
  String? _dateCreated;
  String? _dateModified;
  String? _discountTotal;
  String? _discountTax;
  String? _shippingTotal;
  String? _shippingTax;
  String? _cartTax;
  String? _total;
  String? _totalTax;
  int? _customerId;
  String? _orderKey;
  Billing? _billing;
  Shipping? _shipping;
  String? _paymentMethod;
  String? _paymentMethodTitle;
  String? _transactionId;
  String? _customerIpAddress;
  String? _customerUserAgent;
  String? _createdVia;
  String? _customerNote;
  dynamic _dateCompleted;
  String? _datePaid;
  String? _cartHash;
  String? _number;
  List<LineItems>? _lineItems;
  List<ShippingLines>? _shippingLines;
  String? _dateCreatedGmt;
  String? _dateModifiedGmt;
  String? _dateCompletedGmt;
  String? _datePaidGmt;
  String? _currencySymbol;

  int? get id => _id;
  int? get parentId => _parentId;
  String? get status => _status;
  String? get currency => _currency;
  String? get version => _version;
  bool? get pricesIncludeTax => _pricesIncludeTax;
  String? get dateCreated => _dateCreated;
  String? get dateModified => _dateModified;
  String? get discountTotal => _discountTotal;
  String? get discountTax => _discountTax;
  String? get shippingTotal => _shippingTotal;
  String? get shippingTax => _shippingTax;
  String? get cartTax => _cartTax;
  String? get total => _total;
  String? get totalTax => _totalTax;
  int? get customerId => _customerId;
  String? get orderKey => _orderKey;
  Billing? get billing => _billing;
  Shipping? get shipping => _shipping;
  String? get paymentMethod => _paymentMethod;
  String? get paymentMethodTitle => _paymentMethodTitle;
  String? get transactionId => _transactionId;
  String? get customerIpAddress => _customerIpAddress;
  String? get customerUserAgent => _customerUserAgent;
  String? get createdVia => _createdVia;
  String? get customerNote => _customerNote;
  dynamic get dateCompleted => _dateCompleted;
  String? get datePaid => _datePaid;
  String? get cartHash => _cartHash;
  String? get number => _number;
  List<LineItems>? get lineItems => _lineItems;
  List<ShippingLines>? get shippingLines => _shippingLines;
  String? get dateCreatedGmt => _dateCreatedGmt;
  String? get dateModifiedGmt => _dateModifiedGmt;
  String? get dateCompletedGmt => _dateCompletedGmt;
  String? get datePaidGmt => _datePaidGmt;
  String? get currencySymbol => _currencySymbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['parent_id'] = _parentId;
    map['status'] = _status;
    map['currency'] = _currency;
    map['version'] = _version;
    map['prices_include_tax'] = _pricesIncludeTax;
    map['date_created'] = _dateCreated;
    map['date_modified'] = _dateModified;
    map['discount_total'] = _discountTotal;
    map['discount_tax'] = _discountTax;
    map['shipping_total'] = _shippingTotal;
    map['shipping_tax'] = _shippingTax;
    map['cart_tax'] = _cartTax;
    map['total'] = _total;
    map['total_tax'] = _totalTax;
    map['customer_id'] = _customerId;
    map['order_key'] = _orderKey;
    if (_billing != null) {
      map['billing'] = _billing?.toJson();
    }
    if (_shipping != null) {
      map['shipping'] = _shipping?.toJson();
    }
    map['payment_method'] = _paymentMethod;
    map['payment_method_title'] = _paymentMethodTitle;
    map['transaction_id'] = _transactionId;
    map['customer_ip_address'] = _customerIpAddress;
    map['customer_user_agent'] = _customerUserAgent;
    map['created_via'] = _createdVia;
    map['customer_note'] = _customerNote;
    map['date_completed'] = _dateCompleted;
    map['date_paid'] = _datePaid;
    map['cart_hash'] = _cartHash;
    map['number'] = _number;
    if (_lineItems != null) {
      map['line_items'] = _lineItems?.map((v) => v.toJson()).toList();
    }
    if (_shippingLines != null) {
      map['shipping_lines'] = _shippingLines?.map((v) => v.toJson()).toList();
    }
    map['date_created_gmt'] = _dateCreatedGmt;
    map['date_modified_gmt'] = _dateModifiedGmt;
    map['date_completed_gmt'] = _dateCompletedGmt;
    map['date_paid_gmt'] = _datePaidGmt;
    map['currency_symbol'] = _currencySymbol;
    return map;
  }
}

class ShippingLines {
  ShippingLines({
    int? id,
    String? methodTitle,
    String? methodId,
    String? instanceId,
    String? total,
    String? totalTax,
  }) {
    _id = id;
    _methodTitle = methodTitle;
    _methodId = methodId;
    _instanceId = instanceId;
    _total = total;
    _totalTax = totalTax;
  }

  ShippingLines.fromJson(dynamic json) {
    _id = json['id'];
    _methodTitle = json['method_title'];
    _methodId = json['method_id'];
    _instanceId = json['instance_id'];
    _total = json['total'];
    _totalTax = json['total_tax'];
  }
  int? _id;
  String? _methodTitle;
  String? _methodId;
  String? _instanceId;
  String? _total;
  String? _totalTax;

  int? get id => _id;
  String? get methodTitle => _methodTitle;
  String? get methodId => _methodId;
  String? get instanceId => _instanceId;
  String? get total => _total;
  String? get totalTax => _totalTax;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['method_title'] = _methodTitle;
    map['method_id'] = _methodId;
    map['instance_id'] = _instanceId;
    map['total'] = _total;
    map['total_tax'] = _totalTax;
    return map;
  }
}

class LineItems {
  LineItems({
    int? id,
    String? name,
    int? productId,
    int? variationId,
    int? quantity,
    String? taxClass,
    String? subtotal,
    String? subtotalTax,
    String? total,
    String? totalTax,
    String? sku,
    double? price,
  }) {
    _id = id;
    _name = name;
    _productId = productId;
    _variationId = variationId;
    _quantity = quantity;
    _taxClass = taxClass;
    _subtotal = subtotal;
    _subtotalTax = subtotalTax;
    _total = total;
    _totalTax = totalTax;
    _sku = sku;
    _price = price;
  }

  LineItems.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _productId = json['product_id'];
    _variationId = json['variation_id'];
    _quantity = json['quantity'];
    _taxClass = json['tax_class'];
    _subtotal = json['subtotal'];
    _subtotalTax = json['subtotal_tax'];
    _total = json['total'];
    _totalTax = json['total_tax'];
    _sku = json['sku'];
    _price = json['price'];
  }
  int? _id;
  String? _name;
  int? _productId;
  int? _variationId;
  int? _quantity;
  String? _taxClass;
  String? _subtotal;
  String? _subtotalTax;
  String? _total;
  String? _totalTax;
  String? _sku;
  dynamic _price;

  int? get id => _id;
  String? get name => _name;
  int? get productId => _productId;
  int? get variationId => _variationId;
  int? get quantity => _quantity;
  String? get taxClass => _taxClass;
  String? get subtotal => _subtotal;
  String? get subtotalTax => _subtotalTax;
  String? get total => _total;
  String? get totalTax => _totalTax;
  String? get sku => _sku;
  dynamic get price => _price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['product_id'] = _productId;
    map['variation_id'] = _variationId;
    map['quantity'] = _quantity;
    map['tax_class'] = _taxClass;
    map['subtotal'] = _subtotal;
    map['subtotal_tax'] = _subtotalTax;
    map['total'] = _total;
    map['total_tax'] = _totalTax;
    map['sku'] = _sku;
    map['price'] = _price;
    return map;
  }
}

class Shipping {
  Shipping({
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? state,
    String? postcode,
    String? country,
    String? phone,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _company = company;
    _address1 = address1;
    _address2 = address2;
    _city = city;
    _state = state;
    _postcode = postcode;
    _country = country;
    _phone = phone;
  }

  Shipping.fromJson(dynamic json) {
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _company = json['company'];
    _address1 = json['address_1'];
    _address2 = json['address_2'];
    _city = json['city'];
    _state = json['state'];
    _postcode = json['postcode'];
    _country = json['country'];
    _phone = json['phone'];
  }
  String? _firstName;
  String? _lastName;
  String? _company;
  String? _address1;
  String? _address2;
  String? _city;
  String? _state;
  String? _postcode;
  String? _country;
  String? _phone;

  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get company => _company;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get city => _city;
  String? get state => _state;
  String? get postcode => _postcode;
  String? get country => _country;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['company'] = _company;
    map['address_1'] = _address1;
    map['address_2'] = _address2;
    map['city'] = _city;
    map['state'] = _state;
    map['postcode'] = _postcode;
    map['country'] = _country;
    map['phone'] = _phone;
    return map;
  }
}

class Billing {
  Billing({
    String? firstName,
    String? lastName,
    String? company,
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
    _company = company;
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
    _company = json['company'];
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
  String? _company;
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
  String? get company => _company;
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
    map['company'] = _company;
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
