import 'dart:async';

import 'package:movieapp/DataLayer/movies_client.dart';
import 'package:movieapp/datalayer/movie.dart';
import 'package:movieapp/datalayer/video.dart';

import 'bloc.dart';

class VideosQueryBloc implements Bloc {
  final _controller = StreamController<List<Video>>();
  final _client = MoviesClient();

  Stream<List<Video>> get videosStream => _controller.stream;

  void getVideos(int id) async {
    final results = await _client.fetchMovieVideos(id);
    if (!_controller.isClosed) _controller.sink.add(results);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
