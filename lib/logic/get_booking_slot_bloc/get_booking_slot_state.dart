part of 'get_booking_slot_bloc.dart';

sealed class GetBookingSlotState extends Equatable {
  const GetBookingSlotState();
  
  @override
  List<Object> get props => [];
}

final class GetBookingSlotInitial extends GetBookingSlotState {}
