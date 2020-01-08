import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MoviesEvent extends Equatable {
  MoviesEvent([List props = const <dynamic>[]]) : super(props);
}

class GetPopularMoviesEvent extends MoviesEvent {
  final int page;

  GetPopularMoviesEvent(this.page) : super([page]);
}

class GetTopRatedMoviesEvent extends MoviesEvent {
  final int page;

  GetTopRatedMoviesEvent(this.page) : super([page]);
}

class GetUpcomingMoviesEvent extends MoviesEvent {
  final int page;

  GetUpcomingMoviesEvent(this.page) : super([page]);
}

class GetNowPlayingMoviesEvent extends MoviesEvent {
  final int page;

  GetNowPlayingMoviesEvent(this.page) : super([page]);
}
