import 'package:flutter/material.dart';

class SetupBloc extends ChangeNotifier {
  String _ipAddress = "";
  String get ipAddress => _ipAddress;

  set ipAddress(String ip) {
    _ipAddress = ip;
    notifyListeners();
  }

  void setIPAddress (String ip) {
    _ipAddress = ip;
  }
}