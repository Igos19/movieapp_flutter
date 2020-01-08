import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movieapp/features/movies/domain/entities/data_movies.dart';

@immutable
abstract class MoviesState extends Equatable {
  MoviesState() : super();

  @override
  List<Object> get props => const <dynamic>[];
}

class Empty extends MoviesState {}

class Loading extends MoviesState {}

class Loaded extends MoviesState {
  final DataMovies movies;

  Loaded({@required this.movies}) : super();

  @override
  List<Object> get props => [movies];
}

class Error extends MoviesState {
  final String message;

  Error({@required this.message}) : super();

  @override
  List<Object> get props => [message];
}
