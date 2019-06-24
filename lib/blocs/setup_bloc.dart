import 'package:flutter/material.dart';

class SetupBloc with ChangeNotifier {
  String _ipAddress = "";
  String get ipAddress => _ipAddress;

  set ipAddress(String ip) {
    _ipAddress = ip;
    notifyListeners();
  }
}