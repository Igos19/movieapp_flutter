import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/core/error/exceptions.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/core/network/network_info.dart';
import 'package:movieapp/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:movieapp/features/movies/data/models/data_movies_model.dart';
import 'package:movieapp/features/movies/domain/entities/data_movies.dart';
import 'package:movieapp/features/movies/domain/repositories/movie_repository.dart';

enum MoviesCategory { popular, top_rated, upcoming, now_playing }

class MovieRepositoryImpl extends MovieRepository {
  final NetworkInfo networkInfo;

  final MovieRemoteDataSource source;

  MovieRepositoryImpl({@required this.source, @required this.networkInfo});

  @override
  Future<Either<Failure, DataMovies>> getNowPlayingMovies(int page) =>
      _getMovies(MoviesCategory.now_playing, page);

  @override
  Future<Either<Failure, DataMovies>> getPopularMovies(int page) =>
      _getMovies(MoviesCategory.popular, page);

  @override
  Future<Either<Failure, DataMovies>> getTopRatedMovies(int page) =>
      _getMovies(MoviesCategory.top_rated, page);

  @override
  Future<Either<Failure, DataMovies>> getUpcomingMovies(int page) =>
      _getMovies(MoviesCategory.upcoming, page);

  Future<Either<Failure, DataMovies>> _getMovies(
      MoviesCategory category, int page) async {
    if (!(await networkInfo.isConnected)) return Left(NetworkFailure());
    DataMoviesModel dataMovies;

    try {
      switch (category) {
        case MoviesCategory.popular:
          dataMovies = await source.getPopularMovies(page);
          break;
        case MoviesCategory.top_rated:
          dataMovies = await source.getTopRatedMovies(page);
          break;
        case MoviesCategory.upcoming:
          dataMovies = await source.getUpcomingMovies(page);
          break;
        case MoviesCategory.now_playing:
          dataMovies = await source.getNowPlayingMovies(page);
          break;
      }
      return Right(dataMovies);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
