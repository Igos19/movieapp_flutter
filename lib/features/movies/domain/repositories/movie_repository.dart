import 'package:dartz/dartz.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure, Movie>> getPopularMovies(int page);

  Future<Either<Failure, Movie>> getTopRatedMovies(int page);

  Future<Either<Failure, Movie>> getUpcomingMovies(int page);

  Future<Either<Failure, Movie>> getNowPlayingMovies(int page);
}
