import 'package:meta/meta.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  MovieModel({
    @required int id,
    @required bool adult,
    @required String overview,
    @required double popularity,
    @required String posterPath,
    @required String title,
    @required String releaseDate,
    @required List<int> genreIds,
    @required String originalTitle,
    @required String originalLanguage,
    @required String backdropPath,
    @required double voteAverage,
    @required bool video,
    @required int voteCount,
  }) : super(
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
          voteCount,
        );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      adult: json['adult'],
      overview: json['overview'],
      popularity: json['popularity'] * 1.0,
      posterPath: json['poster_path'],
      title: json['title'],
      releaseDate: json['release_date'],
      genreIds: json['genre_ids'].cast<int>(),
      originalTitle: json['original_title'],
      originalLanguage: json['original_language'],
      backdropPath: json['backdrop_path'],
      voteAverage: json['vote_average'] * 1.0,
      video: json['video'],
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'poster_path': posterPath,
        'adult': adult,
        'overview': overview,
        'release_date': releaseDate,
        'genre_ids': genreIds,
        'id': id,
        'original_title': originalTitle,
        'original_language': originalLanguage,
        'title': title,
        'backdrop_path': backdropPath,
        'popularity': popularity,
        'vote_count': voteCount,
        'video': false,
        'vote_average': 5.36
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
