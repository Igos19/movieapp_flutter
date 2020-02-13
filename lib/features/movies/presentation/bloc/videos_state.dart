import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/features/movies/domain/entities/data_videos.dart';

@immutable
abstract class VideosState extends Equatable {
  VideosState() : super();

  @override
  List<Object> get props => const <dynamic>[];
}

class EmptyVideos extends VideosState {}

class LoadingVideos extends VideosState {}

class LoadedVideos extends VideosState {
  final DataVideos videos;

  LoadedVideos({@required this.videos}) : super();

  @override
  List<Object> get props => [videos];
}

class ErrorVideos extends VideosState {
  final String message;

  ErrorVideos({@required this.message}) : super();

  @override
  List<Object> get props => [message];
}
