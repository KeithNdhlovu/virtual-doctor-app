import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/user_bloc.dart';
import 'package:heart_monitor/partials/consultations.dart';
import 'package:shared_preferences/shared_preferences.dart';


// The Home page should be responsible for showing the login page, if the user is not logged in
// and should also show the respective content page once the user is successfully logged in
class HomePage extends StatefulWidget {

  HomePage({Key key, this.userBloc}) : super(key: key);
  final UserBloc userBloc;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences _sharedPreferences;

  @override
  void initState() { 
    super.initState();
    this._fetchSessionAndNavigate();
  }

  @override
  Widget build(BuildContext context) {

    // does the user have an access token stored somewhere?
    return ConsultationsPage();
  }

  _fetchSessionAndNavigate() async {
    _sharedPreferences = await _prefs;
    String authToken = _sharedPreferences.getString('access_token');

    if (authToken == null) {
      Navigator.of(context)
        .pushReplacementNamed("/setup");
    }
  }
}