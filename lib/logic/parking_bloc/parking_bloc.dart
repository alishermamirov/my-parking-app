import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_parking_app/services/parking_service.dart';

import 'parking_state.dart';

part 'parking_event.dart';

class ParkingBloc extends Bloc<ParkingEvent, ParkingState> {
  final ParkingService parkingService;
  // StreamSubscription? _parkingSubscription;

  ParkingBloc({required this.parkingService}) : super(ParkingInitial()) {
    on<GetParkingEvent>(_onGetParking);
    // on<ParkingUpdatedEvent>(_onParkingUpdated);
  }

  Future<void> _onGetParking(
    GetParkingEvent event,
    Emitter<ParkingState> emit,
  ) async {
    emit(ParkingLoading());

    try {
      final parkings = await parkingService.getParkings();
      emit(ParkingDone(parkings: parkings));
    } catch (error) {
      emit(ParkingError(message: error.toString()));
    }
  }

  // Future<void> _onGetParking(
  //   GetParkingEvent event,
  //   Emitter<ParkingState> emit,
  // ) async {
  //   emit(ParkingLoading());

  //   // await _parkingSubscription?.cancel();

  //   _parkingSubscription = database.ref('parkings').onValue.listen((dbEvent) {
  //     final snapshot = dbEvent.snapshot;

  //     if (snapshot.exists && snapshot.value != null) {
  //       final Map<dynamic, dynamic> rawData =
  //           snapshot.value as Map<dynamic, dynamic>;

  //       final List<ParkingModel> parkings = rawData.entries.map((entry) {
  //         final key = entry.key.toString();
  //         final value = Map<String, dynamic>.from(entry.value);
  //         return ParkingModel.fromJson(value).copyWith(id: key);
  //       }).toList();

  //       add(ParkingUpdatedEvent(parkings));
  //     } else {
  //       add(const ParkingUpdatedEvent([]));
  //     }
  //   }, onError: (error) {
  //     add(ParkingErrorEvent(error.toString()));
  //   });
  // }

  // void _onParkingUpdated(
  //   ParkingUpdatedEvent event,
  //   Emitter<ParkingState> emit,
  // ) {
  //   emit(ParkingDone(parkings: event.parkings));
  // }

  // @override
  // Future<void> close() {
  //   _parkingSubscription?.cancel();
  //   return super.close();
  // }
}
