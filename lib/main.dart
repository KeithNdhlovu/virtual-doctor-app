import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/setup_bloc.dart';
import 'package:heart_monitor/partials/setup.dart';
import 'package:provider/provider.dart';

import 'partials/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SetupBloc>.value(
      notifier: SetupBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SetupPage(),
      )
    );
  }
}