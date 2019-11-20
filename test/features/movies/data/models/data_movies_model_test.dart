import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movieapp/features/movies/data/models/data_movies_model.dart';
import 'package:movieapp/features/movies/data/models/movie_model.dart';
import 'package:movieapp/features/movies/domain/entities/data_movies.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final tDataMoviesModel = DataMoviesModel(
    results: [
      MovieModel(
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
      )
    ],
    page: 1,
    totalResults: 1000,
    totalPages: 500,
  );

  test('should be a subclass of DataMovies entity', () async {
    // assert
    expect(tDataMoviesModel, isA<DataMovies>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('data_movies.json'));
      // act
      final result = DataMoviesModel.fromJson(jsonMap);
      // assert
      expect(result, tDataMoviesModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tDataMoviesModel.toJson();
      // assert
      final expectedMap = {
        "results": [
          {
            "poster_path": "/bWUeJHbKIyT306WtJFRHoSzX9nk.jpg",
            "adult": false,
            "overview": "overview",
            "release_date": "2016-05-05",
            "genre_ids": [35],
            "id": 325133,
            "original_title": "Neighbors 2: Sorority Rising",
            "original_language": "en",
            "title": "Neighbors 2: Sorority Rising",
            "backdrop_path": "/8HuO1RMDI3prfWDkF7t1y8EhLVO.jpg",
            "popularity": 11.178222,
            "vote_count": 414,
            "video": false,
            "vote_average": 5.36
          }
        ],
        "page": 1,
        "total_results": 1000,
        "total_pages": 500
      };
      expect(result, expectedMap);
    });
  });
}
