import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movieapp/bloc/bloc_provider.dart';
import 'package:movieapp/bloc/videos_query_bloc.dart';
import 'package:movieapp/datalayer/video.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';
import 'package:movieapp/features/movies/presentation/widgets/image_container.dart';
import 'package:movieapp/features/movies/presentation/widgets/play_video_screen.dart';
import 'package:movieapp/res/styles.dart';

import '../../../../res/strings.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = VideosQueryBloc();

    bloc.getVideos(movie.id);

    return BlocProvider<VideosQueryBloc>(
      bloc: bloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text(movie.title),
        ),
        backgroundColor: Colors.black,
        body: _buildResults(context, bloc),
      ),
    );
  }

  _buildResults(BuildContext context, VideosQueryBloc bloc) {
    return StreamBuilder<List<Video>>(
      stream: bloc.videosStream,
      builder: (context, snapshot) {
        final results = snapshot.data;

        var video;
        if (results != null && results.isNotEmpty) {
          video = results.firstWhere(
              (video) => video.site == 'YouTube' && video.type == 'Trailer');
        } else {
          video = null;
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildBanner(context, video),
              _buildDetails(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBanner(BuildContext context, Video video) {
    return Column(
      children: <Widget>[
        ImageContainer(
          height: 300,
          url: imageBasePath + movie.posterPath,
        ),
        Container(
          alignment: Alignment.bottomRight,
          transform: Matrix4.translationValues(0.0, -30.0, 0.0),
          margin: const EdgeInsets.only(right: 20),
          child: FloatingActionButton(
            onPressed: () {
              if (video != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PlayVideoScreen(
                      videoId: video.key,
                      videoName: movie.title,
                    ),
                  ),
                );
              }
            },
            child: Icon(Icons.play_arrow),
            backgroundColor: mainColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDetails() {
    return Container(
      transform: Matrix4.translationValues(0.0, -30.0, 0.0),
      child: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Rating:',
              textAlign: TextAlign.center,
              style: titleStyle,
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                RatingBarIndicator(
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: mainColor,
                  ),
                  unratedColor: black90,
                  rating: movie.voteAverage / 2,
                  itemCount: 5,
                ),
                Text(
                  '(${movie.voteCount})',
                  style: textStyle,
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Overview:',
              style: titleStyle,
            ),
            SizedBox(height: 10),
            Text(
              movie.overview,
              style: textStyle,
            ),
            SizedBox(height: 20),
            Text(
              'Release Date: ',
              style: titleStyle,
            ),
            SizedBox(height: 10),
            Text(
              movie.releaseDate,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}
