import 'package:flutter/material.dart';
import 'package:movieapp/features/movies/presentation/bloc/movies_event.dart';
import 'package:movieapp/features/movies/presentation/pages/movies_page.dart';
import 'package:movieapp/res/styles.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController = new ScrollController();

  Map<Tab, Widget> _tabs;

  @override
  void initState() {
    _tabs = {
      new Tab(text: 'POPULAR'): MoviesPage(
          scrollController: _scrollController, event: GetPopularMoviesEvent()),
      new Tab(text: 'TOP'): MoviesPage(
          scrollController: _scrollController, event: GetTopRatedMoviesEvent()),
      new Tab(text: 'UPCOMING'): MoviesPage(
          scrollController: _scrollController, event: GetUpcomingMoviesEvent()),
      new Tab(
          child: Text(
        'NOW PLAYING',
        textAlign: TextAlign.center,
      )): MoviesPage(
          scrollController: _scrollController,
          event: GetNowPlayingMoviesEvent()),
    };
    _tabController = new TabController(length: _tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("MOVIES"),
        bottom: TabBar(
          unselectedLabelColor: mainColor,
          labelColor: Colors.red,
          labelStyle: labelTextStyle,
          tabs: _tabs.keys.toList(growable: false),
          controller: _tabController,
          indicatorColor: mainColor,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: _tabs.values.toList(growable: false),
        controller: _tabController,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
