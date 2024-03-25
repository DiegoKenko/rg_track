import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/pagination.dart';
import 'package:rg_track/model/vehicle_event.dart';
import 'package:rg_track/ui/events/cubit/vehicle_events_state.dart';

class VehicleEventsCubit extends Cubit<VehicleEventsState> {
  final Map<int, List<VehicleEvent>> accounts = {};
  Pagination<VehicleEvent>? currentPage;

  VehicleEventsCubit() : super(VehicleEventsInitial());

  Future<List<VehicleEvent>> nextPage() async {
    try {} on Exception {
      emit(ListVehicleEventsError(ErrorEntity.empty()));
    }
    return [];
  }

  Future<List<VehicleEvent>> refreshVehicleEvents(
      [bool initial = false]) async {
    try {} on Exception {
      emit(ListVehicleEventsError(ErrorEntity.empty()));
    }
    return [];
  }

  Future<VehicleEvent?> storeVehicleEvent(VehicleEvent account) async {
    emit(VehicleEventsStoreProcessingState());
    try {} on Exception {
      emit(VehicleEventStoredFailsState(ErrorEntity.empty()));
    }
    return null;
  }

  Future<VehicleEvent?> showVehicleEvent(String id) async {
    try {} on Exception {
      emit(VehicleEventShowFailsState(ErrorEntity.empty()));
    }
    return null;
  }

  Future deleteVehicleEvent(VehicleEvent vehicleEvent) async {
    try {} on Exception {
      emit(VehicleEventDeleteFailsState(ErrorEntity.empty()));
    }
  }
}
