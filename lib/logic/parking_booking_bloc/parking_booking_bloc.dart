import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_parking_app/models/booking_model.dart';
import 'package:my_parking_app/services/auth_service.dart';
import 'package:my_parking_app/services/parking_service.dart';

part 'parking_booking_event.dart';
part 'parking_booking_state.dart';

class ParkingBookingBloc
    extends Bloc<ParkingBookingEvent, ParkingBookingState> {
  final AuthService authService;
  final ParkingService parkingService;
  ParkingBookingBloc({required this.authService, required this.parkingService})
    : super(ParkingBookingInitial()) {
    on<ParkingSlotBookingEvent>(_onBookSlot);
    on<CancelSlotEvent>(_onCancelSlot);
  }

  Future<void> _onBookSlot(
    ParkingSlotBookingEvent event,
    Emitter<ParkingBookingState> emit,
  ) async {
    final user = authService.currentUser;
    //print(user?.uid);
    emit(ParkingBookingLoading());
    try {
      //print("slot id: " + event.booking.slotId);
      //print("index: ${event.booking.index}");
      final data = event.booking.copyWith(userId: user!.uid);
      //print("booking data: $data");
      await parkingService.bookSlot(data);
      // final slotRef = database.ref(
      //   "parkingAreas/${event.booking.parkingId}/slots/${event.booking.index}",
      // );
      // // .child(event.slotId);
      // await slotRef.update({"isOccupied": false});
      // final bookingRef = database.ref('bookings/${event.booking.id}');
      // await bookingRef.set(event.booking.toJson());

      emit(const ParkingBookingSuccess("Slot successfully booked ✅"));
    } catch (e) {
      //print(e);
      emit(ParkingBookingError("Failed to book slot: $e"));
    }
  }

  Future<void> _onCancelSlot(
    CancelSlotEvent event,
    Emitter<ParkingBookingState> emit,
  ) async {
    emit(ParkingBookingLoading());
    try {
      // final slotRef = database
      //     .ref("parkingAreas/${event.booking}/slots")
      //     .child(event.booking.slotId);

      // await slotRef.update({"isOccupied": false});
      // final bookingRef = database.ref('bookings/${event.booking.id}');
      // await bookingRef.remove();

      await parkingService.cancelSlot(event.booking);
      emit(const ParkingBookingSuccess("Slot released successfully 🅿️"));
    } catch (e) {
      emit(ParkingBookingError("Failed to release slot: $e"));
    }
  }
}
