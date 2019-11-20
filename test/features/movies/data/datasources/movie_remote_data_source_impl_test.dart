import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movieapp/core/error/exceptions.dart';
import 'package:movieapp/features/movies/data/datasources/movie_remote_data_source_impl.dart';
import 'package:movieapp/features/movies/data/models/data_movies_model.dart';
import 'package:movieapp/features/movies/data/models/movie_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MovieRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = MovieRemoteDataSourceImpl(httpClient: mockHttpClient);
  });

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('data_movies.json'), 200));
  }

  group('popular movies', () {
    final tPage = 1;
    final _host = 'api.themoviedb.org';
    final _contextRoot = '3';
    final tMovieModels = [
      MovieModel.fromJson(json.decode(fixture('movie.json')))
    ];
    final tDataMoviesModel = DataMoviesModel(
        results: tMovieModels,
        page: tPage,
        totalResults: 1000,
        totalPages: 500);

    test(
        'should perform a GET request on a URL with page being the endpoint and with application/json header',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      dataSource.getPopularMovies(tPage);
      //assert
      verify(mockHttpClient.get(
          Uri.https(_host, '$_contextRoot/movie/popular',
              dataSource.setParameters({'page': tPage.toString()})),
          headers: dataSource.headers));
    });

    test('should return DataMovies when the response code is 200 (success)',
        () async {
      // arrange
      setUpMockHttpClientSuccess200();
      // act
      final result = await dataSource.getPopularMovies(tPage);
      //assert
      expect(result, tDataMoviesModel);
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      setUpMockHttpClientFailure404();
      // act
      final call = dataSource.getPopularMovies;
      //assert
      expect(() => call(tPage), throwsA(TypeMatcher<ServerException>()));
    });
  });
}
