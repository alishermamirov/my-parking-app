class BookingModel {
  final String id;
  final String userId;
  final String parkingId;
  final String areaId;
  final String slotId;
  final int timestamp;
  final bool status;
  final int index;

  BookingModel({
    required this.id,
    required this.userId,
    required this.parkingId,
    required this.areaId,
    required this.slotId,
    required this.timestamp,
    this.status = false,
    required this.index,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      parkingId: json['parkingId'] as String,
      areaId: json['areaId'] as String,
      slotId: json['slotId'] as String,
      timestamp: json['timestamp'] as int,
      status: json['status'] as bool? ?? false,
      index: json['index'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'parkingId': parkingId,
      'areaId': areaId,
      'slotId': slotId,
      'timestamp': timestamp,
      'status': status,
      'index': index,
    };
  }
}
