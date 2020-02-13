import 'package:meta/meta.dart';
import 'package:movieapp/features/movies/domain/entities/video.dart';

class VideoModel extends Video {
  VideoModel(
      {@required String id,
      @required String iso639,
      @required String iso3166,
      @required String key,
      @required String name,
      @required String site,
      @required int size,
      @required String type})
      : super(id, iso639, iso3166, key, name, site, size, type);

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      iso639: json['iso_639_1'],
      iso3166: json['iso_3166_1'],
      key: json['key'],
      name: json['name'],
      site: json['site'],
      size: json['size'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'iso_639_1': iso639,
        'iso_3166_1': iso3166,
        'key': key,
        'name': name,
        'site': site,
        'size': size,
        'type': type,
      };
}
