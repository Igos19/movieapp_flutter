import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:movieapp/features/movies/data/models/video_model.dart';

import '../../../../fixtures/fixture_reader.dart';

main() {
  final tVideosModel = VideoModel(
      id: '5794e8ff92514179d2003930',
      iso639: 'en',
      iso3166: 'US',
      key: 'X2i9Zz_AqTg',
      name: 'Neighbors 2 - Official Trailer (HD)',
      site: 'YouTube',
      size: 1080,
      type: 'Trailer');

  test('should be a subclass of VideoModel entity', () async {
    // assert
    expect(tVideosModel, isA<VideoModel>());
  });

  group('fromJson', () {
    test('should return a valid model', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(fixture('video.json'));
      // act
      final result = VideoModel.fromJson(jsonMap);
      // assert
      expect(result, tVideosModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // arrange
      // act
      final result = tVideosModel.toJson();
      // assert
      final expectedMap = {
        "id": "5794e8ff92514179d2003930",
        "iso_639_1": "en",
        "iso_3166_1": "US",
        "key": "X2i9Zz_AqTg",
        "name": "Neighbors 2 - Official Trailer (HD)",
        "site": "YouTube",
        "size": 1080,
        "type": "Trailer"
      };
      expect(result, expectedMap);
    });
  });
}
