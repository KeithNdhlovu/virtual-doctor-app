import 'package:heart_monitor/services/response/user_response.dart';
import 'package:heart_monitor/services/user_service.dart';

class UserRepository{
  UserApiProvider _apiProvider = UserApiProvider();

  Future<UserResponse> getUser(String host){
    return _apiProvider.getUser(host);
  }
}