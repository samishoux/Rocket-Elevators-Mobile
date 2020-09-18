import 'package:flutter/material.dart';
import 'home/home.dart';
BuildContext globalContext;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return MaterialApp(
      home:Home(),
    );
  }
}