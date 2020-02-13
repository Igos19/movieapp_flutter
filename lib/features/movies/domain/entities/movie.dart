import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final bool adult;
  final String overview;
  final double popularity;
  final String posterPath;
  final String title;
  final String releaseDate;
  final List<int> genreIds;
  final String originalTitle;
  final String originalLanguage;
  final String backdropPath;
  final double voteAverage;
  final bool video;
  final int voteCount;

  Movie(
      this.id,
      this.adult,
      this.overview,
      this.popularity,
      this.posterPath,
      this.title,
      this.releaseDate,
      this.genreIds,
      this.originalTitle,
      this.originalLanguage,
      this.backdropPath,
      this.voteAverage,
      this.video,
      this.voteCount);

  @override
  List<Object> get props => [
        id,
        adult,
        overview,
        popularity,
        posterPath,
        title,
        releaseDate,
        genreIds,
        originalTitle,
        originalLanguage,
        backdropPath,
        voteAverage,
        video,
        voteCount
      ];
}
