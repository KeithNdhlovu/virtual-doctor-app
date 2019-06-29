
import 'package:heart_monitor/models/consultation.dart';

class ConsultationResponse {
  final List<Consultation> consultations;
  final String error;

  ConsultationResponse({this.consultations, this.error});

  factory ConsultationResponse.fromJson(Map<String, dynamic> json) {
    return ConsultationResponse(
      consultations: (json["data"] as List).map( (c) => new Consultation.fromJson(c)),
      error: null
    );
  }

  factory ConsultationResponse.withError(String errorValue) {
    return ConsultationResponse(
      consultations: new List(),
      error: errorValue
    );
  }
}