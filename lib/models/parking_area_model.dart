import 'package:my_parking_app/models/parking_slot_model.dart';

class ParkingAreaModel {
  final String id;
  final String parkingId;
  final List<ParkingSlotModel> slots;

  ParkingAreaModel({
    required this.id,
    required this.parkingId,
    required this.slots,
  });
  factory ParkingAreaModel.fromJson(Map<String, dynamic> json) {
    final slotsData = json['slots'] as List<dynamic>? ?? [];
    final slots = slotsData.map((slot) {
      final slotMap = Map<String, dynamic>.from(slot as Map);
      return ParkingSlotModel.fromJson(slotMap);
    }).toList();

    return ParkingAreaModel(
      id: json['id']?.toString() ?? '',
      parkingId: json['parkingId']?.toString() ?? '',
      slots: slots,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parkingId': parkingId,
      'slots': slots.map((slot) => slot.toJson()).toList(),
    };
  }

  ParkingAreaModel copyWith({
    String? id,
    String? parkingId,
    List<ParkingSlotModel>? slots,
  }) {
    return ParkingAreaModel(
      id: id ?? this.id,
      parkingId: parkingId ?? this.parkingId,
      slots: slots ?? this.slots,
    );
  }
}
