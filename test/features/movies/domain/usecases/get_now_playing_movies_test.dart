import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';
import 'package:movieapp/features/movies/domain/repositories/movie_repository.dart';
import 'package:movieapp/features/movies/domain/usecases/get_now_playing_movies.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  GetNowPlayingMovies usecase;
  MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetNowPlayingMovies(mockMovieRepository);
  });

  final tMovie = Movie(1, false, 'desc', 2.0, 'path', 'title', 'date', [1],
      'originalTitle', 'originalLanguage', 'backdropPath', 3.0, false, 1);
  final tPage = 1;

  test('shoud get now playing movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getNowPlayingMovies(any))
        .thenAnswer((_) async => Right(tMovie));
    // act
    final result = await usecase(Params(page: tPage));
    //assert
    expect(result, Right(tMovie));
    verify(mockMovieRepository.getNowPlayingMovies(tPage));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
