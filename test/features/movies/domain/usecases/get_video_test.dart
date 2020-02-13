import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/features/movies/domain/entities/data_videos.dart';
import 'package:movieapp/features/movies/domain/entities/video.dart';
import 'package:movieapp/features/movies/domain/repositories/movie_repository.dart';
import 'package:movieapp/features/movies/domain/usecases/get_videos.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  GetVideos usecase;
  MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetVideos(mockMovieRepository);
  });

  final tVideo =
      Video('1', 'iso639', 'iso3166', 'key', "video", 'site', 100, 'type');
  final tVideos = [tVideo];
  final tId = 1;
  final tDataVideos = DataVideos(tVideos, tId);

  test('should get video from the repository', () async {
    // arrange
    when(mockMovieRepository.getVideos(any))
        .thenAnswer((_) async => Right(tDataVideos));
    // act
    final result = await usecase(Params(id: tId));
    //assert
    expect(result, Right(tDataVideos));
    verify(mockMovieRepository.getVideos(tId));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
