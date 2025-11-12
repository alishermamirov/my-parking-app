part of 'parking_bloc.dart';

abstract class ParkingEvent extends Equatable {
  const ParkingEvent();

  @override
  List<Object?> get props => [];
}

class GetParkingEvent extends ParkingEvent {}

// class ParkingUpdatedEvent extends ParkingEvent {
//   final List<ParkingModel> parkings;
//   const ParkingUpdatedEvent(this.parkings);

//   @override
//   List<Object?> get props => [parkings];
// }

// class ParkingErrorEvent extends ParkingEvent {
//   final String message;
//   const ParkingErrorEvent(this.message);

//   @override
//   List<Object?> get props => [message];
// }
