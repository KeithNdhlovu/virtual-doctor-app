import 'package:flutter/material.dart';
import 'pulse.dart';
import '_login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: Container(
          decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage('images/background_morning.png'),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: LoginPage()),
    ));
  }
}