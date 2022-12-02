class Registration {
  Registration({
    String? username,
    String? email,
    String? password,
  }) {
    _username = username;
    _email = email;
    _password = password;
  }

  Registration.fromJson(dynamic json) {
    _username = json['username'];
    _email = json['email'];
    _password = json['password'];
  }
  String? _username;
  String? _email;
  String? _password;

  String? get username => _username;
  String? get email => _email;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['email'] = _email;
    map['password'] = _password;
    return map;
  }
}
