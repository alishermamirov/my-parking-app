part of 'parking_area_bloc.dart';

abstract class ParkingAreaEvent extends Equatable {
  const ParkingAreaEvent();

  @override
  List<Object?> get props => [];
}

class GetParkingAreasEvent extends ParkingAreaEvent {
  final String parkingId;
  const GetParkingAreasEvent({required this.parkingId});
}

class ParkingAreasUpdatedEvent extends ParkingAreaEvent {
  final List<ParkingAreaModel> areas;
  const ParkingAreasUpdatedEvent(this.areas);

  @override
  List<Object?> get props => [areas];
}

class ParkingAreaErrorEvent extends ParkingAreaEvent {
  final String message;
  const ParkingAreaErrorEvent(this.message);

  @override
  List<Object?> get props => [message];
}
