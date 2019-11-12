import 'package:movieapp/DataLayer/movie.dart';

class DataMovies {
  final List<Movie> result;
  final int page;
  final int totalResults;
  final int totalPages;

  DataMovies.fromJson(json)
      : result = json['results'],
        page = json['page'],
        totalResults = json['total_results'],
        totalPages = json['total_pages'];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataMovies && runtimeType == other.runtimeType;

  @override
  int get hashCode => page.hashCode;
}
