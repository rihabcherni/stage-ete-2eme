class Wagon {
  final String id;
  final String trainId;
  final String wagonReference;
  final int capacity;
  final int currentLoad;

  Wagon({
    required this.id,
    required this.trainId,
    required this.wagonReference,
    required this.capacity,
    required this.currentLoad,
  });

  // Factory method to create a Wagon from a Map
  factory Wagon.fromJson(Map<String, dynamic> json) {
    return Wagon(
      id: json['_id'],
      trainId: json['trainId'],
      wagonReference: json['wagonReference'],
      capacity: json['capacity'],
      currentLoad: json['currentLoad'],
    );
  }

  // Method to convert a Wagon to a Map
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'trainId': trainId,
      'wagonReference': wagonReference,
      'capacity': capacity,
      'currentLoad': currentLoad,
    };
  }
}
