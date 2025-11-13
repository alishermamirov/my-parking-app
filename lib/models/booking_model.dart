import 'package:my_parking_app/models/parking_model.dart';

class BookingModel {
  final String id;
  final String userId;
  final String parkingId;
  final String slotId;
  final String? timestamp;
  final bool status;
  final int index;
  final String slotName;
  final ParkingModel parkingModel;

  BookingModel({
    required this.id,
    required this.userId,
    required this.parkingId,
    required this.slotId,
    required this.timestamp,
    this.status = false,
    required this.index,
    required this.parkingModel,
    required this.slotName,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    print(json["parkingModel"]);
    return BookingModel(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      parkingId: json['parkingId']?.toString() ?? '',
      slotId: json['slotId']?.toString() ?? '',
      timestamp: json['timestamp']?.toString(),
      status: json['status'] as bool? ?? false,
      index: (json['index'] as num?)?.toInt() ?? -1,
      parkingModel: ParkingModel.fromJson(
        Map.from(json["parkingModel"] ?? {}),
        // json['parkingModel'] as Map<String, dynamic>,
      ),
      slotName: json['slotName']?.toString() ?? '',
      // userId: json['userId'] as String,
      // parkingId: json['parkingId'] as String,
      // slotId: json['slotId'] as String,
      // timestamp: json['timestamp'] as int,
      // status: json['status'] as bool? ?? false,
      // index: json['index'] as int,
      // parkingModel: ParkingModel.fromJson(json['parkingModel'] as Map<String, dynamic>),
      // slotName: json['slotName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'parkingId': parkingId,
      'slotId': slotId,
      'timestamp': timestamp,
      'status': status,
      'index': index,
      'parkingModel': parkingModel.toJson(),
      'slotName': slotName,
    };
  }

  copyWith({
    String? id,
    String? userId,
    String? parkingId,
    String? slotId,
    String? timestamp,
    bool? status,
    int? index,
    ParkingModel? parkingModel,
    String? slotName,
  }) {
    return BookingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      parkingId: parkingId ?? this.parkingId,
      slotId: slotId ?? this.slotId,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      index: index ?? this.index,
      parkingModel: parkingModel ?? this.parkingModel,
      slotName: slotName ?? this.slotName,
    );
  }
}
