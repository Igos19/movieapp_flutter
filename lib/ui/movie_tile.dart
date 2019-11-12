import 'package:flutter/material.dart';
import 'package:movieapp/UI/movie_details_screen.dart';
import 'package:movieapp/datalayer/movie.dart';

import '../res/strings.dart';
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
            builder: (context) => MovieDetailsScreen(movie: movie),
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
