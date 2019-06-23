import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:heart_monitor/blocs/setup_bloc.dart';

class SetupPage extends StatelessWidget {
  
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat', 
    fontSize: 20.0
  );

  @override
  Widget build(BuildContext context) {

    final SetupBloc setupBloc = Provider.of<SetupBloc>(context);

    final appColor = Color.fromRGBO(147, 1, 142, 1);

    final ipField = TextField(
      style: style,
      onChanged: setupBloc.setIPAddress,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "IP Address",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );

    final continueButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(5),
      color: appColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {},
        child: Text("Continue",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
            ),
      ),
    );

    return Scaffold(
      backgroundColor: appColor,
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
                padding: EdgeInsets.only(bottom: 20),  
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
                      SizedBox(height: 45.0), ipField,
                      SizedBox(height: 35.0), continueButton,
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