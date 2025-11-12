part of 'parking_booking_bloc.dart';

sealed class ParkingBookingEvent extends Equatable {
  const ParkingBookingEvent();

  @override
  List<Object> get props => [];
}

final class ParkingSlotBookingEvent extends ParkingBookingEvent {
  final BookingModel booking;
  const ParkingSlotBookingEvent({
    required this.booking,
  });
  @override
  List<Object> get props => [booking];
}

class CancelSlotEvent extends ParkingBookingEvent {
    final BookingModel booking;


  const CancelSlotEvent({
    required this.booking,
  });

  @override
  List<Object> get props=> [booking];
}