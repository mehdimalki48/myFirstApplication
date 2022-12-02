class SliderList {
  SliderList({
    int? id,
    String? date,
    String? dateGmt,
    Guid? guid,
    String? modified,
    String? modifiedGmt,
    String? slug,
    String? status,
    String? type,
    String? link,
    Title? title,
    Content? content,
    Excerpt? excerpt,
    int? author,
    int? featuredMedia,
    String? template,
    Embedded? embedded,
  }) {
    _id = id;
    _date = date;
    _dateGmt = dateGmt;
    _guid = guid;
    _modified = modified;
    _modifiedGmt = modifiedGmt;
    _slug = slug;
    _status = status;
    _type = type;
    _link = link;
    _title = title;
    _content = content;
    _excerpt = excerpt;
    _author = author;
    _featuredMedia = featuredMedia;
    _template = template;
    _embedded = embedded;
  }

  SliderList.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _dateGmt = json['date_gmt'];
    _guid = json['guid'] != null ? Guid.fromJson(json['guid']) : null;
    _modified = json['modified'];
    _modifiedGmt = json['modified_gmt'];
    _slug = json['slug'];
    _status = json['status'];
    _type = json['type'];
    _link = json['link'];
    _title = json['title'] != null ? Title.fromJson(json['title']) : null;
    _content =
        json['content'] != null ? Content.fromJson(json['content']) : null;
    _excerpt =
        json['excerpt'] != null ? Excerpt.fromJson(json['excerpt']) : null;
    _author = json['author'];
    _featuredMedia = json['featured_media'];
    _template = json['template'];
    _embedded =
        json['_embedded'] != null ? Embedded.fromJson(json['_embedded']) : null;
  }
  int? _id;
  String? _date;
  String? _dateGmt;
  Guid? _guid;
  String? _modified;
  String? _modifiedGmt;
  String? _slug;
  String? _status;
  String? _type;
  String? _link;
  Title? _title;
  Content? _content;
  Excerpt? _excerpt;
  int? _author;
  int? _featuredMedia;
  String? _template;
  Embedded? _embedded;

  int? get id => _id;
  String? get date => _date;
  String? get dateGmt => _dateGmt;
  Guid? get guid => _guid;
  String? get modified => _modified;
  String? get modifiedGmt => _modifiedGmt;
  String? get slug => _slug;
  String? get status => _status;
  String? get type => _type;
  String? get link => _link;
  Title? get title => _title;
  Content? get content => _content;
  Excerpt? get excerpt => _excerpt;
  int? get author => _author;
  int? get featuredMedia => _featuredMedia;
  String? get template => _template;
  Embedded? get embedded => _embedded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['date_gmt'] = _dateGmt;
    if (_guid != null) {
      map['guid'] = _guid?.toJson();
    }
    map['modified'] = _modified;
    map['modified_gmt'] = _modifiedGmt;
    map['slug'] = _slug;
    map['status'] = _status;
    map['type'] = _type;
    map['link'] = _link;
    if (_title != null) {
      map['title'] = _title?.toJson();
    }
    if (_content != null) {
      map['content'] = _content?.toJson();
    }
    if (_excerpt != null) {
      map['excerpt'] = _excerpt?.toJson();
    }
    map['author'] = _author;
    map['featured_media'] = _featuredMedia;
    map['template'] = _template;
    if (_embedded != null) {
      map['_embedded'] = _embedded?.toJson();
    }
    return map;
  }
}

class Embedded {
  Embedded({
    List<WpFeaturedmedia>? wpfeaturedmedia,
  }) {
    _wpfeaturedmedia = wpfeaturedmedia;
  }

  Embedded.fromJson(dynamic json) {
    if (json['wp:featuredmedia'] != null) {
      _wpfeaturedmedia = [];
      json['wp:featuredmedia'].forEach((v) {
        _wpfeaturedmedia?.add(WpFeaturedmedia.fromJson(v));
      });
    }
  }
  List<WpFeaturedmedia>? _wpfeaturedmedia;

  List<WpFeaturedmedia>? get wpfeaturedmedia => _wpfeaturedmedia;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_wpfeaturedmedia != null) {
      map['wp:featuredmedia'] =
          _wpfeaturedmedia?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class WpFeaturedmedia {
  WpFeaturedmedia({
    int? id,
    String? date,
    String? slug,
    String? type,
    String? link,
    String? altText,
    String? mediaType,
    String? mimeType,
    String? sourceUrl,
  }) {
    _id = id;
    _date = date;
    _slug = slug;
    _type = type;
    _link = link;
    _altText = altText;
    _mediaType = mediaType;
    _mimeType = mimeType;
    _sourceUrl = sourceUrl;
  }

  WpFeaturedmedia.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _slug = json['slug'];
    _type = json['type'];
    _link = json['link'];
    _altText = json['alt_text'];
    _mediaType = json['media_type'];
    _mimeType = json['mime_type'];
    _sourceUrl = json['source_url'];
  }
  int? _id;
  String? _date;
  String? _slug;
  String? _type;
  String? _link;
  String? _altText;
  String? _mediaType;
  String? _mimeType;
  String? _sourceUrl;

  int? get id => _id;
  String? get date => _date;
  String? get slug => _slug;
  String? get type => _type;
  String? get link => _link;
  String? get altText => _altText;
  String? get mediaType => _mediaType;
  String? get mimeType => _mimeType;
  String? get sourceUrl => _sourceUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['slug'] = _slug;
    map['type'] = _type;
    map['link'] = _link;
    map['alt_text'] = _altText;
    map['media_type'] = _mediaType;
    map['mime_type'] = _mimeType;
    map['source_url'] = _sourceUrl;
    return map;
  }
}

class Excerpt {
  Excerpt({
    String? rendered,
    bool? protected,
  }) {
    _rendered = rendered;
    _protected = protected;
  }

  Excerpt.fromJson(dynamic json) {
    _rendered = json['rendered'];
    _protected = json['protected'];
  }
  String? _rendered;
  bool? _protected;

  String? get rendered => _rendered;
  bool? get protected => _protected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rendered'] = _rendered;
    map['protected'] = _protected;
    return map;
  }
}

class Content {
  Content({
    String? rendered,
    bool? protected,
  }) {
    _rendered = rendered;
    _protected = protected;
  }

  Content.fromJson(dynamic json) {
    _rendered = json['rendered'];
    _protected = json['protected'];
  }
  String? _rendered;
  bool? _protected;

  String? get rendered => _rendered;
  bool? get protected => _protected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rendered'] = _rendered;
    map['protected'] = _protected;
    return map;
  }
}

class Title {
  Title({
    String? rendered,
  }) {
    _rendered = rendered;
  }

  Title.fromJson(dynamic json) {
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

class Guid {
  Guid({
    String? rendered,
  }) {
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
