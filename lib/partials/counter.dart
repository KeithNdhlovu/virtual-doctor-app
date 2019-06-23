import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/counter_bloc.dart';
import 'package:heart_monitor/partials/decrement.dart';
import 'package:heart_monitor/partials/incremement.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: new Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "2",
                style: TextStyle(fontSize: 62.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}