import 'package:flutter/material.dart';
import 'package:heart_monitor/repository/user_repository.dart';
import 'package:heart_monitor/services/response/user_response.dart';

class UserBloc with ChangeNotifier {

  final UserRepository _repository = UserRepository();
  bool _loading = false;
  String _host;
  String _ipAddress = "";
  String _error = "";
  UserResponse _user;

  String get ipAddress => _ipAddress;
  set ipAddress(String ip) {
    _ipAddress = ip;
    notifyListeners();
  }

  set user(UserResponse user) {
    _user = user;
    notifyListeners();
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

  get error => _error;
  set error(String error) {
    _error = error;
    notifyListeners();
  }

  get loading => _loading;
  set loading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  postLogin(String username, String password) async {
    loading = true;

    UserResponse userResponse = await _repository.postLogin(this.host, username, password);
    loading = false;
    error = userResponse.error;
  }
  
}