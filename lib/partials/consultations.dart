import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/user_bloc.dart';
import 'package:heart_monitor/models/consultation.dart';
import 'package:heart_monitor/partials/scan.dart';
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
            return _buildConsultations(snapshot.data.consultations, _userBloc);
          }

          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return Text("Loading ...");
        },
      )
    );
  }

  Widget _buildConsultations(List<Consultation> _consultations, UserBloc _userBloc) {

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _consultations.length,
      itemBuilder: (BuildContext _context, int index) {

        return _buildRow(_consultations[index], _userBloc);
      }
    );
  }

  Widget _buildRow(Consultation consulation, UserBloc _userBloc) {

    final makeListTile = ListTile(
        onTap: () =>  _handleOnItemClick(consulation, _userBloc),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24)
              )
          ),
          child: Icon(Icons.receipt, color: Colors.white),
        ),
        title: Text(
          consulation.notes,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis
        ),

        subtitle: Column(
          children: <Widget>[
            Text(""),
            Row(children: <Widget>[
              Icon(Icons.account_circle, color: Colors.white),
              Text(consulation.patient.firstName, style: TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,)
            ]),
            Row(children: <Widget>[
              Icon(Icons.linear_scale, color: Colors.yellowAccent),
              Text(consulation.getStatus(), style: TextStyle(color: Colors.white))
            ],)
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0)
      );

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(147, 1, 142, 1)),
        child: makeListTile,
      ),
    );

  }

  _handleOnItemClick(Consultation consulation, UserBloc _userBloc) {

    // we need to navigate to the heart rate calulator page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ScanPage(consultation: consulation, userBloc: _userBloc))
    );
    print("${consulation.notes}");
  }
}