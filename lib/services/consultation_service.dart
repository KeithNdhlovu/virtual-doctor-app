
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:heart_monitor/services/api.dart';
import 'package:heart_monitor/services/response/consultation_response.dart';

class ConsultationApiProvider {
  
  final _dio = API().getDio();

  Future<ConsultationResponse> getConsultations(String host) async {
    try {
      Response response = await _dio.get(host + API.CONSULTATIONS_ENDPOINT);
      
      return ConsultationResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      
      print("Exception occured: $error stackTrace: $stacktrace");
      return ConsultationResponse.withError("$error");
    }
  }
}