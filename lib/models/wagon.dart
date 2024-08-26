class Wagon {
  final String id;
  final String wagonReference;
  final int capacity;
  final int currentLoad;
  Wagon({
    required this.id,
    required this.wagonReference,
    required this.capacity,
    required this.currentLoad,
  });

  factory Wagon.fromJson(Map<String, dynamic> json) {
    return Wagon(
      id: json['_id'],
      wagonReference: json['wagon_reference'],
      capacity: json['capacity'],
      currentLoad: json['currentLoad'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'wagon_reference': wagonReference,
      'capacity': capacity,
      'currentLoad': currentLoad, 
    };
  }
}
