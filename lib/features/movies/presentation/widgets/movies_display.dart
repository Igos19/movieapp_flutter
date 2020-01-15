import 'package:flutter/material.dart';
import 'package:movieapp/datalayer/data_movies.dart';
import 'package:movieapp/features/movies/presentation/widgets/movie_tile.dart';

class MoviesDisplay extends StatelessWidget {
  final DataMovies movies;
  final ScrollController scrollController;

  const MoviesDisplay({Key key, this.movies, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      itemCount: movies.result.length,
      itemBuilder: (context, index) {
        final movie = movies.result[index];
        //return MovieTile(movie: movie);
      },
      controller: scrollController,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.67,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
      ),
    );
  }
}
