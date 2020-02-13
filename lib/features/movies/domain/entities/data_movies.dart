import 'package:equatable/equatable.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';

class DataMovies extends Equatable {
  final List<Movie> results;
  final int page;
  final int totalResults;
  final int totalPages;

  DataMovies(this.results, this.page, this.totalResults, this.totalPages);

  @override
  List<Object> get props => [results, page, totalResults, totalPages];
}
