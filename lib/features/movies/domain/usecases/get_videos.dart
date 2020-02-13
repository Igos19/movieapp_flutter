import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/core/usecases/usecase.dart';
import 'package:movieapp/features/movies/domain/entities/data_videos.dart';
import 'package:movieapp/features/movies/domain/repositories/movie_repository.dart';

class GetVideos extends UseCase<DataVideos, Params> {
  final MovieRepository repository;

  GetVideos(this.repository);

  @override
  Future<Either<Failure, DataVideos>> call(Params params) async {
    return await repository.getVideos(params.id);
  }
}

class Params extends Equatable {
  final int id;

  Params({@required this.id}) : super();

  @override
  List<Object> get props => [id];
}
