import 'package:flutter/material.dart';
import 'package:top_subreddit/pages/home_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Subreddit Viewer',
      theme: ThemeData(
        canvasColor: Color(0xFFFFFFFF),
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
