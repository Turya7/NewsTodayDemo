import 'package:flutter/material.dart';
import 'package:news_today_demo/Ui/top_news_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: NewsTodayHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

