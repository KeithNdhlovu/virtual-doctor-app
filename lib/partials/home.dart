import 'package:flutter/material.dart';
import 'package:heart_monitor/partials/login.dart';
import 'package:heart_monitor/partials/setup.dart';
import 'package:heart_monitor/partials/sleep.dart';


// The Home page should be responsible for showing the login page, if the user is not logged in
// and should also show the respective content page once the user is successfully logged in
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