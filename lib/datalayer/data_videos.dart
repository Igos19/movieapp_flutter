import 'package:movieapp/datalayer/video.dart';

class DataMovies {
  final int id;
  final List<Video> videos;

  DataMovies.fromJson(json)
      : id = json['id'],
        videos = json['results'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataMovies && runtimeType == other.runtimeType;

  @override
  int get hashCode => id.hashCode;
}
