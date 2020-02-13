import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:movieapp/core/error/failures.dart';
import 'package:movieapp/features/movies/domain/entities/data_videos.dart';
import 'package:movieapp/features/movies/domain/usecases/get_videos.dart';

import './bloc.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetVideos getVideos;

  VideosBloc({@required GetVideos videos})
      : assert(videos != null),
        getVideos = videos;

  @override
  VideosState get initialState => EmptyVideos();

  @override
  Stream<VideosState> mapEventToState(
    VideosEvent event,
  ) async* {
    yield LoadingVideos();
    var failureOrVideos = await getVideos.call(Params(id: event.id));
    yield* _eitherLoadedOrErrorState(failureOrVideos);
  }

  Stream<VideosState> _eitherLoadedOrErrorState(
    Either<Failure, DataVideos> failureOrVideos,
  ) async* {
    yield failureOrVideos.fold(
      (failure) => ErrorVideos(message: _mapFailureToMessage(failure)),
      (video) => LoadedVideos(videos: video),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case NetworkFailure:
        return NETWORK_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
