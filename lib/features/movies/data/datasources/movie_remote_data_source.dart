import 'package:movieapp/features/movies/data/models/data_movies_model.dart';

abstract class MovieRemoteDataSource {
  /// Calls the https://api.themoviedb.org/3/movie/popular endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DataMoviesModel> getPopularMovies(int page);

  /// Calls the https://api.themoviedb.org/3/movie/top_rated endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DataMoviesModel> getTopRatedMovies(int page);

  /// Calls the https://api.themoviedb.org/3/movie/upcoming endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DataMoviesModel> getUpcomingMovies(int page);

  /// Calls the https://api.themoviedb.org/3/movie/now_playing endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<DataMoviesModel> getNowPlayingMovies(int page);
}
