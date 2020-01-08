import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/features/movies/domain/entities/data_movies.dart';
import 'package:movieapp/features/movies/domain/usecases/get_now_playing_movies.dart'
    as nowPlaying;
import 'package:movieapp/features/movies/domain/usecases/get_popular_movies.dart'
    as popular;
import 'package:movieapp/features/movies/domain/usecases/get_top_rated_movies.dart'
    as topRated;
import 'package:movieapp/features/movies/domain/usecases/get_upcoming_movies.dart'
    as upcoming;

import './bloc.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String NETWORK_FAILURE_MESSAGE = 'Network Failure';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final popular.GetPopularMovies getPopularMovies;
  final nowPlaying.GetNowPlayingMovies getNowPlayingMovies;
  final topRated.GetTopRatedMovies getTopRatedMovies;
  final upcoming.GetUpcomingMovies getUpcomingMovies;

  MoviesBloc(
      {@required popular.GetPopularMovies popular,
      @required nowPlaying.GetNowPlayingMovies nowPlaying,
      @required topRated.GetTopRatedMovies topRated,
      @required upcoming.GetUpcomingMovies upcoming})
      : assert(popular != null),
        assert(nowPlaying != null),
        assert(topRated != null),
        assert(upcoming != null),
        getPopularMovies = popular,
        getNowPlayingMovies = nowPlaying,
        getTopRatedMovies = topRated,
        getUpcomingMovies = upcoming;

  @override
  MoviesState get initialState => Empty();

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    yield Loading();
    var failureOrMovies;
    if (event is GetPopularMoviesEvent) {
      failureOrMovies =
          await getPopularMovies.call(popular.Params(page: event.page));
    }
    if (event is GetTopRatedMoviesEvent) {
      failureOrMovies =
          await getTopRatedMovies.call(topRated.Params(page: event.page));
    }
    if (event is GetUpcomingMoviesEvent) {
      failureOrMovies =
          await getUpcomingMovies.call(upcoming.Params(page: event.page));
    }
    if (event is GetNowPlayingMoviesEvent) {
      failureOrMovies =
          await getNowPlayingMovies.call(nowPlaying.Params(page: event.page));
    }
    yield* _eitherLoadedOrErrorState(failureOrMovies);
  }

  Stream<MoviesState> _eitherLoadedOrErrorState(
    Either<Failure, DataMovies> failureOrMovies,
  ) async* {
    yield failureOrMovies.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (movies) => Loaded(movies: movies),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
