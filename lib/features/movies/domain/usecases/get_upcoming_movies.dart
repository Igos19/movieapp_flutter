import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/core/usecases/usecase.dart';
import 'package:movieapp/features/movies/domain/entities/data_movies.dart';
import 'package:movieapp/features/movies/domain/repositories/movie_repository.dart';

class GetUpcomingMovies extends UseCase<DataMovies, Params> {
  final MovieRepository repository;

  GetUpcomingMovies(this.repository);

  @override
  Future<Either<Failure, DataMovies>> call(Params params) async {
    return await repository.getUpcomingMovies(params.page);
  }
}

class Params extends Equatable {
  final int page;

  Params({@required this.page}) : super();

  @override
  List<Object> get props => [page];
}
