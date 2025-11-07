import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_parking_app/models/parking_area_model.dart';

part 'parking_slots_event.dart';
part 'parking_slots_state.dart';

class ParkingSlotsBloc extends Bloc<ParkingSlotsEvent, ParkingSlotsState> {
  ParkingSlotsBloc() : super(ParkingSlotsInitial()) {
    on<FindParkingSlotsEvent>(_onFindParkingSlots);
  }
  void _onFindParkingSlots(
    FindParkingSlotsEvent event,
    Emitter<ParkingSlotsState> emit,
  ) {
  
  }
}
