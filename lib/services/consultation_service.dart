
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:heart_monitor/services/response/consultation_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultationApiProvider {
  final String _endpoint = "/api/consultations";
  final Dio _dio = Dio();

  Future<ConsultationResponse> getConsultations(String host) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('access_token');

      Response response = await _dio.get(host + _endpoint, 
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + token,
          }
        )
      );
      
      return ConsultationResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      
      print("Exception occured: $error stackTrace: $stacktrace");
      return ConsultationResponse.withError("$error");
    }
  }
}