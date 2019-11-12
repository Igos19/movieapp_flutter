import 'package:flutter/material.dart';
import 'package:movieapp/bloc/bloc_provider.dart';
import 'package:movieapp/bloc/now_playing_movies_query_bloc.dart';
import 'package:movieapp/datalayer/movie.dart';
import 'package:movieapp/ui/movie_tile.dart';

// ignore: must_be_immutable
class NowPlayingMoviesPageScreen extends StatelessWidget {
  final ScrollController scrollController;

  final List<Movie> movies = new List();

  var currentPage = 1;

  NowPlayingMoviesPageScreen({Key key, @required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = NowPlayingMovieQueryBloc();

    if (currentPage == 1) loadPage(bloc, currentPage);

    return BlocProvider<NowPlayingMovieQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: _buildResults(bloc),
      ),
    );
  }

  void loadPage(NowPlayingMovieQueryBloc bloc, int page) {
    bloc.getNowPlayingMovies(page);
  }

  Widget _buildResults(NowPlayingMovieQueryBloc bloc) {
    return StreamBuilder<List<Movie>>(
      stream: bloc.movieStream,
      builder: (context, snapshot) {
        final results = snapshot.data;

        if (results == null) {
          return Center(child: Text('There\'s no movies'));
        }

        if (results.isEmpty) {
          return Center(child: Text('No Results'));
        }

        scrollController.addListener(() {
          if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
            currentPage++;
            loadPage(bloc, currentPage);
          }
        });
        movies.addAll(results);
        return _buildMoviesResults();
      },
    );
  }

  Widget _buildMoviesResults() {
    return Padding(
      padding: EdgeInsets.only(top: 4.0),
      child: GridView.builder(
        primary: false,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieTile(movie: movie);
        },
        controller: scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.67,
          mainAxisSpacing: 6,
          crossAxisSpacing: 6,
        ),
      ),
    );
  }
}
