
import 'package:heart_monitor/models/user.dart';

class UserResponse {
  final List<User> results;
  final String error;

  UserResponse({this.results, this.error});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      results: (json["results"] as List).map((i) => new User.fromJson(i)).toList(),
      error: ""
    );
  }

  factory UserResponse.withError(String errorValue) {
    return UserResponse(
      results: List(),
      error: errorValue
    );
  }
}