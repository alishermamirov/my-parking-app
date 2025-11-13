part of 'parking_area_bloc.dart';

abstract class ParkingAreaState extends Equatable {
  const ParkingAreaState();

  @override
  List<Object?> get props => [];
}

class ParkingAreaInitial extends ParkingAreaState {}

class ParkingAreaLoading extends ParkingAreaState {}

class ParkingAreaLoaded extends ParkingAreaState {
  final ParkingAreaModel area;
  const ParkingAreaLoaded({required this.area});

  @override
  List<Object?> get props => [area];
}

class ParkingAreaError extends ParkingAreaState {
  final String message;
  const ParkingAreaError({required this.message});

  @override
  List<Object?> get props => [message];
}
