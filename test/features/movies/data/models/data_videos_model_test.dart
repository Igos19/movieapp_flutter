import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movieapp/features/movies/data/models/data_videos_model.dart';
import 'package:movieapp/features/movies/data/models/video_model.dart';
import 'package:movieapp/features/movies/domain/entities/data_videos.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final tDataVideosModel = DataVideosModel(
    results: [
      VideoModel(
          id: '5794e8ff92514179d2003930',
          iso639: 'en',
          iso3166: 'US',
          key: 'X2i9Zz_AqTg',
          name: 'Neighbors 2 - Official Trailer (HD)',
          site: 'YouTube',
          size: 1080,
          type: 'Trailer')
    ],
    id: 325133,
  );

  test('should be a subclass of DataMovies entity', () async {
    // assert
    expect(tDataVideosModel, isA<DataVideos>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('data_videos.json'));
      // act
      final result = DataVideosModel.fromJson(jsonMap);
      // assert
      expect(result, tDataVideosModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tDataVideosModel.toJson();
      // assert
      final expectedMap = {
        "results": [
          {
            "id": "5794e8ff92514179d2003930",
            "iso_639_1": "en",
            "iso_3166_1": "US",
            "key": "X2i9Zz_AqTg",
            "name": "Neighbors 2 - Official Trailer (HD)",
            "site": "YouTube",
            "size": 1080,
            "type": "Trailer"
          }
        ],
        "id": 325133
      };
      expect(result, expectedMap);
    });
  });
}
