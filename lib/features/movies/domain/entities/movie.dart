import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String overview;
  final double popularity;
  final String posterPath;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final double rating;

  Movie(this.id, this.overview, this.popularity, this.posterPath, this.title,
      this.releaseDate, this.voteAverage, this.voteCount, this.rating);
}
