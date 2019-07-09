
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:heart_monitor/services/api.dart';
import 'package:heart_monitor/services/response/consultation_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultationApiProvider {
  final String _endpoint = "/api/consultations";
  final Dio _dio = Dio();

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