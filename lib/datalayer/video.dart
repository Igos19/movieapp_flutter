class Video {
  final String id;
  final String iso639;
  final String iso3166;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;

  Video.fromJson(json)
      : id = json['id'],
        iso639 = json['iso_639_1'],
        iso3166 = json['iso_3166_1'],
        key = json['key'],
        name = json['name'],
        site = json['site'],
        size = json['size'],
        type = json['type'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Video && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
