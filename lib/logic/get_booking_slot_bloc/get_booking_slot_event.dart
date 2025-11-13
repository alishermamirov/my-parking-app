part of 'get_booking_slot_bloc.dart';

sealed class GetBookingSlotEvent extends Equatable {
  const GetBookingSlotEvent();

  @override
  List<Object> get props => [];
}

final class GetParkingBookingDataEvent extends GetBookingSlotEvent {
  GetParkingBookingDataEvent();

  @override
  List<Object> get props => [];
}
// final class GetParkingBookingDataEvent extends GetBookingSlotBloc {
//   final String userId;
//    GetParkingBookingDataEvent({required this.userId});

//  @override
//   List<Object> get prop => [userId];
// }
