class ShippingMethodList {
  ShippingMethodList({
    int? id,
    int? instanceId,
    String? title,
    int? order,
    bool? enabled,
    String? methodId,
    String? methodTitle,
    String? methodDescription,
    Settings? settings,
  }) {
    _id = id;
    _instanceId = instanceId;
    _title = title;
    _order = order;
    _enabled = enabled;
    _methodId = methodId;
    _methodTitle = methodTitle;
    _methodDescription = methodDescription;
    _settings = settings;
  }

  ShippingMethodList.fromJson(dynamic json) {
    _id = json['id'];
    _instanceId = json['instance_id'];
    _title = json['title'];
    _order = json['order'];
    _enabled = json['enabled'];
    _methodId = json['method_id'];
    _methodTitle = json['method_title'];
    _methodDescription = json['method_description'];
    _settings =
        json['settings'] != null ? Settings.fromJson(json['settings']) : null;
  }
  int? _id;
  int? _instanceId;
  String? _title;
  int? _order;
  bool? _enabled;
  String? _methodId;
  String? _methodTitle;
  String? _methodDescription;
  Settings? _settings;

  int? get id => _id;
  int? get instanceId => _instanceId;
  String? get title => _title;
  int? get order => _order;
  bool? get enabled => _enabled;
  String? get methodId => _methodId;
  String? get methodTitle => _methodTitle;
  String? get methodDescription => _methodDescription;
  Settings? get settings => _settings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['instance_id'] = _instanceId;
    map['title'] = _title;
    map['order'] = _order;
    map['enabled'] = _enabled;
    map['method_id'] = _methodId;
    map['method_title'] = _methodTitle;
    map['method_description'] = _methodDescription;
    if (_settings != null) {
      map['settings'] = _settings?.toJson();
    }
    return map;
  }
}

class Settings {
  Settings({
    Title? title,
    Cost? cost,
  }) {
    _title = title;
    _cost = cost;
  }

  Settings.fromJson(dynamic json) {
    _title = json['title'] != null ? Title.fromJson(json['title']) : null;
    _cost = json['cost'] != null ? Cost.fromJson(json['cost']) : null;
  }
  Title? _title;
  Cost? _cost;

  Title? get title => _title;
  Cost? get cost => _cost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_title != null) {
      map['title'] = _title?.toJson();
    }
    if (_cost != null) {
      map['cost'] = _cost?.toJson();
    }
    return map;
  }
}

class Cost {
  Cost({
    String? id,
    String? label,
    String? description,
    String? type,
    String? value,
    String? tip,
    String? placeholder,
  }) {
    _id = id;
    _label = label;
    _description = description;
    _type = type;
    _value = value;
    _tip = tip;
    _placeholder = placeholder;
  }

  Cost.fromJson(dynamic json) {
    _id = json['id'];
    _label = json['label'];
    _description = json['description'];
    _type = json['type'];
    _value = json['value'];
    _tip = json['tip'];
    _placeholder = json['placeholder'];
  }
  String? _id;
  String? _label;
  String? _description;
  String? _type;
  String? _value;
  String? _tip;
  String? _placeholder;

  String? get id => _id;
  String? get label => _label;
  String? get description => _description;
  String? get type => _type;
  String? get value => _value;
  String? get tip => _tip;
  String? get placeholder => _placeholder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['label'] = _label;
    map['description'] = _description;
    map['type'] = _type;
    map['value'] = _value;
    map['tip'] = _tip;
    map['placeholder'] = _placeholder;
    return map;
  }
}

class Options {
  Options({
    String? taxable,
    String? none,
  }) {
    _taxable = taxable;
    _none = none;
  }

  Options.fromJson(dynamic json) {
    _taxable = json['taxable'];
    _none = json['none'];
  }
  String? _taxable;
  String? _none;

  String? get taxable => _taxable;
  String? get none => _none;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['taxable'] = _taxable;
    map['none'] = _none;
    return map;
  }
}

class Title {
  Title({
    String? id,
    String? label,
    String? description,
    String? type,
    String? value,
    String? tip,
    String? placeholder,
  }) {
    _id = id;
    _label = label;
    _description = description;
    _type = type;
    _value = value;
    _tip = tip;
    _placeholder = placeholder;
  }

  Title.fromJson(dynamic json) {
    _id = json['id'];
    _label = json['label'];
    _description = json['description'];
    _type = json['type'];
    _value = json['value'];
    _tip = json['tip'];
    _placeholder = json['placeholder'];
  }
  String? _id;
  String? _label;
  String? _description;
  String? _type;
  String? _value;
  String? _tip;
  String? _placeholder;

  String? get id => _id;
  String? get label => _label;
  String? get description => _description;
  String? get type => _type;
  String? get value => _value;
  String? get tip => _tip;
  String? get placeholder => _placeholder;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['label'] = _label;
    map['description'] = _description;
    map['type'] = _type;
    map['value'] = _value;
    map['tip'] = _tip;
    map['placeholder'] = _placeholder;
    return map;
  }
}
