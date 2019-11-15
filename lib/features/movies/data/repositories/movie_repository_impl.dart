import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/core/error/exceptions.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/core/platform/network_info.dart';
import 'package:movieapp/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:movieapp/features/movies/data/models/movie_model.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';
import 'package:movieapp/features/movies/domain/repositories/movie_repository.dart';

enum MoviesCategory { popular, top_rated, upcoming, now_playing }

class MovieRepositoryImpl extends MovieRepository {
  final NetworkInfo networkInfo;

  final MovieRemoteDataSource source;

  MovieRepositoryImpl({@required this.source, @required this.networkInfo});

  @override
  Future<Either<Failure, Movie>> getNowPlayingMovies(int page) =>
      _getMovies(MoviesCategory.now_playing, page);

  @override
  Future<Either<Failure, Movie>> getPopularMovies(int page) =>
      _getMovies(MoviesCategory.popular, page);

  @override
  Future<Either<Failure, Movie>> getTopRatedMovies(int page) =>
      _getMovies(MoviesCategory.top_rated, page);

  @override
  Future<Either<Failure, Movie>> getUpcomingMovies(int page) =>
      _getMovies(MoviesCategory.upcoming, page);

  Future<Either<Failure, Movie>> _getMovies(
      MoviesCategory category, int page) async {
    if (!(await networkInfo.isConnected)) return Left(NetworkFailure());
    MovieModel movies;

    try {
      switch (category) {
        case MoviesCategory.popular:
          movies = await source.getNowPlayingMovies(page);
          break;
        case MoviesCategory.top_rated:
          movies = await source.getTopRatedMovies(page);
          break;
        case MoviesCategory.upcoming:
          movies = await source.getUpcomingMovies(page);
          break;
        case MoviesCategory.now_playing:
          movies = await source.getNowPlayingMovies(page);
          break;
      }
      return Right(movies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
