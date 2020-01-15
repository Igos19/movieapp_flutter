import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MoviesEvent extends Equatable {
  final int page;

  MoviesEvent(this.page) : super();

  MoviesEvent recreate(int page);

  @override
  List<Object> get props => [page];
}

class GetPopularMoviesEvent extends MoviesEvent {
  GetPopularMoviesEvent({int page = 1}) : super(page);

  @override
  MoviesEvent recreate(int page) {
    return GetPopularMoviesEvent(page: page);
  }
}

class GetTopRatedMoviesEvent extends MoviesEvent {
  GetTopRatedMoviesEvent({int page = 1}) : super(page);

  @override
  MoviesEvent recreate(int page) {
    return GetTopRatedMoviesEvent(page: page);
  }
}

class GetUpcomingMoviesEvent extends MoviesEvent {
  GetUpcomingMoviesEvent({int page = 1}) : super(page);

  @override
  MoviesEvent recreate(int page) {
    return GetUpcomingMoviesEvent(page: page);
  }
}

class GetNowPlayingMoviesEvent extends MoviesEvent {
  GetNowPlayingMoviesEvent({int page = 1}) : super(page);

  @override
  MoviesEvent recreate(int page) {
    return GetNowPlayingMoviesEvent(page: page);
  }
}
