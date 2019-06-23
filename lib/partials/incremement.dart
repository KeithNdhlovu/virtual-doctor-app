import 'package:flutter/material.dart';
import 'package:heart_monitor/blocs/counter_bloc.dart';
import 'package:provider/provider.dart';

class IncrementButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return new FlatButton.icon(
      icon: Icon(Icons.add),
      label: Text("Add"),
      onPressed: () => {},
    );
  }
}