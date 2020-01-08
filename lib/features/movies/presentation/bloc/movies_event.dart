import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MoviesEvent extends Equatable {
  MoviesEvent() : super();
}

class GetPopularMoviesEvent extends MoviesEvent {
  final int page;

  GetPopularMoviesEvent(this.page) : super();

  @override
  List<Object> get props => [page];
}

class GetTopRatedMoviesEvent extends MoviesEvent {
  final int page;

  GetTopRatedMoviesEvent(this.page) : super();

  @override
  List<Object> get props => [page];
}

class GetUpcomingMoviesEvent extends MoviesEvent {
  final int page;

  GetUpcomingMoviesEvent(this.page) : super();

  @override
  List<Object> get props => [page];
}

class GetNowPlayingMoviesEvent extends MoviesEvent {
  final int page;

  GetNowPlayingMoviesEvent(this.page) : super();

  @override
  List<Object> get props => [page];
}
