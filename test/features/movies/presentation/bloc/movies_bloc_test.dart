import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/features/movies/domain/entities/data_movies.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';
import 'package:movieapp/features/movies/domain/usecases/get_now_playing_movies.dart'
    as nowPlaying;
import 'package:movieapp/features/movies/domain/usecases/get_popular_movies.dart'
    as popular;
import 'package:movieapp/features/movies/domain/usecases/get_top_rated_movies.dart'
    as topRated;
import 'package:movieapp/features/movies/domain/usecases/get_upcoming_movies.dart'
    as upcoming;
import 'package:movieapp/features/movies/presentation/bloc/bloc.dart';

class MockGetPopularMovies extends Mock implements popular.GetPopularMovies {}

class MockGetUpcomingMovies extends Mock implements upcoming.GetUpcomingMovies {
}

class MockGetTopRatedMovies extends Mock implements topRated.GetTopRatedMovies {
}

class MockGetNowPlayingMovies extends Mock
    implements nowPlaying.GetNowPlayingMovies {}

void main() {
  MoviesBloc bloc;
  MockGetPopularMovies mockGetPopularMovies;
  MockGetUpcomingMovies mockGetUpcomingMovies;
  MockGetTopRatedMovies mockGetTopRatedMovies;
  MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetUpcomingMovies = MockGetUpcomingMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();

    bloc = MoviesBloc(
        popular: mockGetPopularMovies,
        nowPlaying: mockGetNowPlayingMovies,
        topRated: mockGetTopRatedMovies,
        upcoming: mockGetUpcomingMovies);
  });

  test('initial state should be Empty', () {
    //assert
    expect(bloc.initialState, equals(Empty()));
  });

  group('Movies', () {
    final tMovie = Movie(1, false, 'desc', 2.0, 'path', 'title', 'date', [1],
        'originalTitle', 'originalLanguage', 'backdropPath', 3.0, false, 1);
    final tPage = 1;
    final tMovies = [tMovie];
    final tDataMovies = DataMovies(tMovies, tPage, 1000, 500);

    group('PopularMovies', () {
      test('should get movies from the concreate use case', () async {
        // arrange
        when(mockGetPopularMovies.call(any))
            .thenAnswer((_) async => Right(tDataMovies));
        // act
        bloc.dispatch(GetPopularMoviesEvent(tPage));
        await untilCalled(mockGetPopularMovies(any));
        //assert
        verify(mockGetPopularMovies(popular.Params(page: tPage)));
      });

      test('should emit [Loading, Loaded] when data is got successfully',
          () async {
        // arrange
        when(mockGetPopularMovies.call(any))
            .thenAnswer((_) async => Right(tDataMovies));
        // act
        final expected = [Empty(), Loading(), Loaded(movies: tDataMovies)];
        expectLater(bloc.state, emitsInOrder(expected));
        //assert
        bloc.dispatch(GetPopularMoviesEvent(tPage));
      });

      test('should emit [Loading, Error] when getting data is failed',
          () async {
        // arrange
        when(mockGetPopularMovies.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // act
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //assert
        bloc.dispatch(GetPopularMoviesEvent(tPage));
      });
    });

    group('TopRatedMovies', () {
      test('should get movies from the concreate use case', () async {
        // arrange
        when(mockGetTopRatedMovies.call(any))
            .thenAnswer((_) async => Right(tDataMovies));
        // act
        bloc.dispatch(GetTopRatedMoviesEvent(tPage));
        await untilCalled(mockGetTopRatedMovies(any));
        //assert
        verify(mockGetTopRatedMovies(topRated.Params(page: tPage)));
      });

      test('should emit [Loading, Loaded] when data is got successfully',
          () async {
        // arrange
        when(mockGetTopRatedMovies.call(any))
            .thenAnswer((_) async => Right(tDataMovies));
        // act
        final expected = [Empty(), Loading(), Loaded(movies: tDataMovies)];
        expectLater(bloc.state, emitsInOrder(expected));
        //assert
        bloc.dispatch(GetTopRatedMoviesEvent(tPage));
      });

      test('should emit [Loading, Error] when getting data is failed',
          () async {
        // arrange
        when(mockGetTopRatedMovies.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // act
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //assert
        bloc.dispatch(GetTopRatedMoviesEvent(tPage));
      });
    });

    group('UpcomingMovies', () {
      test('should get movies from the concreate use case', () async {
        // arrange
        when(mockGetUpcomingMovies.call(any))
            .thenAnswer((_) async => Right(tDataMovies));
        // act
        bloc.dispatch(GetUpcomingMoviesEvent(tPage));
        await untilCalled(mockGetUpcomingMovies(any));
        //assert
        verify(mockGetUpcomingMovies(upcoming.Params(page: tPage)));
      });

      test('should emit [Loading, Loaded] when data is got successfully',
          () async {
        // arrange
        when(mockGetUpcomingMovies.call(any))
            .thenAnswer((_) async => Right(tDataMovies));
        // act
        final expected = [Empty(), Loading(), Loaded(movies: tDataMovies)];
        expectLater(bloc.state, emitsInOrder(expected));
        //assert
        bloc.dispatch(GetUpcomingMoviesEvent(tPage));
      });

      test('should emit [Loading, Error] when getting data is failed',
          () async {
        // arrange
        when(mockGetUpcomingMovies.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // act
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //assert
        bloc.dispatch(GetUpcomingMoviesEvent(tPage));
      });
    });

    group('NowPlayingMovies', () {
      test('should get movies from the concreate use case', () async {
        // arrange
        when(mockGetNowPlayingMovies.call(any))
            .thenAnswer((_) async => Right(tDataMovies));
        // act
        bloc.dispatch(GetNowPlayingMoviesEvent(tPage));
        await untilCalled(mockGetNowPlayingMovies(any));
        //assert
        verify(mockGetNowPlayingMovies(nowPlaying.Params(page: tPage)));
      });

      test('should emit [Loading, Loaded] when data is got successfully',
          () async {
        // arrange
        when(mockGetNowPlayingMovies.call(any))
            .thenAnswer((_) async => Right(tDataMovies));
        // act
        final expected = [Empty(), Loading(), Loaded(movies: tDataMovies)];
        expectLater(bloc.state, emitsInOrder(expected));
        //assert
        bloc.dispatch(GetNowPlayingMoviesEvent(tPage));
      });

      test('should emit [Loading, Error] when getting data is failed',
          () async {
        // arrange
        when(mockGetNowPlayingMovies.call(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // act
        final expected = [
          Empty(),
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE)
        ];
        expectLater(bloc.state, emitsInOrder(expected));
        //assert
        bloc.dispatch(GetNowPlayingMoviesEvent(tPage));
      });
    });
  });
}
