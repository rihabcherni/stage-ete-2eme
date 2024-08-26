class Train {
  final String id;
  final String trainReference;
  final String status;
  final String? modeleTrain;
  final double carbonEmissions;
  final DateTime serviceStartDate;
  final DateTime createdAt; 
  final DateTime updatedAt;
  Train({
    required this.id,
    required this.trainReference,
    required this.status,
    this.modeleTrain,
    required this.carbonEmissions,
    required this.serviceStartDate,
    required this.createdAt,
    required this.updatedAt,
  });

  Train copyWith({
    String? id,
    String? trainReference,
    String? status,
    String? modeleTrain,
    double? carbonEmissions,
    DateTime? serviceStartDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Train(
      id: id ?? this.id,
      trainReference: trainReference ?? this.trainReference,
      status: status ?? this.status,
      modeleTrain: modeleTrain ?? this.modeleTrain,
      carbonEmissions: carbonEmissions ?? this.carbonEmissions,
      serviceStartDate: serviceStartDate ?? this.serviceStartDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory Train.fromJson(Map<String, dynamic> json) {
    return Train(
      id: json['_id'],
      trainReference: json['train_reference'],
      status: json['status'],
      modeleTrain: json['modele_train'],
      carbonEmissions: json['carbonEmissions'],
      serviceStartDate: DateTime.parse(json['serviceStartDate']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'train_reference': trainReference,
      'status': status,
      'modele_train': modeleTrain,
      'carbonEmissions': carbonEmissions,
      'serviceStartDate': serviceStartDate.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
