import 'package:flutter/material.dart';
import 'package:heart_monitor/models/consultation.dart';
import 'package:heart_monitor/partials/home.dart';
import 'package:heart_monitor/repository/consultation_repository.dart';
import 'package:heart_monitor/repository/user_repository.dart';
import 'package:heart_monitor/services/response/consultation_response.dart';
import 'package:heart_monitor/services/response/user_response.dart';

class UserBloc with ChangeNotifier {

  final UserRepository _repository = UserRepository();
  final ConsultationRepository _cRepository = ConsultationRepository();

  bool _loading = false;
  String _host;
  String _ipAddress = "";
  String _error = "";
  UserResponse _user;
  List<Consultation> _consultations;
  BuildContext _context;

  String get ipAddress => _ipAddress;
  set ipAddress(String ip) {
    _ipAddress = ip;
    notifyListeners();
  }

  BuildContext get context => _context;
  set context(BuildContext context) {
    _context = context;
    notifyListeners();
  }

  set user(UserResponse user) {
    _user = user;
    notifyListeners();
  }
  get user async {
    _user = await _repository.getUser(this.host);
    return _user;
  }
  
  set consultations(List<Consultation> consultations) {
    _consultations = consultations;
    notifyListeners();
  }
  get consultations => _consultations;

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
    error = (userResponse != null) ? userResponse.error : "";

    // on success we need to redirect to the home page
    if (userResponse != null && userResponse.user != null) {
      
      // Clear the errors
      error = "";
      
      Navigator.push(
        this.context,
        MaterialPageRoute(builder: (context) => HomePage(userBloc: this))
      );

    }

  }

  postBloodPressure(String readings, int consultationID ) async {
    loading = true;

    Map response = await _repository.postBloodPressure(this.host, readings, consultationID);
    loading = false;
    error = (response["error"] != null) ? response["error"] : "";

  }

  getConsultations() {
    return  _cRepository.getConsultations(this.host);
  }
  
}