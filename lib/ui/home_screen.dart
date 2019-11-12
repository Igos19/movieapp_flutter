import 'package:flutter/material.dart';
import 'package:movieapp/res/styles.dart';
import 'package:movieapp/ui/movies/popular_movies_page_screen.dart';

import 'movies/now_playing_movies_page_screen.dart';
import 'movies/top_movies_page_screen.dart';
import 'movies/upcoming_movies_page_screen.dart';

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
      new Tab(text: 'POPULAR'):
          PopularMoviesPageScreen(scrollController: _scrollController),
      new Tab(text: 'TOP'):
          TopMoviesPageScreen(scrollController: _scrollController),
      new Tab(text: 'UPCOMING'):
          UpcomingMoviesPageScreen(scrollController: _scrollController),
      new Tab(
          child: Text(
        'NOW PLAYING',
        textAlign: TextAlign.center,
      )): NowPlayingMoviesPageScreen(scrollController: _scrollController)
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
