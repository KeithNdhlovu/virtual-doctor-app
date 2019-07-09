import 'package:flutter/material.dart';
import 'package:heart_monitor/partials/consultations.dart';
import 'package:heart_monitor/services/response/user_response.dart';
import 'package:heart_monitor/partials/login.dart';
import 'package:heart_monitor/blocs/user_bloc.dart';
import 'package:provider/provider.dart';

class SetupPage extends StatefulWidget {
  SetupPage({Key key}) : super(key: key);

  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {

  final TextStyle style = TextStyle(
    fontFamily: 'Montserrat', 
    fontSize: 20.0
  );

  _fetchSessionAndNavigate(BuildContext context, UserBloc _userBloc) async {
    // Has the user alredy loged in, then we need to show them the list of consultations
    final user = await _userBloc.user;

    if (user is UserResponse && user.user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ConsultationsPage(title: "Consultations"))
      );
      return;
    }
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage(title: "Login"))
    );

  }

  @override
  Widget build(BuildContext context) {
    final _userBloc = Provider.of<UserBloc>(context);

    final _ipField = TextField(
      style: style,
      onChanged: (String ip) {
        _userBloc.ipAddress = ip;
        _userBloc.host = "http://" + ip;
      },
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "IP Address",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    final _continueButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5),
      color: Theme.of(context).primaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {

          if (_userBloc.ipAddress.isEmpty) {
            final snackBar = SnackBar(content: Text("Please Enter IP Address to continue"));
            Scaffold.of(context).showSnackBar(snackBar);
            return;
          }

          this._fetchSessionAndNavigate(context, _userBloc);

        },
        child: Text("Continue",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
            ),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
      child: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              SizedBox(height: 50.0),
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
                      SizedBox(height: 45.0), _ipField,
                      SizedBox(height: 35.0), _continueButton,
                      SizedBox(height: 15.0)
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