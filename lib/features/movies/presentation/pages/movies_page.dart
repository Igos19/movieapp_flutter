import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/features/movies/domain/entities/movie.dart';
import 'package:movieapp/features/movies/presentation/bloc/bloc.dart';
import 'package:movieapp/features/movies/presentation/bloc/movies_bloc.dart';
import 'package:movieapp/features/movies/presentation/widgets/message_display.dart';
import 'package:movieapp/features/movies/presentation/widgets/movies_grid.dart';
import 'package:movieapp/injection_container.dart';

class MoviesPage extends StatefulWidget {
  final ScrollController scrollController;
  final MoviesEvent event;

  MoviesPage({Key key, @required this.scrollController, @required this.event})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  var currentPage = 1;
  final List<Movie> movies = new List();
  var l;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBody(),
    );
  }

  BlocProvider<MoviesBloc> _buildBody() {
    return BlocProvider<MoviesBloc>(
      create: (context) {
        return sl<MoviesBloc>();
      },
      child: Padding(
        padding: EdgeInsets.only(top: 4.0),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            final listener = () {
              if (widget.scrollController.position.pixels ==
                  widget.scrollController.position.maxScrollExtent) {
                currentPage++;
                BlocProvider.of<MoviesBloc>(context).add(widget.event.recreate(currentPage));
                debugPrint(currentPage.toString());
              }
            };
            if (l != null) widget.scrollController.removeListener(l);
            widget.scrollController.addListener(listener);
            l = listener;
            if (state is Empty) {
              BlocProvider.of<MoviesBloc>(context)
                  .add(widget.event);
              return Center();
            } else if (state is Loading) {
              //return Center(child: CircularProgressIndicator());
            } else if (state is Loaded) {
              movies.addAll(state.movies.results);
              return MoviesGrid(
                movies: movies,
                scrollController: widget.scrollController,
              );
            } else if (state is Error) {
              return MessageDisplay(
                message: state.message,
              );
            }
            return MoviesGrid(
              movies: movies,
              scrollController: widget.scrollController,
            );
          },
        ),
      ),
    );
  }
}
