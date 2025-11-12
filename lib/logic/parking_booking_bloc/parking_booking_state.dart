part of 'parking_booking_bloc.dart';

sealed class ParkingBookingState extends Equatable {
  const ParkingBookingState();
  
  @override
  List<Object> get props => [];
}
class ParkingBookingInitial extends ParkingBookingState {}

class ParkingBookingLoading extends ParkingBookingState {}

class ParkingBookingSuccess extends ParkingBookingState {
  final String message;

  const ParkingBookingSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class ParkingBookingError extends ParkingBookingState {
  final String message;

  const ParkingBookingError(this.message);

  @override
  List<Object> get props => [message];
}