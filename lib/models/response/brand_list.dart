class BrandList {
  BrandList({
    int? id,
    int? count,
    String? description,
    String? name,
    String? slug,
    String? taxonomy,
    String? thumbnailId,
    String? thumbnailImage,}){
    _id = id;
    _count = count;
    _description = description;
    _name = name;
    _slug = slug;
    _taxonomy = taxonomy;
    _thumbnailId = thumbnailId;
    _thumbnailImage = thumbnailImage;
  }

  BrandList.fromJson(dynamic json) {
    _id = json['id'];
    _count = json['count'];
    _description = json['description'];
    _name = json['name'];
    _slug = json['slug'];
    _taxonomy = json['taxonomy'];
    _thumbnailId = json['thumbnail_id'];
    _thumbnailImage = json['thumbnail_image'];
  }
  int? _id;
  int? _count;
  String? _description;
  String? _name;
  String? _slug;
  String? _taxonomy;
  String? _thumbnailId;
  String? _thumbnailImage;

  int? get id => _id;
  int? get count => _count;
  String? get description => _description;
  String? get name => _name;
  String? get slug => _slug;
  String? get taxonomy => _taxonomy;
  String? get thumbnailId => _thumbnailId;
  String? get thumbnailImage => _thumbnailImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['count'] = _count;
    map['description'] = _description;
    map['name'] = _name;
    map['slug'] = _slug;
    map['taxonomy'] = _taxonomy;
    map['thumbnail_id'] = _thumbnailId;
    map['thumbnail_image'] = _thumbnailImage;
    return map;
  }

}