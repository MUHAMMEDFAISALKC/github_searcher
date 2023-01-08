import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_searcher/presentation/main_page/screen_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.amber),
      title: 'GitHub Searcher',
      home: ScreenMain(),
    );
  }
}
