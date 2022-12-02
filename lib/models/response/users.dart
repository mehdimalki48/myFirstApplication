class Users {
  Users({
    int? id,
    String? username,
    String? name,
    String? firstName,
    String? lastName,
    String? email,
    String? url,
    String? description,
    String? link,
    String? locale,
    String? nickname,
    String? slug,
    List<String>? roles,
    String? registeredDate,
    Capabilities? capabilities,
    ExtraCapabilities? extraCapabilities,
    AvatarUrls? avatarUrls,
  }) {
    _id = id;
    _username = username;
    _name = name;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _url = url;
    _description = description;
    _link = link;
    _locale = locale;
    _nickname = nickname;
    _slug = slug;
    _roles = roles;
    _registeredDate = registeredDate;
    _capabilities = capabilities;
    _extraCapabilities = extraCapabilities;
    _avatarUrls = avatarUrls;
  }

  Users.fromJson(dynamic json) {
    _id = json['id'];
    _username = json['username'];
    _name = json['name'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _email = json['email'];
    _url = json['url'];
    _description = json['description'];
    _link = json['link'];
    _locale = json['locale'];
    _nickname = json['nickname'];
    _slug = json['slug'];
    _roles = json['roles'] != null ? json['roles'].cast<String>() : [];
    _registeredDate = json['registered_date'];
    _capabilities = json['capabilities'] != null
        ? Capabilities.fromJson(json['capabilities'])
        : null;
    _extraCapabilities = json['extra_capabilities'] != null
        ? ExtraCapabilities.fromJson(json['extraCapabilities'])
        : null;
    _avatarUrls = json['avatar_urls'] != null
        ? AvatarUrls.fromJson(json['avatar_urls'])
        : null;
  }
  int? _id;
  String? _username;
  String? _name;
  String? _firstName;
  String? _lastName;
  String? _email;
  String? _url;
  String? _description;
  String? _link;
  String? _locale;
  String? _nickname;
  String? _slug;
  List<String>? _roles;
  String? _registeredDate;
  Capabilities? _capabilities;
  ExtraCapabilities? _extraCapabilities;
  AvatarUrls? _avatarUrls;

  int? get id => _id;
  String? get username => _username;
  String? get name => _name;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get email => _email;
  String? get url => _url;
  String? get description => _description;
  String? get link => _link;
  String? get locale => _locale;
  String? get nickname => _nickname;
  String? get slug => _slug;
  List<String>? get roles => _roles;
  String? get registeredDate => _registeredDate;
  Capabilities? get capabilities => _capabilities;
  ExtraCapabilities? get extraCapabilities => _extraCapabilities;
  AvatarUrls? get avatarUrls => _avatarUrls;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['username'] = _username;
    map['name'] = _name;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['email'] = _email;
    map['url'] = _url;
    map['description'] = _description;
    map['link'] = _link;
    map['locale'] = _locale;
    map['nickname'] = _nickname;
    map['slug'] = _slug;
    map['roles'] = _roles;
    map['registered_date'] = _registeredDate;
    if (_capabilities != null) {
      map['capabilities'] = _capabilities?.toJson();
    }
    if (_extraCapabilities != null) {
      map['extra_capabilities'] = _extraCapabilities?.toJson();
    }
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

class ExtraCapabilities {
  ExtraCapabilities({
    bool? subscriber,
  }) {
    _subscriber = subscriber;
  }

  ExtraCapabilities.fromJson(dynamic json) {
    _subscriber = json['subscriber'];
  }
  bool? _subscriber;

  bool? get subscriber => _subscriber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subscriber'] = _subscriber;
    return map;
  }
}

class Capabilities {
  Capabilities({
    bool? read,
    bool? level0,
    bool? subscriber,
  }) {
    _read = read;
    _level0 = level0;
    _subscriber = subscriber;
  }

  Capabilities.fromJson(dynamic json) {
    _read = json['read'];
    _level0 = json['level_0'];
    _subscriber = json['subscriber'];
  }
  bool? _read;
  bool? _level0;
  bool? _subscriber;

  bool? get read => _read;
  bool? get level0 => _level0;
  bool? get subscriber => _subscriber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['read'] = _read;
    map['level_0'] = _level0;
    map['subscriber'] = _subscriber;
    return map;
  }
}
