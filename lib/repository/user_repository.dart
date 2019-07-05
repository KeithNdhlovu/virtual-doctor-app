import 'package:heart_monitor/services/response/user_response.dart';
import 'package:heart_monitor/services/user_service.dart';

class UserRepository{
  UserApiProvider _apiProvider = UserApiProvider();

  Future<UserResponse> getUser(String host){
    return _apiProvider.getUser(host);
  }
  
  Future postLogin(String host, String username, String password){
    return _apiProvider.postLogin(host, username, password);
  }
  
  Future postBloodPressure(String host, String readings, int consultationID){
    return _apiProvider.postBloodPressure(host, readings, consultationID);
  }
}