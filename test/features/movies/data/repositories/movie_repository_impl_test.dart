import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/core/error/exceptions.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/core/network/network_info.dart';
import 'package:movieapp/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:movieapp/features/movies/data/models/data_movies_model.dart';
import 'package:movieapp/features/movies/data/models/data_videos_model.dart';
import 'package:movieapp/features/movies/data/models/movie_model.dart';
import 'package:movieapp/features/movies/data/models/video_model.dart';
import 'package:movieapp/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:movieapp/features/movies/domain/entities/data_movies.dart';
import 'package:movieapp/features/movies/domain/entities/data_videos.dart';

class MockMovieRemoteDataSource extends Mock implements MovieRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MovieRepositoryImpl repository;
  MockMovieRemoteDataSource mockMovieRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;

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
    final tId = 1;
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

    final tVideosModel = VideoModel(
        id: '5794e8ff92514179d2003930',
        iso639: 'en',
        iso3166: 'US',
        key: 'X2i9Zz_AqTg',
        name: 'Neighbors 2 - Official Trailer (HD)',
        site: 'YouTube',
        size: 1080,
        type: 'Trailer');

    final tMovieModels = [tMovieModel];
    final tVideoModels = [tVideosModel];

    final DataMoviesModel tDataMoviesModel = DataMoviesModel(
        results: tMovieModels,
        page: tPage,
        totalResults: 1000,
        totalPages: 500);
    final DataMovies tDataMovies = tDataMoviesModel;

    final DataVideosModel tDataVideosModel =
        DataVideosModel(results: tVideoModels, id: tId);
    final DataVideos tDataVideos = tDataVideosModel;

    group('now playing movies', () {
      test(
          'should return remote data when the call to remote data source is successfull',
          () async {
        // arrange
        when(mockMovieRemoteDataSource.getNowPlayingMovies(any))
            .thenAnswer((_) async => tDataMoviesModel);
        // act
        final result = await repository.getNowPlayingMovies(tPage);
        //assert
        verify(mockMovieRemoteDataSource.getNowPlayingMovies(tPage));
        expect(result, Right(tDataMovies));
      });

      test(
          'should return failure when the call remote data source is unsuccessfull',
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
    });

    group('top rated movies', () {
      test(
          'should return remote data when the call to remote data source is successfull',
          () async {
        // arrange
        when(mockMovieRemoteDataSource.getTopRatedMovies(any))
            .thenAnswer((_) async => tDataMoviesModel);
        // act
        final result = await repository.getTopRatedMovies(tPage);
        //assert
        verify(mockMovieRemoteDataSource.getTopRatedMovies(tPage));
        expect(result, Right(tDataMovies));
      });

      test(
          'should return failure when the call remote data source is unsuccessfull',
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
    });

    group('upcoming movies', () {
      test(
          'should return remote data when the call to remote data source is successfull',
          () async {
        // arrange
        when(mockMovieRemoteDataSource.getUpcomingMovies(any))
            .thenAnswer((_) async => tDataMoviesModel);
        // act
        final result = await repository.getUpcomingMovies(tPage);
        //assert
        verify(mockMovieRemoteDataSource.getUpcomingMovies(tPage));
        expect(result, Right(tDataMovies));
      });

      test(
          'should return failure when the call remote data source is unsuccessfull',
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

    group('popular movies', () {
      test(
          'should return remote data when the call to remote data source is successfull',
          () async {
        // arrange
        when(mockMovieRemoteDataSource.getPopularMovies(any))
            .thenAnswer((_) async => tDataMoviesModel);
        // act
        final result = await repository.getPopularMovies(tPage);
        //assert
        verify(mockMovieRemoteDataSource.getPopularMovies(tPage));
        expect(result, Right(tDataMovies));
      });

      test(
          'should return failure when the call remote data source is unsuccessfull',
          () async {
        // arrange
        when(mockMovieRemoteDataSource.getPopularMovies(any))
            .thenThrow(ServerException());
        // act
        final result = await repository.getPopularMovies(tPage);
        //assert
        verify(mockMovieRemoteDataSource.getPopularMovies(tPage));
        expect(result, Left(ServerFailure()));
      });
    });

    group('videos', () {
      test(
          'should return remote data when the call to remote data source is successfull',
          () async {
        // arrange
        when(mockMovieRemoteDataSource.getVideos(any))
            .thenAnswer((_) async => tDataVideosModel);
        // act
        final result = await repository.getVideos(tId);
        //assert
        verify(mockMovieRemoteDataSource.getVideos(tId));
        expect(result, Right(tDataVideos));
      });

      test(
          'should return failure when the call remote data source is unsuccessfull',
          () async {
        // arrange
        when(mockMovieRemoteDataSource.getVideos(any))
            .thenThrow(ServerException());
        // act
        final result = await repository.getVideos(tId);
        //assert
        verify(mockMovieRemoteDataSource.getVideos(tId));
        expect(result, Left(ServerFailure()));
      });
    });
  });

  runTestsOffline(() {
    final tPage = 1;
    final tId = 1;

    group('popular movies', () {
      test('should return NetworkFailure when there is not internet connection',
          () async {
        // arrange
        // act
        final result = await repository.getNowPlayingMovies(tPage);
        //assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(NetworkFailure()));
      });
    });

    group('top rated movies', () {
      test('should return NetworkFailure when there is not internet connection',
          () async {
        // arrange
        // act
        final result = await repository.getTopRatedMovies(tPage);
        //assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(NetworkFailure()));
      });
    });

    group('upcoming movies', () {
      test('should return NetworkFailure when there is not internet connection',
          () async {
        // arrange
        // act
        final result = await repository.getUpcomingMovies(tPage);
        //assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(NetworkFailure()));
      });
    });

    group('now playing movies', () {
      test('should return NetworkFailure when there is not internet connection',
          () async {
        // arrange
        // act
        final result = await repository.getUpcomingMovies(tPage);
        //assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(NetworkFailure()));
      });
    });

    group('videos', () {
      test('should return NetworkFailure when there is not internet connection',
          () async {
        // arrange
        // act
        final result = await repository.getVideos(tId);
        //assert
        verify(mockNetworkInfo.isConnected);
        expect(result, Left(NetworkFailure()));
      });
    });
  });
}
