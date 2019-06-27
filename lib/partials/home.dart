import 'package:flutter/material.dart';
import 'package:heart_monitor/partials/login.dart';
import 'package:heart_monitor/partials/setup.dart';
import 'package:heart_monitor/partials/sleep.dart';

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