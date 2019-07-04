import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/user_bloc.dart';
import 'package:heart_monitor/models/consultation.dart';
import 'package:heart_monitor/partials/scan.dart';
import 'package:heart_monitor/partials/sleep.dart';
import 'package:heart_monitor/services/response/consultation_response.dart';
import 'package:provider/provider.dart';

class ConsultationsPage extends StatefulWidget {
  ConsultationsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ConsultationsPageState createState() => _ConsultationsPageState();
}

class _ConsultationsPageState extends State<ConsultationsPage> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat', 
    fontSize: 20.0
  );
  
  @override
  Widget build(BuildContext context) {
    
    final _userBloc = Provider.of<UserBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Consultations')
      ),
      body: FutureBuilder<ConsultationResponse>(
        future: _userBloc.getConsultations(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildConsultations(snapshot.data.consultations);
          }

          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Text("Loading ...");
        },
      )
    );
  }

  Widget _buildConsultations(List<Consultation> _consultations) {

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemBuilder: (BuildContext _context, int i) {
        
        if (i.isOdd) {
          return Divider();
        }

        final int index = i ~/ 2;

        if (index >= _consultations.length) {
          // ...then generate 10 more and add them to the 
          return null;
        }

        return _buildRow(_consultations[index]);
      }
    );
  }

  Widget _buildRow(Consultation consulation) {
    return ListTile(
      onTap: () =>  _handleOnItemClick(consulation),
      title: Text(
        consulation.notes,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  _handleOnItemClick(Consultation consulation) {

    // we need to navigate to the heart rate calulator page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScanPage())
    );
    print("${consulation.notes}");
  }
}