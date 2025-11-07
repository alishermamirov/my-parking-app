part of 'parking_slots_bloc.dart';

sealed class ParkingSlotsState extends Equatable {
  const ParkingSlotsState();

  @override
  List<Object> get props => [];
}

final class ParkingSlotsInitial extends ParkingSlotsState {}

final class ParkingSlotsLoading extends ParkingSlotsState {}

final class ParkingSlotsLoaded extends ParkingSlotsState {
  final List<ParkingAreaModel> parkingAreas;
  const ParkingSlotsLoaded({required this.parkingAreas});

  @override
  List<Object> get props => [parkingAreas];
}

final class ParkingSlotsError extends ParkingSlotsState {
  final String message;
  const ParkingSlotsError({required this.message});

  @override
  List<Object> get props => [message];
}
