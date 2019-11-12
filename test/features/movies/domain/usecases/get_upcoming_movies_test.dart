import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';
import 'package:movieapp/features/movies/domain/repositories/movie_repository.dart';
import 'package:movieapp/features/movies/domain/usecases/get_upcoming_movies.dart';

class MockMovieRepository extends Mock implements MovieRepository {}

void main() {
  GetUpcomingMovies usecase;
  MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetUpcomingMovies(mockMovieRepository);
  });

  final tMovie = Movie(1, 'desc', 2.0, 'path', 'title', 'date', 3.0, 1, 10.0);
  final tPage = 1;

  test('shoud get upcoming movies from the repository', () async {
    // arrange
    when(mockMovieRepository.getUpcomingMovies(any))
        .thenAnswer((_) async => Right(tMovie));
    // act
    final result = await usecase(Params(page: tPage));
    //assert
    expect(result, Right(tMovie));
    verify(mockMovieRepository.getUpcomingMovies(tPage));
    verifyNoMoreInteractions(mockMovieRepository);
  });
}
