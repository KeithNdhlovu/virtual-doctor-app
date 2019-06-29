import 'package:heart_monitor/services/consultation_service.dart';
import 'package:heart_monitor/services/response/consultation_response.dart';

class ConsultationRepository{
  ConsultationApiProvider _apiProvider = ConsultationApiProvider();

  Future<ConsultationResponse> getConsultations(String host){
    return _apiProvider.getConsultations(host);
  }
}