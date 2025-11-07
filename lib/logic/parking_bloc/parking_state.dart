import 'package:equatable/equatable.dart';

import '../../models/parking_model.dart';

abstract class ParkingState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ParkingInitial extends ParkingState {}

class ParkingLoading extends ParkingState {}

class ParkingDone extends ParkingState {
  final List<ParkingModel> parkings;
  ParkingDone({required this.parkings});

  @override
  List<Object?> get props => [parkings];
}

class ParkingError extends ParkingState {
  final String message;
  ParkingError({required this.message});

  @override
  List<Object?> get props => [message];
}
