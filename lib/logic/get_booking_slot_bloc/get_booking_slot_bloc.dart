import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_parking_app/models/booking_model.dart';
import 'package:my_parking_app/services/auth_service.dart';
import 'package:my_parking_app/services/parking_service.dart';

part 'get_booking_slot_event.dart';
part 'get_booking_slot_state.dart';

class GetBookingSlotBloc
    extends Bloc<GetBookingSlotEvent, GetBookingSlotState> {
  final ParkingService parkingService;
  final AuthService authService;

  GetBookingSlotBloc({required this.parkingService, required this.authService})
    : super(GetBookingSlotInitial()) {
    on<GetParkingBookingDataEvent>(_getBookingData);
  }

  Future _getBookingData(
    GetParkingBookingDataEvent event,
    Emitter<GetBookingSlotState> emit,
  ) async {
    emit(GetBookingSlotLoading());
    final user = authService.currentUser;
    try {
      final data = await parkingService.getBooking(user!.uid);
      emit(GetBookingSlotSuccess(data));
    } catch (e) {
      emit(GetBookingSlotError(e.toString()));
    }
  }
}
