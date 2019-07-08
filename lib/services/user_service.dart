
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:heart_monitor/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heart_monitor/services/response/user_response.dart';

class UserApiProvider {
  static const String LOGIN_ENDPOINT      = "/api/login";
  static const String USER_ENDPOINT       = "/api/user";
  static const String UPDATE_CONSULTATION = "/api/consultation/update";

  final _dio = API().getDio();

  Future<UserResponse> getUser(String host) async {
    try {

      Response response = await _dio.get(host + API.USER_ENDPOINT);
      
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {

      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("Unexpected Error Occured");
    }
  }
  
  Future postLogin(String host, String username, String password) async {
    try {
      
      Response response = await _dio.post(host + API.LOGIN_ENDPOINT, data: {
        "email": username,
        "password": password
      });
      
      // This response will return a token, now we need to use this token to fetch the users'
      // personal data and also save this token on device for future usage
      String token = response.data["token"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("access_token", token);

      return this.getUser(host);
      
    } catch (error) {
      
      print(error);

      if (error is DioError && error.response != null) {

        String _error = error.response.data["error"];
        return UserResponse.withError(_error);
      }

      return UserResponse.withError("$error");
    }
  }
  
  Future<Map> postBloodPressure(String host, String readings, int consultaionID) async {
    try {
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('access_token');

      Response response = await _dio.post(host + API.UPDATE_CONSULTATION, 
        data: {
          "blood_pressure": readings,
          "consultation_id": consultaionID
        },
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + token,
          }
        )
      );
      
      print("Success: ${response}");

      return {
        "success": response.data["success"],
      };
    } catch (error) {
      
      print("Error: ${error.response}");

      if (error is DioError && error.response != null) {
        return {
          "error": error.response.data["error"]
        };
      }

      return {
        "error": error
      };
    }
  }
}