
import 'package:heart_monitor/models/user.dart';

class UserResponse {
  final User user;
  final String error;

  UserResponse({this.user, this.error});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      user: new User.fromJson(json["data"]),
      error: ""
    );
  }

  factory UserResponse.withError(String errorValue) {
    return UserResponse(
      user: null,
      error: errorValue
    );
  }
}