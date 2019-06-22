import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_circular_slider/flutter_circular_slider.dart';

import 'partials/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}