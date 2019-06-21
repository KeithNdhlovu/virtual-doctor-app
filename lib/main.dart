import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Le Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Le Flutter'),
        ),
        body: const Center(
          child: const Text('Hello World, from Le Flutters'),
        ),
      ),
    );
  }
}