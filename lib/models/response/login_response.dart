class LoginResponse {
  LoginResponse({
    String? token,
    String? userEmail,
    String? userNicename,
    String? userDisplayName,
    List<String>? userRole,
    int? userId,
    String? firstName,
    String? lastName,
    String? registeredDate,
    String? avatar,
  }) {
    _token = token;
    _userEmail = userEmail;
    _userNicename = userNicename;
    _userDisplayName = userDisplayName;
    _userRole = userRole;
    _userId = userId;
    _firstName = firstName;
    _lastName = lastName;
    _registeredDate = registeredDate;
    _avatar = avatar;
  }

  LoginResponse.fromJson(dynamic json) {
    _token = json['token'];
    _userEmail = json['user_email'];
    _userNicename = json['user_nicename'];
    _userDisplayName = json['user_display_name'];
    _userRole =
        json['user_role'] != null ? json['user_role'].cast<String>() : [];
    _userId = json['user_id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _registeredDate = json['registered_date'];
    _avatar = json['avatar'];
  }
  String? _token;
  String? _userEmail;
  String? _userNicename;
  String? _userDisplayName;
  List<String>? _userRole;
  int? _userId;
  String? _firstName;
  String? _lastName;
  String? _registeredDate;
  String? _avatar;

  String? get token => _token;
  String? get userEmail => _userEmail;
  String? get userNicename => _userNicename;
  String? get userDisplayName => _userDisplayName;
  List<String>? get userRole => _userRole;
  int? get userId => _userId;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  String? get registeredDate => _registeredDate;
  String? get avatar => _avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = _token;
    map['user_email'] = _userEmail;
    map['user_nicename'] = _userNicename;
    map['user_display_name'] = _userDisplayName;
    map['user_role'] = _userRole;
    map['user_id'] = _userId;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['registered_date'] = _registeredDate;
    map['avatar'] = _avatar;
    return map;
  }
}
