import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:movieapp/features/movies/data/datasources/movie_remote_data_source_impl.dart';
import 'package:movieapp/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:movieapp/features/movies/domain/repositories/movie_repository.dart';
import 'package:movieapp/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movieapp/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:movieapp/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movieapp/features/movies/domain/usecases/get_upcoming_movies.dart';
import 'package:movieapp/features/movies/presentation/bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/movies/data/datasources/movie_remote_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Movies
  // Bloc
  sl.registerFactory(
    () => MoviesBloc(
        popular: sl(), topRated: sl(), upcoming: sl(), nowPlaying: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetPopularMovies(sl()));
  sl.registerLazySingleton(() => GetTopRatedMovies(sl()));
  sl.registerLazySingleton(() => GetUpcomingMovies(sl()));
  sl.registerLazySingleton(() => GetNowPlayingMovies(sl()));

  // Repository
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      networkInfo: sl(),
      source: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<MovieRemoteDataSource>(
    () => MovieRemoteDataSourceImpl(httpClient: sl()),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
