import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/core/usecases/usecase.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';
import 'package:movieapp/features/movies/domain/repositories/movie_repository.dart';

class GetNowPlayingMovies extends UseCase<Movie, Params> {
  final MovieRepository repository;

  GetNowPlayingMovies(this.repository);

  @override
  Future<Either<Failure, Movie>> call(Params params) async {
    return await repository.getNowPlayingMovies(params.page);
  }
}

class Params extends Equatable {
  final int page;

  Params({@required this.page}) : super([page]);
}
