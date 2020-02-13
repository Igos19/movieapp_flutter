import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String id;
  final String iso639;
  final String iso3166;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;

  Video(this.id, this.iso639, this.iso3166, this.key, this.name, this.site,
      this.size, this.type);

  @override
  List<Object> get props => [id, iso639, iso3166, key, name, site, size, type];
}
