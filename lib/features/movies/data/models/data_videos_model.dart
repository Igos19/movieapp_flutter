import 'package:movieapp/features/movies/data/models/video_model.dart';
import 'package:movieapp/features/movies/domain/entities/data_videos.dart';

class DataVideosModel extends DataVideos {
  DataVideosModel({List<VideoModel> results, int id}) : super(results, id);

  factory DataVideosModel.fromJson(Map<String, dynamic> json) {
    return DataVideosModel(
      results: json['results']
          .map<VideoModel>((json) => VideoModel.fromJson(json))
          .toList(growable: false),
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'results': results.map((video) => (video as VideoModel).toJson()),
        'id': id
      };
}
