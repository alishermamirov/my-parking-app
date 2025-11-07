part of 'parking_slots_bloc.dart';

sealed class ParkingSlotsEvent extends Equatable {
  const ParkingSlotsEvent();

  @override
  List<Object> get props => [];
}

final class FindParkingSlotsEvent extends ParkingSlotsEvent {
  final String parkingId;
  const FindParkingSlotsEvent({required this.parkingId});

  @override
  List<Object> get props => [parkingId];
}