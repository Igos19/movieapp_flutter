import 'dart:async';

import 'package:movieapp/DataLayer/movies_client.dart';
import 'package:movieapp/datalayer/movie.dart';

import 'bloc.dart';

class UpcomingMovieQueryBloc implements Bloc {
  final _controller = StreamController<List<Movie>>();
  final _client = MoviesClient();

  Stream<List<Movie>> get movieStream => _controller.stream;

  void getUpcomingMovies(int page) async {
    final results = await _client.fetchUpcomingMovies(page);
    if (!_controller.isClosed) _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
