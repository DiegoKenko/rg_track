import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/cubit/location_history_state.dart';

class LocationHistoryCubit extends Cubit<LocationHistoryState> {
  LocationHistoryCubit() : super(LocationHistoryInitial());

  Future<List<Vehicle>> getVehicleLocationHistory(String id) async {
    return [];
  }

  Future<List<Event>> getVehicleLocationHistoryEvents(String id,
      [DateTime? day]) async {
    emit(LocationHistoryLoading());
    try {} catch (e) {
      emit(LocationHistoryError(e.toString()));
      return [];
    }
    return [];
  }
/* 
  List<Event> _groupStopped(List<Event> data) {
    final List<Event> events = <Event>[];
    if (data.length <= 1) return events;
    Event previousEvent = data.first;
    for (int i = 1; i < data.length; i++) {
      final Event currentEvent = data[i];
      if (currentEvent.isParking && previousEvent.isParking) {
        continue;
      }
      if (currentEvent.isDriving && previousEvent.isParking) {
        previousEvent.stoppedTime =
            previousEvent.dateTime.difference(currentEvent.dateTime);
        events.add(previousEvent);
      } else {
        events.add(previousEvent);
      }
      previousEvent = currentEvent;
    }
    events.add(previousEvent);
    return events;
  } */
}
