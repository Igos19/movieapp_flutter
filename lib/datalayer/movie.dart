class Movie {
  final int id;
  final String overview;
  final double popularity;
  final String posterPath;
  final String title;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final double rating;

  Movie.fromJson(json)
      : id = json['id'],
        overview = json['overview'],
        popularity = json['popularity'] * 1.0,
        posterPath = json['poster_path'],
        title = json['title'],
        releaseDate = json['release_date'],
        voteAverage = json['vote_average'] * 1.0,
        voteCount = json['vote_count'],
        rating = json['rating'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
