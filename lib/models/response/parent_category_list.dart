class ParentCategoryList {
  ParentCategoryList({
    int? id,
    String? name,
    String? slug,
    int? parent,
    String? description,
    String? display,
    Image? image,
    int? menuOrder,
    int? count,
  }) {
    _id = id;
    _name = name;
    _slug = slug;
    _parent = parent;
    _description = description;
    _display = display;
    _image = image;
    _menuOrder = menuOrder;
    _count = count;
  }

  ParentCategoryList.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _parent = json['parent'];
    _description = json['description'];
    _display = json['display'];
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _menuOrder = json['menu_order'];
    _count = json['count'];
  }
  int? _id;
  String? _name;
  String? _slug;
  int? _parent;
  String? _description;
  String? _display;
  Image? _image;
  int? _menuOrder;
  int? _count;

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  int? get parent => _parent;
  String? get description => _description;
  String? get display => _display;
  Image? get image => _image;
  int? get menuOrder => _menuOrder;
  int? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['parent'] = _parent;
    map['description'] = _description;
    map['display'] = _display;
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['menu_order'] = _menuOrder;
    map['count'] = _count;
    return map;
  }
}

class Image {
  Image({
    int? id,
    String? dateCreated,
    String? dateCreatedGmt,
    String? dateModified,
    String? dateModifiedGmt,
    String? src,
    String? title,
    String? alt,
  }) {
    _id = id;
    _dateCreated = dateCreated;
    _dateCreatedGmt = dateCreatedGmt;
    _dateModified = dateModified;
    _dateModifiedGmt = dateModifiedGmt;
    _src = src;
    _title = title;
    _alt = alt;
  }

  Image.fromJson(dynamic json) {
    _id = json['id'];
    _dateCreated = json['date_created'];
    _dateCreatedGmt = json['date_created_gmt'];
    _dateModified = json['date_modified'];
    _dateModifiedGmt = json['date_modified_gmt'];
    _src = json['src'];
    _title = json['title'];
    _alt = json['alt'];
  }
  int? _id;
  String? _dateCreated;
  String? _dateCreatedGmt;
  String? _dateModified;
  String? _dateModifiedGmt;
  String? _src;
  String? _title;
  String? _alt;

  int? get id => _id;
  String? get dateCreated => _dateCreated;
  String? get dateCreatedGmt => _dateCreatedGmt;
  String? get dateModified => _dateModified;
  String? get dateModifiedGmt => _dateModifiedGmt;
  String? get src => _src;
  String? get title => _title;
  String? get alt => _alt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date_created'] = _dateCreated;
    map['date_created_gmt'] = _dateCreatedGmt;
    map['date_modified'] = _dateModified;
    map['date_modified_gmt'] = _dateModifiedGmt;
    map['src'] = _src;
    map['title'] = _title;
    map['alt'] = _alt;
    return map;
  }
}
