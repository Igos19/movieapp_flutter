import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/core/error/exceptions.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/core/platform/network_info.dart';
import 'package:movieapp/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:movieapp/features/movies/data/models/movie_model.dart';
import 'package:movieapp/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';

class MockMovieRemoteDataSource extends Mock implements MovieRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MovieRepositoryImpl repository;
  MockMovieRemoteDataSource mockMovieRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

  int tPage = 1;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = MovieRepositoryImpl(
        source: mockMovieRemoteDataSource, networkInfo: mockNetworkInfo);
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  runTestsOnline(() {
    final tPage = 1;
    final tMovieModel = MovieModel(
      id: 325133,
      adult: false,
      overview: 'overview',
      popularity: 11.178222,
      posterPath: '/bWUeJHbKIyT306WtJFRHoSzX9nk.jpg',
      title: 'Neighbors 2: Sorority Rising',
      releaseDate: '2016-05-05',
      genreIds: [35],
      originalTitle: 'Neighbors 2: Sorority Rising',
      originalLanguage: 'en',
      backdropPath: '/8HuO1RMDI3prfWDkF7t1y8EhLVO.jpg',
      voteAverage: 5.36,
      video: false,
      voteCount: 414,
    );

    final Movie tMovie = tMovieModel;

    test(
        'should return remote data when the call to remote data source is successfull while getting popular movies',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getNowPlayingMovies(any))
          .thenAnswer((_) async => tMovieModel);
      // act
      final result = await repository.getNowPlayingMovies(tPage);
      //assert
      verify(mockMovieRemoteDataSource.getNowPlayingMovies(tPage));
      expect(result, Right(tMovie));
    });

    test(
        'should return failure when the call remote data source is unsuccessfull while getting popular movies',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getNowPlayingMovies(any))
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingMovies(tPage);
      //assert
      verify(mockMovieRemoteDataSource.getNowPlayingMovies(tPage));
      expect(result, Left(ServerFailure()));
    });

    test(
        'should return remote data when the call to remote data source is successfull while getting top rated movies',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getTopRatedMovies(any))
          .thenAnswer((_) async => tMovieModel);
      // act
      final result = await repository.getTopRatedMovies(tPage);
      //assert
      verify(mockMovieRemoteDataSource.getTopRatedMovies(tPage));
      expect(result, Right(tMovie));
    });

    test(
        'should return failure when the call remote data source is unsuccessfull while getting top rated movies',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getTopRatedMovies(any))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedMovies(tPage);
      //assert
      verify(mockMovieRemoteDataSource.getTopRatedMovies(tPage));
      expect(result, Left(ServerFailure()));
    });

    test(
        'should return remote data when the call to remote data source is successfull while getting upcoming movies',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getUpcomingMovies(any))
          .thenAnswer((_) async => tMovieModel);
      // act
      final result = await repository.getUpcomingMovies(tPage);
      //assert
      verify(mockMovieRemoteDataSource.getUpcomingMovies(tPage));
      expect(result, Right(tMovie));
    });

    test(
        'should return failure when the call remote data source is unsuccessfull while getting upcoming movies',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getUpcomingMovies(any))
          .thenThrow(ServerException());
      // act
      final result = await repository.getUpcomingMovies(tPage);
      //assert
      verify(mockMovieRemoteDataSource.getUpcomingMovies(tPage));
      expect(result, Left(ServerFailure()));
    });

    test(
        'should return remote data when the call to remote data source is successfull while getting now playing movies',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getUpcomingMovies(any))
          .thenAnswer((_) async => tMovieModel);
      // act
      final result = await repository.getUpcomingMovies(tPage);
      //assert
      verify(mockMovieRemoteDataSource.getUpcomingMovies(tPage));
      expect(result, Right(tMovie));
    });

    test(
        'should return failure when the call remote data source is unsuccessfull while getting now playing movies',
        () async {
      // arrange
      when(mockMovieRemoteDataSource.getUpcomingMovies(any))
          .thenThrow(ServerException());
      // act
      final result = await repository.getUpcomingMovies(tPage);
      //assert
      verify(mockMovieRemoteDataSource.getUpcomingMovies(tPage));
      expect(result, Left(ServerFailure()));
    });
  });

  runTestsOffline(() {
    test(
        'should return NetworkFailure when there is not internet connection while getting popular movies',
        () async {
      // arrange
      // act
      final result = await repository.getNowPlayingMovies(tPage);
      //assert
      verify(mockNetworkInfo.isConnected);
      expect(result, Left(NetworkFailure()));
    });

    test(
        'should return NetworkFailure when there is not internet connection while getting top rated movies',
        () async {
      // arrange
      // act
      final result = await repository.getTopRatedMovies(tPage);
      //assert
      verify(mockNetworkInfo.isConnected);
      expect(result, Left(NetworkFailure()));
    });

    test(
        'should return NetworkFailure when there is not internet connection while getting upcoming movies',
        () async {
      // arrange
      // act
      final result = await repository.getUpcomingMovies(tPage);
      //assert
      verify(mockNetworkInfo.isConnected);
      expect(result, Left(NetworkFailure()));
    });

    test(
        'should return NetworkFailure when there is not internet connection while getting now playing movies',
        () async {
      // arrange
      // act
      final result = await repository.getUpcomingMovies(tPage);
      //assert
      verify(mockNetworkInfo.isConnected);
      expect(result, Left(NetworkFailure()));
    });
  });
}
