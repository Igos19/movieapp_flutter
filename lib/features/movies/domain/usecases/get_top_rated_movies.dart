import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/core/usecases/usecase.dart';
import 'package:movieapp/features/movies/domain/entities/data_movies.dart';
import 'package:movieapp/features/movies/domain/repositories/movie_repository.dart';

class GetTopRatedMovies extends UseCase<DataMovies, Params> {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  @override
  Future<Either<Failure, DataMovies>> call(Params params) async {
    return await repository.getTopRatedMovies(params.page);
  }
}

class Params extends Equatable {
  final int page;

  Params({@required this.page}) : super([page]);
}
