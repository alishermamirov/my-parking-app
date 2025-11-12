import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_booking_slot_event.dart';
part 'get_booking_slot_state.dart';

class GetBookingSlotBloc extends Bloc<GetBookingSlotEvent, GetBookingSlotState> {
  GetBookingSlotBloc() : super(GetBookingSlotInitial()) {
    on<GetBookingSlotEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
