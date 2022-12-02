class SuggestionModel {
  SuggestionModel({
    // int? id,
    String? title,
  }) {
    // _id = id;
    _title = title;
  }

  SuggestionModel.fromJson(dynamic json) {
    // _id = json['id'];
    _title = json['title'];
  }
  int? _id;
  String? _title;

  int? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    // map['id'] = _id;
    map['title'] = _title;
    return map;
  }
}
