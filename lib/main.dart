import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/setup_bloc.dart';
import 'package:heart_monitor/partials/_login.dart';
import 'package:heart_monitor/partials/setup.dart';
import 'package:heart_monitor/partials/sleep.dart';
import 'package:provider/provider.dart';

import 'partials/home.dart';

void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: LoginPage()
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => SetupBloc()),
      ],
      child: Consumer<SetupBloc>(
        builder: (context, counter, _) {
          return MaterialApp(
            theme: new ThemeData(
              primaryColor: Color.fromRGBO(147, 1, 142, 1), 
              accentColor: Colors.deepPurpleAccent
            ),
            home: SetupPage(),
          );
        },
      ),
    );
  }
}