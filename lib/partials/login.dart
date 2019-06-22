import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  String username;
  String password;
  bool loading = false;

  void _onLoginPressed () {

    // We need to post this request to the server and show loader
    setState(() {
      loading = !this.loading;
    });

  }
  
  void _onUsernameChanged (String _username) {
    setState(() {
      username = _username;
    });
  }
  
  void _onPasswordChanged (String _password) {
    setState(() {
      password = _password;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Padding(
         padding: const EdgeInsets.all(20),
         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                onChanged: _onUsernameChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: TextField(
                obscureText: true,
                onChanged: _onPasswordChanged,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.blueAccent,
                onPressed: _onLoginPressed,
                child: Text(
                  this.loading ? "Loading ..." : "Login",
                  style: TextStyle(fontSize: 20.0),
                ),
              )
            ),
        ])),
    );
  }
}