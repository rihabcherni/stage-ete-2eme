// models/reclamation.dart

class Reclamation {
  String id;
  String clientId;
  String orderId;
  String message;
  String status;
  DateTime? resolutionDate;

  Reclamation({
    required this.id,
    required this.clientId,
    required this.orderId,
    required this.message,
    required this.status,
    this.resolutionDate,
  });

  // Factory method to create a Reclamation object from JSON
  factory Reclamation.fromJson(Map<String, dynamic> json) {
    return Reclamation(
      id: json['_id'],
      clientId: json['clientId'],
      orderId: json['orderId'],
      message: json['message'],
      status: json['status'],
      resolutionDate: json['resolutionDate'] != null
          ? DateTime.parse(json['resolutionDate'])
          : null,
    );
  }

  // Method to convert Reclamation object to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'clientId': clientId,
      'orderId': orderId,
      'message': message,
      'status': status,
      'resolutionDate': resolutionDate?.toIso8601String(),
    };
  }
}
