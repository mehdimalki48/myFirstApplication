class CouponListRp {
  CouponListRp({
    int? id,
    String? code,
    String? amount,
    String? dateCreated,
    String? dateCreatedGmt,
    String? dateModified,
    String? dateModifiedGmt,
    String? discountType,
    String? description,
    String? dateExpires,
    String? dateExpiresGmt,
    int? usageCount,
    bool? individualUse,
    int? usageLimit,
    int? usageLimitPerUser,
    int? limitUsageToXItems,
    bool? freeShipping,
    bool? excludeSaleItems,
    String? minimumAmount,
    String? maximumAmount,
    List<String>? usedBy,
  }) {
    _id = id;
    _code = code;
    _amount = amount;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _dateModified = dateModified;
    _dateModifiedGmt = dateModifiedGmt;
    _discountType = discountType;
    _description = description;
    _dateExpires = dateExpires;
    _dateExpiresGmt = dateExpiresGmt;
    _usageCount = usageCount;
    _individualUse = individualUse;
    _usageLimit = usageLimit;
    _usageLimitPerUser = usageLimitPerUser;
    _limitUsageToXItems = limitUsageToXItems;
    _freeShipping = freeShipping;
    _excludeSaleItems = excludeSaleItems;
    _minimumAmount = minimumAmount;
    _maximumAmount = maximumAmount;
    _usedBy = usedBy;
  }

  CouponListRp.fromJson(dynamic json) {
    _id = json['id'];
    _code = json['code'];
    _amount = json['amount'];
    _dateCreated = json['date_created'];
    _dateCreatedGmt = json['date_created_gmt'];
    _dateModified = json['date_modified'];
    _dateModifiedGmt = json['date_modified_gmt'];
    _discountType = json['discount_type'];
    _description = json['description'];
    _dateExpires = json['date_expires'];
    _dateExpiresGmt = json['date_expires_gmt'];
    _usageCount = json['usage_count'];
    _individualUse = json['individual_use'];
    _usageLimit = json['usage_limit'];
    _usageLimitPerUser = json['usage_limit_per_user'];
    _limitUsageToXItems = json['limit_usage_to_x_items'];
    _freeShipping = json['free_shipping'];
    _excludeSaleItems = json['exclude_sale_items'];
    _minimumAmount = json['minimum_amount'];
    _maximumAmount = json['maximum_amount'];
    _usedBy = json['used_by'] != null ? json['used_by'].cast<String>() : [];
  }
  int? _id;
  String? _code;
  String? _amount;
  String? _dateCreated;
  String? _dateCreatedGmt;
  String? _dateModified;
  String? _dateModifiedGmt;
  String? _discountType;
  String? _description;
  String? _dateExpires;
  String? _dateExpiresGmt;
  int? _usageCount;
  bool? _individualUse;
  int? _usageLimit;
  int? _usageLimitPerUser;
  int? _limitUsageToXItems;
  bool? _freeShipping;
  bool? _excludeSaleItems;
  String? _minimumAmount;
  String? _maximumAmount;
  List<String>? _usedBy;

  int? get id => _id;
  String? get code => _code;
  String? get amount => _amount;
  String? get dateCreated => _dateCreated;
  String? get dateCreatedGmt => _dateCreatedGmt;
  String? get dateModified => _dateModified;
  String? get dateModifiedGmt => _dateModifiedGmt;
  String? get discountType => _discountType;
  String? get description => _description;
  String? get dateExpires => _dateExpires;
  String? get dateExpiresGmt => _dateExpiresGmt;
  int? get usageCount => _usageCount;
  bool? get individualUse => _individualUse;
  int? get usageLimit => _usageLimit;
  int? get usageLimitPerUser => _usageLimitPerUser;
  int? get limitUsageToXItems => _limitUsageToXItems;
  bool? get freeShipping => _freeShipping;
  bool? get excludeSaleItems => _excludeSaleItems;
  String? get minimumAmount => _minimumAmount;
  String? get maximumAmount => _maximumAmount;
  List<String>? get usedBy => _usedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['code'] = _code;
    map['amount'] = _amount;
    map['date_created'] = _dateCreated;
    map['date_created_gmt'] = _dateCreatedGmt;
    map['date_modified'] = _dateModified;
    map['date_modified_gmt'] = _dateModifiedGmt;
    map['discount_type'] = _discountType;
    map['description'] = _description;
    map['date_expires'] = _dateExpires;
    map['date_expires_gmt'] = _dateExpiresGmt;
    map['usage_count'] = _usageCount;
    map['individual_use'] = _individualUse;
    map['usage_limit'] = _usageLimit;
    map['usage_limit_per_user'] = _usageLimitPerUser;
    map['limit_usage_to_x_items'] = _limitUsageToXItems;
    map['free_shipping'] = _freeShipping;
    map['exclude_sale_items'] = _excludeSaleItems;
    map['minimum_amount'] = _minimumAmount;
    map['maximum_amount'] = _maximumAmount;
    map['used_by'] = _usedBy;
    return map;
  }
}
