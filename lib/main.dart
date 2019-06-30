import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/setup_bloc.dart';
import 'package:heart_monitor/blocs/user_bloc.dart';
import 'package:heart_monitor/partials/consultations.dart';
import 'package:heart_monitor/partials/login.dart';
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
        ChangeNotifierProvider(builder: (_) => UserBloc()),
      ],
      child: Consumer<UserBloc>(
        builder: (context, counter, _) {
          return MaterialApp(
            title: 'Virtual Doctor',
            theme: new ThemeData(
              primaryColor: Color.fromRGBO(147, 1, 142, 1), 
              accentColor: Colors.deepPurpleAccent,
              textTheme: TextTheme(
                    title: TextStyle(fontSize: 30, color: Colors.white),
                    subtitle: TextStyle(fontSize: 20, color: Colors.white),
                    body1: TextStyle(fontSize: 15, color: Colors.white),
              )
            ),
            home: Scaffold(body: SetupPage()),
            routes: <String, WidgetBuilder> {
              '/home': (BuildContext context) => new HomePage(),
              '/setup': (BuildContext context) => new SetupPage(),
              '/login': (BuildContext context) => new LoginPage(),
              '/blood-pressure': (BuildContext context) => new SleepPage(),
              '/consultations': (BuildContext context) => new ConsultationsPage(),
            },
          );
        },
      ),
    );
  }
}