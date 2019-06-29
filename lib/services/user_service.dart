
import 'package:dio/dio.dart';
import 'package:heart_monitor/services/response/user_response.dart';

class UserApiProvider {
  final String _endpoint = "/api/login";
  final Dio _dio = Dio();

  Future<UserResponse> getUser(String host) async {
    try {
      
      Response response = await _dio.get(host + _endpoint);
      
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError("$error");
    }
  }
}