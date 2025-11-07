class ParkingSlotModel {
  final String id;
  final String name;
  bool isOccupied;
  ParkingSlotModel({
    required this.id,
    required this.name,
    this.isOccupied = false,
  });

  factory ParkingSlotModel.fromJson(Map<String, dynamic> json) {
    return ParkingSlotModel(
      id: json['id'] as String,
      name: json['name'] as String,
      isOccupied: json['isOccupied'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isOccupied': isOccupied,
    };
  }
}
