import 'package:heart_monitor/models/user.dart';

class Consultation {
  final String notes;
  final String doctorNotes;
  final User doctor;
  final User patient;
  final String status;

  Consultation({
    this.notes, 
    this.status, 
    this.doctor, 
    this.patient,
    this.doctorNotes, 
  });

  factory Consultation.fromJson(Map<String, dynamic> json) {
    return Consultation(
      notes: json["notes"],
      status: json["status"],
      doctorNotes: json["doctor_notes"],
      doctor: User.fromJson(json["doctor"]),
      patient: User.fromJson(json["patient"]),
    );
  }
}