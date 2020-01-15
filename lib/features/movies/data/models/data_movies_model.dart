import 'package:movieapp/features/movies/data/models/movie_model.dart';
import 'package:movieapp/features/movies/domain/entities/data_movies.dart';

class DataMoviesModel extends DataMovies {
  DataMoviesModel(
      {List<MovieModel> results, int page, int totalResults, int totalPages})
      : super(results, page, totalResults, totalPages);

  factory DataMoviesModel.fromJson(Map<String, dynamic> json) {
    return DataMoviesModel(
      results: json['results']
          .map<MovieModel>((json) => MovieModel.fromJson(json))
          .toList(growable: false),
      page: json['page'],
      totalResults: json['total_results'],
      totalPages: json['total_pages'],
    );
  }

  Map<String, dynamic> toJson() => {
        'results': results.map((movie) => (movie as MovieModel).toJson()),
        'page': page,
        'total_results': totalResults,
        'total_pages': totalPages
      };
}
