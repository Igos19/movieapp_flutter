import 'dart:async';
import 'dart:convert' show json;

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movieapp/datalayer/movie.dart';
import 'package:movieapp/datalayer/video.dart';

class MoviesClient {
  final _apiKey = 'a638a19e1279ce455bae9f6415ce22b9';
  final _host = 'api.themoviedb.org';
  final _contextRoot = '3';

  Future<List<Movie>> fetchPopularMovies(int page) async {
    return fetchMovies(page, 'movie/popular');
  }

  Future<List<Movie>> fetchTopMovies(int page) async {
    return fetchMovies(page, 'movie/top_rated');
  }

  Future<List<Movie>> fetchUpcomingMovies(int page) async {
    return fetchMovies(page, 'movie/upcoming');
  }

  Future<List<Movie>> fetchNowPlayingMovies(int page) async {
    return fetchMovies(page, 'movie/now_playing');
  }

  Future<List<Movie>> fetchMovies(int page, String path) async {
    final results = await request(
        path: path, parameters: setParameters({'page': page.toString()}));

    final dataMovies = results['results'];
    return dataMovies
        .map<Movie>((json) => Movie.fromJson(json))
        .toList(growable: false);
  }

  Future<List<Video>> fetchMovieVideos(int id) async {
    final results = await request(
      parameters: _parameters,
      path: 'movie/$id/videos',
    );

    final dataVideos = results['results'];
    return dataVideos
        .map<Video>((json) => Video.fromJson(json))
        .toList(growable: false);
  }

  Future<Map> request(
      {@required String path, Map<String, String> parameters}) async {
    final uri = Uri.https(_host, '$_contextRoot/$path', parameters);
    print(uri);
    print(_headers);
    final results = await http.get(uri, headers: _headers);
    final jsonObject = json.decode(results.body);
    print(jsonObject);
    return jsonObject;
  }

  Map<String, String> get _headers => {'Accept': 'application/json'};

  Map<String, String> get _parameters => {'api_key': _apiKey};

  Map<String, String> setParameters(Map<String, String> parameters) {
    var resultParams = _parameters;
    resultParams.addAll(parameters);
    return resultParams;
  }
}
