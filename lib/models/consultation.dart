import 'package:heart_monitor/models/user.dart';

class Consultation {
  final String notes;
  final String doctorNotes;
  final User doctor;
  final User patient;
  final int status;

  static const TYPE_WAITING   = 1;
  static const TYPE_APPROVED  = 2;
  static const TYPE_FINISHED  = 3;
  static const TYPE_CANCELLED = 4;
  static const TYPE_AWAITING_PAYMENT  = 5;
  static const TYPE_PAID  = 6;
  static const TYPE_PAID_MEDICAL_AID  = 7;

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

  getStatus() {
    switch (this.status) {
      case TYPE_WAITING:
        return 'Waiting';

      case TYPE_APPROVED:
        return 'Approved';

      case TYPE_FINISHED:
        return 'Finished';

      case TYPE_CANCELLED:
        return 'Cancelled';
      
      case TYPE_PAID:
        return 'Paid';
      
      case TYPE_PAID_MEDICAL_AID:
        return 'Paid By Medical Aid';
      
      case TYPE_AWAITING_PAYMENT:
        return 'Awaiting Payment';
    }
  }
}