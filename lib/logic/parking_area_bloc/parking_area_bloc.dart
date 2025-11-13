import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../models/parking_area_model.dart';

part 'parking_area_event.dart';
part 'parking_area_state.dart';

class ParkingAreaBloc extends Bloc<ParkingAreaEvent, ParkingAreaState> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  StreamSubscription? _parkingAreaSubscription;

  ParkingAreaBloc() : super(ParkingAreaInitial()) {
    on<GetParkingAreasEvent>(_onGetParkingAreas);
    on<ParkingAreasUpdatedEvent>(_onParkingAreasUpdated);
    on<ParkingAreaErrorEvent>(_onParkingAreaError);
  }

  Future<void> _onGetParkingAreas(
    GetParkingAreasEvent event,
    Emitter<ParkingAreaState> emit,
  ) async {
    //print("loading");
    emit(ParkingAreaLoading());

    await _parkingAreaSubscription?.cancel();
    //print("get parking area id: ${event.parkingId}");
    final query = database.ref("parkingAreas/${event.parkingId}");

    //print("get data");

    // final query = database.ref("parkingAreas");
    // .orderByChild('parkingId')
    // .equalTo(event.parkingId);
    // _parkingAreaSubscription = query.onValue.listen(
    //   (dbEvent) {
    //     final snapshot = dbEvent.snapshot;
    //     if (snapshot.exists && snapshot.value != null) {
    //       final data = snapshot.value as Map<dynamic, dynamic>;
    //       final firstEntry = data.entries.first;
    //       //print(firstEntry);
    //       final id = firstEntry.key;
    //       final value = Map<String, dynamic>.from(firstEntry.value);
    //       final area = ParkingAreaModel.fromJson(value).copyWith(id: id);
    //       add(ParkingAreasUpdatedEvent([area]));
    //     } else {
    //       add(const ParkingAreasUpdatedEvent([]));
    //     }
    //   },
    //   onError: (error) {
    //     add(ParkingAreaErrorEvent(error.toString()));
    //   },
    // );

    _parkingAreaSubscription = query.onValue.listen(
      (dbEvent) {
        final snapshot = dbEvent.snapshot;

        if (snapshot.exists && snapshot.value != null) {
          final data = Map<String, dynamic>.from(snapshot.value as Map);
          //print("Parking area data: $data");

          final area = ParkingAreaModel.fromJson(
            data,
          ).copyWith(id: event.parkingId);

          add(ParkingAreasUpdatedEvent(area));
        } else {
          add(const ParkingAreaErrorEvent("parking area not found"));
        }
      },
      onError: (error) {
        add(ParkingAreaErrorEvent(error.toString()));
      },
    );
  }

  void _onParkingAreasUpdated(
    ParkingAreasUpdatedEvent event,
    Emitter<ParkingAreaState> emit,
  ) {
    emit(ParkingAreaLoaded(area: event.area));
  }

  void _onParkingAreaError(
    ParkingAreaErrorEvent event,
    Emitter<ParkingAreaState> emit,
  ) {
    emit(ParkingAreaError(message: event.message));
  }

  @override
  Future<void> close() {
    _parkingAreaSubscription?.cancel();
    return super.close();
  }
}
