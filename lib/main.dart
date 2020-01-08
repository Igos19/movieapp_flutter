import 'package:flutter/material.dart';
import 'package:movieapp/UI/home_screen.dart';
import 'package:movieapp/res/styles.dart';

import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(Movies());
}

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.black,
            iconTheme: IconThemeData(color: mainColor),
            textTheme: TextTheme(title: appBarTitleStyle)),
      ),
      home: HomePage(),
    );
  }
}
