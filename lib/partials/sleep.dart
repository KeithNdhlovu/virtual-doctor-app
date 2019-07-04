import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';

class SleepPage extends StatefulWidget {
  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);

  int initSystolic;
  int initDiastolic;

  int systolic;
  int diastolic;

  String initText = 'Place you thumb on fingerprint section';
  String statusText = "";

  @override
  void initState() {
    super.initState();
    _shuffle();
    _initialStatus();
  }

  void _initialStatus() {
    setState(() {
      statusText = initText;
    });
  }

  void _shuffle() {
    setState(() {
      initSystolic = _generateRandomTime();
      initDiastolic = _generateRandomTime();
      systolic = initSystolic;
      diastolic = initDiastolic;
    });
  }

  void _updateLabels(int init, int end, int x) {
    setState(() {
      systolic = init;
      diastolic = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _sleepPage(Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          statusText,
          style: TextStyle(color: Colors.white),
        ),
        _circleSlider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _formatBedTime('Systolic', systolic),
          _formatBedTime('Diastolic', diastolic),
        ]),
        FlatButton(
          child: Image.asset(
            "images/thumb-print.png",
            fit: BoxFit.contain, 
            width: 90,
            height: 90,
          ),
          onPressed: _generateRandomBloodPressure,
        ),
        _showOrHideContinueButton(false),
      ],
    ));
  }

  Widget _circleSlider() {
    DoubleCircularSlider slider = DoubleCircularSlider(
      288,
      initSystolic,
      initDiastolic,
      height: 260.0,
      width: 260.0,
      primarySectors: 6,
      secondarySectors: 24,
      baseColor: Color.fromRGBO(255, 255, 255, 0.1),
      selectionColor: baseColor,
      handlerColor: Colors.white,
      handlerOutterRadius: 12.0,
      onSelectionChange: _updateLabels,
      sliderStrokeWidth: 12.0,
      child: Padding(
        padding: const EdgeInsets.all(42.0),
        child: Center(
            child: Text('${_formatIntervalTime(systolic, diastolic)}',
                style: TextStyle(fontSize: 36.0, color: Colors.white))),
      ),
    );

    return slider;
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
      onPressed: _shuffle,
    );
  }

  Widget _formatBedTime(String pre, int time) {
    return Column(
      children: [
        Text(pre, style: TextStyle(color: baseColor)),
        Text(
          '${_formatTime(time)}',
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
  
  String _formatTime(int time) {
    if (time == 0 || time == null) {
      return '00:00';
    }
    var hours = time ~/ 12;
    var minutes = (time % 12) * 5;
    return '$hours:$minutes';
  }

  String _formatIntervalTime(int init, int end) {
    var sleepTime = end > init ? end - init : 288 - init + end;
    var hours = sleepTime ~/ 12;
    var minutes = (sleepTime % 12) * 5;
    return '${hours}h${minutes}m';
  }

  int _generateRandomTime() => Random().nextInt(288);


  void _generateRandomBloodPressure() {
    _shuffle();
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