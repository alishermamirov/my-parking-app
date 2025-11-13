part of 'get_booking_slot_bloc.dart';

sealed class GetBookingSlotState extends Equatable {
  const GetBookingSlotState();
  
  @override
  List<Object> get props => [];
}

final class GetBookingSlotInitial extends GetBookingSlotState {}

final class GetBookingSlotLoading extends GetBookingSlotState {}
final class GetBookingSlotSuccess extends GetBookingSlotState {
  final List<BookingModel> bookings; // Adjust the type as needed

  const GetBookingSlotSuccess(this.bookings);

  @override
  List<Object> get props => [bookings];
}
final class GetBookingSlotError extends GetBookingSlotState {
  final String message;

  const GetBookingSlotError(this.message);

  @override
  List<Object> get props => [message];
}