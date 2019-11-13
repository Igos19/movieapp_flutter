import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movieapp/features/movies/data/models/movie_model.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
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

  test('should be a subclass of Movie entity', () async {
    // assert
    expect(tMovieModel, isA<Movie>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('movie.json'));
      // act
      final result = MovieModel.fromJson(jsonMap);
      // assert
      expect(result, tMovieModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tMovieModel.toJson();
      // assert
      final expectedMap = {
        "poster_path": "/bWUeJHbKIyT306WtJFRHoSzX9nk.jpg",
        "adult": false,
        "overview": "overview",
        "release_date": "2016-05-05",
        "genre_ids": [
          35
        ],
        "id": 325133,
        "original_title": "Neighbors 2: Sorority Rising",
        "original_language": "en",
        "title": "Neighbors 2: Sorority Rising",
        "backdrop_path": "/8HuO1RMDI3prfWDkF7t1y8EhLVO.jpg",
        "popularity": 11.178222,
        "vote_count": 414,
        "video": false,
        "vote_average": 5.36
      };
      expect(result, expectedMap);
    });
  });
}
