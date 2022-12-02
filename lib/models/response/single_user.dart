class SingleUser {
  SingleUser({
    int? id,
    String? name,
    String? url,
    String? description,
    String? link,
    String? slug,
    AvatarUrls? avatarUrls,
  }) {
    _id = id;
    _name = name;
    _url = url;
    _description = description;
    _link = link;
    _slug = slug;
    _avatarUrls = avatarUrls;
  }

  SingleUser.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _url = json['url'];
    _description = json['description'];
    _link = json['link'];
    _slug = json['slug'];
    _avatarUrls = json['avatar_urls'] != null
        ? AvatarUrls.fromJson(json['avatar_urls'])
        : null;
  }
  int? _id;
  String? _name;
  String? _url;
  String? _description;
  String? _link;
  String? _slug;
  AvatarUrls? _avatarUrls;

  int? get id => _id;
  String? get name => _name;
  String? get url => _url;
  String? get description => _description;
  String? get link => _link;
  String? get slug => _slug;
  AvatarUrls? get avatarUrls => _avatarUrls;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['url'] = _url;
    map['description'] = _description;
    map['link'] = _link;
    map['slug'] = _slug;
    if (_avatarUrls != null) {
      map['avatar_urls'] = _avatarUrls?.toJson();
    }
    return map;
  }
}

class AvatarUrls {
  AvatarUrls({
    String? image24,
    String? image48,
    String? image96,
  }) {
    _image24 = image24;
    _image48 = image48;
    _image96 = image96;
  }

  AvatarUrls.fromJson(dynamic json) {
    _image24 = json['24'];
    _image48 = json['48'];
    _image96 = json['96'];
  }
  String? _image24;
  String? _image48;
  String? _image96;

  String? get image24 => _image24;
  String? get image48 => _image48;
  String? get image96 => _image96;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['24'] = _image24;
    map['48'] = _image48;
    map['96'] = _image96;
    return map;
  }
}
