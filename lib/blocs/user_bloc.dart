import 'package:flutter/material.dart';
import 'package:heart_monitor/repository/user_repository.dart';
import 'package:heart_monitor/services/response/user_response.dart';

class UserBloc with ChangeNotifier{

  final UserRepository _repository = UserRepository();
  String _host;
  UserResponse _user;

  set user(UserResponse user) {
    _user = user;
  }
  get user async {
    _user = await _repository.getUser(this._host);
    return _user;
  }

  get host => _host;
  set host(String host) {
    _host = host;
    notifyListeners();
  }
  
}