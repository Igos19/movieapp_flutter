import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movieapp/core/error/exceptions.dart';
import 'package:movieapp/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:movieapp/features/movies/data/models/data_movies_model.dart';

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final _apiKey = 'a638a19e1279ce455bae9f6415ce22b9';
  final _host = 'api.themoviedb.org';
  final _contextRoot = '3';
  final http.Client httpClient;

  MovieRemoteDataSourceImpl({@required this.httpClient});

  @override
  Future<DataMoviesModel> getNowPlayingMovies(int page) =>
      _fetchMovies(page, 'movie/now_playing');

  @override
  Future<DataMoviesModel> getPopularMovies(int page) =>
      _fetchMovies(page, 'movie/popular');

  @override
  Future<DataMoviesModel> getTopRatedMovies(int page) =>
      _fetchMovies(page, 'movie/top_rated');

  @override
  Future<DataMoviesModel> getUpcomingMovies(int page) =>
      _fetchMovies(page, 'movie/upcoming');

  Future<DataMoviesModel> _fetchMovies(int page, String path) => _request(
      path: path, parameters: setParameters({'page': page.toString()}));

  Future<DataMoviesModel> _request(
      {@required String path, Map<String, String> parameters}) async {
    final uri = Uri.https(_host, '$_contextRoot/$path', parameters);
    print(uri);
    print(headers);
    final response = await httpClient.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return DataMoviesModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  Map<String, String> get headers => {'Accept': 'application/json'};

  Map<String, String> get _parameters => {'api_key': _apiKey};

  Map<String, String> setParameters(Map<String, String> parameters) {
    var resultParams = _parameters;
    resultParams.addAll(parameters);
    return resultParams;
  }
}
