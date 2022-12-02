class WordpressImage {
  WordpressImage({
      int? id, 
      String? date, 
      String? dateGmt, 
      Guid? guid,}){
    _id = id;
    _date = date;
    _dateGmt = dateGmt;
    _guid = guid;
}

  WordpressImage.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _dateGmt = json['date_gmt'];
    _guid = json['guid'] != null ? Guid.fromJson(json['guid']) : null;
  }
  int? _id;
  String? _date;
  String? _dateGmt;
  Guid? _guid;

  int? get id => _id;
  String? get date => _date;
  String? get dateGmt => _dateGmt;
  Guid? get guid => _guid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['date_gmt'] = _dateGmt;
    if (_guid != null) {
      map['guid'] = _guid?.toJson();
    }
    return map;
  }

}

class Guid {
  Guid({
      String? rendered,}){
    _rendered = rendered;
}

  Guid.fromJson(dynamic json) {
    _rendered = json['rendered'];
  }
  String? _rendered;

  String? get rendered => _rendered;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rendered'] = _rendered;
    return map;
  }

}