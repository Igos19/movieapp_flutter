import 'package:flutter/material.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';
import 'package:movieapp/features/movies/presentation/pages/movie_details_page.dart';
import 'package:movieapp/res/strings.dart';

import 'image_container.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key key,
    @required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movie: movie),
          ),
        );
      },
      child: GridTile(
        child: ImageContainer(
          height: 200,
          url: imageBasePath + movie.posterPath,
          placeholder: Colors.black,
        ),
      ),
    );
  }
}
