import 'package:dartz/dartz.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/features/movies/domain/entities/data_movies.dart';
import 'package:movieapp/features/movies/domain/entities/data_videos.dart';

abstract class MovieRepository {
  Future<Either<Failure, DataMovies>> getPopularMovies(int page);

  Future<Either<Failure, DataMovies>> getTopRatedMovies(int page);

  Future<Either<Failure, DataMovies>> getUpcomingMovies(int page);

  Future<Either<Failure, DataMovies>> getNowPlayingMovies(int page);

  Future<Either<Failure, DataVideos>> getVideos(int id);
}
