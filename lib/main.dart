import 'package:flutter/material.dart';
import './screens/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quake App',
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}