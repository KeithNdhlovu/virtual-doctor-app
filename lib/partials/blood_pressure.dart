import 'dart:math';
import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/user_bloc.dart';
import 'package:heart_monitor/models/consultation.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';

class BloodPressurePage extends StatefulWidget {
  
  BloodPressurePage({Key key, this.consultation, this.userBloc}) : super(key: key);
  final Consultation consultation;
  final UserBloc userBloc;

  @override
  _BloodPressurePageState createState() => _BloodPressurePageState();
}

class _BloodPressurePageState extends State<BloodPressurePage> {
  final baseColor = Color.fromRGBO(255, 255, 255, 0.3);

  int initSystolic;
  int initDiastolic;

  int systolic;
  int diastolic;
  
  int bracket;
  String label;

  String statusText = 'Here are your readings';
  List<int> brackets = [0, 1, 2, 3, 4];
  List<String> bLabels = ["Low", "Normal", "Pre Hypertension", "High: Stage 1 Hypertension", "High: Stage 2 Hypertension"];
  
  @override
  void initState() {
    super.initState();
    _initialStatus();
    _generateBPForBrancket(_generateBetween(0, 4));
  }

  void _initialStatus() {
    setState(() {
      statusText = 'Here are your readings';
    });
  }

  void _generateBPForBrancket(int _bracket) {

    switch (_bracket) {
      case 0: {
        _generateLowBP();
        break;
      }
      case 1: {
        _generateNormalBP();
        break;
      }
      case 2: {
        _generatePreHighBP();
        break;
      }
      case 3: {
        _generateStageOneHighBP();
        break;
      }
      case 4: {
        _generateStageTwoHighBP();
        break;
      }
      default: {
        _generateLowBP();
      }
    }
  }

  void _generateLowBP() {
    setState(() {
      label = bLabels[0];
      systolic = _generateRandomSystolic(70, 90);
      diastolic = _generateRandomDiastolic(40, 60);
    });

    _postBloodPressureResults();
  }

  void _generateNormalBP() {
    setState(() {
      label = bLabels[1];
      systolic = _generateRandomSystolic(90, 120);
      diastolic = _generateRandomDiastolic(60, 80);
    });

    _postBloodPressureResults();
  }

  void _generatePreHighBP() {
    setState(() {
      label = bLabels[2];
      systolic = _generateRandomSystolic(120, 140);
      diastolic = _generateRandomDiastolic(80, 90);
    });

    _postBloodPressureResults();
  }

  void _generateStageOneHighBP() {
    setState(() {
      label = bLabels[3];
      systolic = _generateRandomSystolic(140, 160);
      diastolic = _generateRandomDiastolic(90, 100);
    });

    _postBloodPressureResults();
  }

  void _generateStageTwoHighBP() {
    setState(() {
      label = bLabels[4];
      systolic = _generateRandomSystolic(160, 190);
      diastolic = _generateRandomDiastolic(100, 120);
    });

    _postBloodPressureResults();
  }

  void _updateLabels(int init, int end, int x) {
    setState(() {
      systolic = init;
      diastolic = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _mainnPage(Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _formatStatus("Status", label),
        _circleSlider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _formatSystolic('Systolic', systolic),
          _formatDiastolic('Diastolic', diastolic),
        ])
      ],
    ));
  }

  Widget _circleSlider() {
    DoubleCircularSlider slider = DoubleCircularSlider(
      288,
      diastolic,
      systolic,
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
            child: Text('${_formatFinanlBP(systolic, diastolic)}',
                style: TextStyle(fontSize: 20.0, color: Colors.white))),
      ),
    );

    return slider;
  }

  Widget _formatSystolic(String pre, int value) {
    return Column(
      children: [
        Text(pre, style: TextStyle(fontSize: 20.0, color: baseColor)),
        Text(
          '${value}',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        )
      ],
    );
  }

  Widget _formatStatus(String pre, String value) {
    return Column(
      children: [
        Text(pre, style: TextStyle(fontSize: 20.0, color: baseColor)),
        Text(
          '${value}',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        )
      ],
    );
  }

  Widget _formatDiastolic(String pre, int value) {
    return Column(
      children: [
        Text(pre, style: TextStyle(fontSize: 20.0, color: baseColor)),
        Text(
          '${value}',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        )
      ],
    );
  }

  String _formatFinanlBP(int systo, int diasto) {
    return '${systo}/${diasto} mmHg';
  }

  int _generateRandomSystolic(int min, int max) => min + Random().nextInt(max - min);
  int _generateRandomDiastolic(int min, int max) => min + Random().nextInt(max - min);
  int _generateBetween(int min, int max) => min + Random().nextInt(max - min);

  void _postBloodPressureResults() {
    String readings = _formatFinanlBP(systolic, diastolic);
    int consultationID = widget.consultation.id;
    widget.userBloc.postBloodPressure(readings, consultationID);
  }


  Widget _mainnPage(Column column) {
    return Scaffold(
      body: AbsorbPointer(
        absorbing: true,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background_morning.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: column
          ),
        )
      )
    );
  }
}