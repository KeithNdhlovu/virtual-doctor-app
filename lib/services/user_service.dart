
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:heart_monitor/services/response/user_response.dart';

class UserApiProvider {
  final String _loginEndpoint = "/api/login";
  final String _userEndpoint = "/api/user";

  final Dio _dio = Dio();

  Future<UserResponse> getUser(String host) async {
    try {
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('access_token');

      Response response = await _dio.get(host + _userEndpoint, 
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: "Bearer " + token,
          }
        )
      );
      
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {

      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("Unexpected Error Occured");
    }
  }
  
  Future postLogin(String host, String username, String password) async {
    try {
      
      Response response = await _dio.post(host + _loginEndpoint, data: {
        "email": username,
        "password": password
      });
      
      // This response will return a token, now we need to use this token to fetch the users'
      // personal data and also save this token on device for future usage
      String token = response.data["token"];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("access_token", token);

      // After saving the token, we can continue to get the user
      this.getUser(host);
    } catch (error) {
      
      print(error);

      if (error is DioError && error.response != null) {

        String _error = error.response.data["error"];
        return UserResponse.withError(_error);
      }

      return UserResponse.withError("$error");
    }
  }
}