import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  static const String BASE_URL               = "/api/";
  static const String USER_ENDPOINT          = BASE_URL + "/user";
  static const String LOGIN_ENDPOINT         = BASE_URL + "/login";
  static const String UPDATE_CONSULTATION    = BASE_URL + "/consultation/update";
  static const String CONSULTATIONS_ENDPOINT = BASE_URL + "/consultaions";

  final Dio _dio = Dio();

  void _setupInterceptor() {
    int maxCharactersPerLine = 200;

    _dio.interceptor.request.onSend = (Options options) async {
      print("--> ${options.method} ${options.path}");
      print("Content type: ${options.contentType}");
      print("<-- END HTTP");

      // Modify Headers and set the Authorisation token
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('access_token');
      
      options.headers = {
        HttpHeaders.authorizationHeader: "Bearer " + token,
      };

      return options;
    };

    _dio.interceptor.response.onSuccess = (Response response) {
      print("<-- ${response.statusCode} ${response.request.method} ${response.request.path}");
      String responseAsString = response.data.toString();
      
      if (responseAsString.length > maxCharactersPerLine) {
        int iterations =
            (responseAsString.length / maxCharactersPerLine).floor();
        for (int i = 0; i <= iterations; i++) {
          int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          print(responseAsString.substring(
              i * maxCharactersPerLine, endingIndex));
        }
      } else {
        print(response.data);
      }
      print("<-- END HTTP");
    };
  }

  Dio getDio() {
    _setupInterceptor();
    return _dio;
  }
}