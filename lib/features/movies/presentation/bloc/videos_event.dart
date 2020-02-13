import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VideosEvent extends Equatable {
  final int id;

  VideosEvent(this.id) : super();

  @override
  List<Object> get props => [id];
}

class GetVideosEvent extends VideosEvent {
  GetVideosEvent({int id}) : super(id);
}
