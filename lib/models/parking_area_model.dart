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
      final slotMap = slot as Map<String, dynamic>;
      return ParkingSlotModel(
        id: slotMap['id'] as String,
        name: slotMap['name'] as String,
        isOccupied: slotMap['isOccupied'] as bool? ?? false,
      );
    }).toList();

    return ParkingAreaModel(
      id: json['id'] as String,
      parkingId: json['parkingId'] as String,
      slots: slots,
    );
  }
}
