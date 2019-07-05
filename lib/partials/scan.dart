import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/user_bloc.dart';
import 'package:heart_monitor/models/consultation.dart';
import 'package:heart_monitor/partials/blood_pressure.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key key, this.consultation, this.userBloc}) : super(key: key);

  final Consultation consultation;
  final UserBloc userBloc;

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);

  String initText = 'Place your thumb on fingerprint section';
  String statusText = "";

  int _counter = 5;

  bool _buttonPressed = false;
  bool _loopActive = false;

  void _increaseCounterWhilePressed() async {


    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      setState(() {
        _counter--;
      });

      print("Counter: ${_counter.toString()}");

      if (_counter == 0) {
        // when the countner reaches zero we redirect to the random heart rate page
        _buttonPressed = false;
        // widget.consultation
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BloodPressurePage(consultation: widget.consultation, userBloc: widget.userBloc)
          )
        );
        break;
      }
      // wait a bit
      await Future.delayed(Duration(milliseconds: 1000));
    }

    _loopActive = false;
  }

  @override
  void initState() {
    super.initState();
    _initialStatus();
  }

  void _initialStatus() {
    setState(() {
      statusText = initText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _sleepPage(Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          statusText,
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(height: 20),
        Text('${_counter.toString()}s', style: TextStyle(fontSize: 36.0, color: Colors.white)),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [
            Listener(
              onPointerDown: (details) {
                _buttonPressed = true;
                _increaseCounterWhilePressed();
              },
              onPointerUp: (details) {
                _buttonPressed = false;
              },
              child: FlatButton(
                child: Image.asset(
                  "images/thumb-print.png",
                  fit: BoxFit.contain, 
                  width: 90,
                  height: 90,
                ),
                onPressed: null,
              ),
            )
          // _showOrHideContinueButton(false)
          ]
        ),
      ],
    ));
  }

  Widget _showOrHideContinueButton(bool isLoading) {
    
    if (isLoading) {
      return CircularProgressIndicator();
    }
    
    return FlatButton(
      child: Text('Continue'),
      color: baseColor,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0),
      ),
      onPressed: _navigateToPage,
    );
  }

  void _navigateToPage() {
    
  }


  Widget _sleepPage(Column column) {
    return Scaffold(
      body: SafeArea(
      child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background_morning.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: column),
    ));
  }
}