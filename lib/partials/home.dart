import 'package:flutter/material.dart';
import 'sleep.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background_morning.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: SleepPage()),
    ));
  }
}