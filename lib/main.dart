import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/setup_bloc.dart';
import 'package:heart_monitor/blocs/user_bloc.dart';
import 'package:heart_monitor/partials/setup.dart';
import 'package:heart_monitor/partials/sleep.dart';
import 'package:provider/provider.dart';

import 'partials/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(builder: (_) => SetupBloc()),
        ChangeNotifierProvider(builder: (_) => UserBloc()),
      ],
      child: Consumer<UserBloc>(
        builder: (context, counter, _) {
          return MaterialApp(
            theme: new ThemeData(
              primaryColor: Color.fromRGBO(147, 1, 142, 1), 
              accentColor: Colors.deepPurpleAccent
            ),
            home: Scaffold(body: HomePage()),
          );
        },
      ),
    );
  }
}