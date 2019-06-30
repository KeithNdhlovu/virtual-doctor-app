import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/user_bloc.dart';
import 'package:provider/provider.dart';

import 'loader.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat', 
    fontSize: 20.0
  );

  String _username = "";
  String _password = "";

  void _onUsernameChange(String username) {
    setState(() {
      _username = username;
    });
  }

  void _onPasswordChange(String password) {
    setState(() {
      _password = password;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final _userBloc = Provider.of<UserBloc>(context);

    final emailField = TextField(
      style: style,
      onChanged: this._onUsernameChange,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    // Update the build context of the user bloc
    _userBloc.context = context;

    final passwordField = TextField(
      obscureText: true,
      style: style,
      onChanged: this._onPasswordChange,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    final loginButon = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => !_userBloc.loading ? _userBloc.postLogin(this._username, this._password) : null,
        child: !_userBloc.loading ? Text("Login", textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
            ) : Text("Loading ...")
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Login')
      ),
      body: SingleChildScrollView(
      child: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 20),  
                child: SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "images/logo.png",
                    fit: BoxFit.contain,
                  ),
                )
              ),
              SizedBox(
                height: 50,
                child: Text("Virtual Doctor", style: new TextStyle(fontSize: 25, color: Colors.white)),
              ),
              Card( 
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Column(children: <Widget>[
                      (_userBloc.error != "") ? Column(
                        children: <Widget>[
                          SizedBox(height: 25.0),
                          Text(
                            _userBloc.error.toString(),
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ) : Text(""),
                      SizedBox(height: 25.0), emailField,
                      SizedBox(height: 25.0), passwordField,
                      SizedBox(height: 35.0), loginButon,
                      SizedBox(height: 15.0),
                    ])
                  )
              )
              ],
            ),
          ),
        ),
      ),
        )
    );
  }
}