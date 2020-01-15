import 'package:flutter/cupertino.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';
import 'package:movieapp/features/movies/presentation/widgets/movie_tile.dart';

class MoviesGrid extends StatelessWidget {
  final List<Movie> movies;

  final ScrollController scrollController;

  const MoviesGrid({Key key, this.movies, this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      primary: false,
      itemCount: this.movies.length,
      itemBuilder: (context, index) {
        final movie = this.movies[index];
        return MovieTile(movie: movie);
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
