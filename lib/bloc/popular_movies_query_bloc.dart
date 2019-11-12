import 'dart:async';

import 'package:movieapp/DataLayer/movies_client.dart';
import 'package:movieapp/datalayer/movie.dart';

import 'bloc.dart';

class PopularMovieQueryBloc implements Bloc {
  final _controller = StreamController<List<Movie>>();
  final _client = MoviesClient();

  Stream<List<Movie>> get movieStream => _controller.stream;

  void getPopularMovies(int page) async {
    final results = await _client.fetchPopularMovies(page);
    if (!_controller.isClosed) _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
