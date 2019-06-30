
import 'package:heart_monitor/models/consultation.dart';

class ConsultationResponse {
  final List<Consultation> consultations;
  final String error;

  ConsultationResponse({this.consultations, this.error});

// ConsultationResponse.fromJson(Map<String, dynamic> json)
//       : consultations = (json["consultations"] as List).map((i) => new Consultation.fromJson(i)).toList(),
//         error = "";

//   ConsultationResponse.withError(String errorValue)
//       : consultations = List(),
//         error = errorValue;

  factory ConsultationResponse.fromJson(Map<String, dynamic> json) {
    return ConsultationResponse(
      consultations: (json["consultations"] as List).map( (c) => new Consultation.fromJson(c)).toList(),
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