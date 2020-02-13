import 'package:equatable/equatable.dart';
import 'package:movieapp/features/movies/domain/entities/video.dart';

class DataVideos extends Equatable {
  final List<Video> results;
  final int id;

  DataVideos(this.results, this.id);

  @override
  List<Object> get props => [results, id];
}
