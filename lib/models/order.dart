class Order {
  final String id;
  final String clientId;
  final String trainId;
  final String origin;
  final String destination;
  final String status;
  final List<MaterialItem> materials;
  final DateTime? estimatedDeliveryTime;
  final List<Tracking> tracking;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.clientId,
    required this.trainId,
    required this.origin,
    required this.destination,
    required this.status,
    required this.materials,
    this.estimatedDeliveryTime,
    required this.tracking,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      clientId: json['clientId'],
      trainId: json['trainId'],
      origin: json['origin'],
      destination: json['destination'],
      status: json['status'],
      materials: (json['materials'] as List)
          .map((item) => MaterialItem.fromJson(item))
          .toList(),
      estimatedDeliveryTime: json['estimatedDeliveryTime'] != null
          ? DateTime.parse(json['estimatedDeliveryTime'])
          : null,
      tracking: (json['tracking'] as List)
          .map((item) => Tracking.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'trainId': trainId,
      'origin': origin,
      'destination': destination,
      'status': status,
      'materials': materials.map((item) => item.toJson()).toList(),
      'estimatedDeliveryTime': estimatedDeliveryTime?.toIso8601String(),
      'tracking': tracking.map((item) => item.toJson()).toList(),
    };
  }
}

class MaterialItem {
  final String type;
  final int quantity;
  final String unit;

  MaterialItem({required this.type, required this.quantity, required this.unit});

  factory MaterialItem.fromJson(Map<String, dynamic> json) {
    return MaterialItem(
      type: json['type'],
      quantity: json['quantity'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'quantity': quantity,
      'unit': unit,
    };
  }
}

class Tracking {
  final double latitude;
  final double longitude;
  final DateTime timestamp;
  final String status;

  Tracking({
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.status,
  });

  factory Tracking.fromJson(Map<String, dynamic> json) {
    return Tracking(
      latitude: json['location']['latitude'],
      longitude: json['location']['longitude'],
      timestamp: DateTime.parse(json['timestamp']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': {
        'latitude': latitude,
        'longitude': longitude,
      },
      'timestamp': timestamp.toIso8601String(),
      'status': status,
    };
  }
}
