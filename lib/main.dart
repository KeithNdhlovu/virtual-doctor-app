import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/user_bloc.dart';
import 'package:heart_monitor/partials/blood_pressure.dart';
import 'package:heart_monitor/partials/consultations.dart';
import 'package:heart_monitor/partials/login.dart';
import 'package:heart_monitor/partials/setup.dart';
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
        builder: (context, user, _) {
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
            home: Scaffold(body: SetupPage(userBloc: user)),
            routes: <String, WidgetBuilder> {
              '/home': (BuildContext context) => new HomePage(userBloc: user),
              '/setup': (BuildContext context) => new SetupPage(userBloc: user),
              '/login': (BuildContext context) => new LoginPage(userBloc: user),
              '/blood-pressure': (BuildContext context) => new BloodPressurePage(userBloc: user),
              '/consultations': (BuildContext context) => new ConsultationsPage(userBloc: user),
            },
          );
        },
      ),
    );
  }
}