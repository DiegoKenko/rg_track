import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/reports/vehicle_location_history/cubit/location_vehicle_state.dart';

class LocationVehicleListCubit extends Cubit<LocationVehicleState> {
  LocationVehicleListCubit() : super(LocationVehicleInitial());

  Future<void> getVehicle(String id, Vehicle? vehicle) async {
    emit(LocationVehicleLoading());
    try {} on Exception catch (e) {
      emit(LocationVehicleError(e.toString()));
    }
  }
}
