import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_parking_app/models/booking_model.dart';

part 'parking_booking_event.dart';
part 'parking_booking_state.dart';

class ParkingBookingBloc
    extends Bloc<ParkingBookingEvent, ParkingBookingState> {
  ParkingBookingBloc() : super(ParkingBookingInitial()) {
    on<ParkingSlotBookingEvent>(_onBookSlot);
    on<CancelSlotEvent>(_onCancelSlot);
  }

  final FirebaseDatabase database = FirebaseDatabase.instance;

  Future<void> _onBookSlot(
    ParkingSlotBookingEvent event,
    Emitter<ParkingBookingState> emit,
  ) async {
    emit(ParkingBookingLoading());
    try {
      print(event.booking.areaId);
      print(event.booking.slotId);
      print(event.booking.index);
      final slotRef = database.ref("parkingAreas/slotId/slots/0");
      // .child(event.slotId);
      await slotRef.update({"isOccupied": false});
      final bookingRef = database.ref('bookings/${event.booking.id}');
      await bookingRef.set(event.booking.toJson());

      emit(const ParkingBookingSuccess("Slot successfully booked ✅"));
    } catch (e) {
      print(e);
      emit(ParkingBookingError("Failed to book slot: $e"));
    }
  }

  Future<void> _onCancelSlot(
    CancelSlotEvent event,
    Emitter<ParkingBookingState> emit,
  ) async {
    emit(ParkingBookingLoading());
    try {
      final slotRef = database
          .ref("parkingAreas/${event.booking.areaId}/slots")
          .child(event.booking.slotId);

      await slotRef.update({"isOccupied": false});
      final bookingRef = database.ref('bookings/${event.booking.id}');
      await bookingRef.remove();
      emit(const ParkingBookingSuccess("Slot released successfully 🅿️"));
    } catch (e) {
      emit(ParkingBookingError("Failed to release slot: $e"));
    }
  }
}
