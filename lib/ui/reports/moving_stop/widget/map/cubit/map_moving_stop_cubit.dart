import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/model/vehicle_status.dart';
import 'package:rg_track/model/vehicle_trail.dart';
import 'package:rg_track/service/flespi/device/calculator/trip/flespi_service_trip.dart';
import 'package:rg_track/service/flespi/device/message/flespi_channel_message.dart';
import 'package:rg_track/service/flespi/device/message/flespi_service_channel_message.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_moving_stop_state.dart';

class MapMovingStopCubit extends Cubit<MapMovingStopState> {
  MapMovingStopCubit() : super(MapMovingStopInitialState());
  final FlespiServiceCalculatorTrip _flespiServiceCalculatorTrip =
      FlespiServiceCalculatorTrip();

  Future<void> init(Vehicle vehicle) async {
    VehicleStatus vehicleStatus = VehicleStatus.empty();
    List<VehicleTrail> trails = [];
    emit(MapMovingStopLoadingState());
    if (vehicle.id != null) {
      if (vehicle.deviceMainId != null) {
        await _flespiServiceCalculatorTrip
            .getTrips(vehicle.deviceMainId.toString())
            .fold((success) {
          for (var element in success) {
            trails.add(VehicleTrail.fromFlespiCalcTrip(element));
          }
        }, (e) => null);

        await _loadCurrentPosition(vehicle.deviceMainId.toString()).fold(
            (success) =>
                vehicleStatus = VehicleStatus.fromFlespiMessage(success),
            (e) => null);
      }
    }

    emit(MapMovingStopSuccessState(
      vehicle: vehicle,
      vehicleTrailSelected: VehicleTrail.empty(),
      vehicleTrails: trails,
      vehicleStatus: vehicleStatus,
    ));
  }

  Future<Result<FlespiChannelMessage, ErrorEntity>> _loadCurrentPosition(
      String deviceId) async {
    return await FlespiServiceChannelMessage()
        .getMessages(deviceId, limit: 1, reverse: true)
        .fold((success) => success.first.toSuccess(),
            (error) => error.toFailure());
  }

  void setTrail(Vehicle vehicle, List<VehicleTrail> trails,
      VehicleStatus vehicleStatus, int index) {
    VehicleTrail vehicleTrailSelected = VehicleTrail.empty();
    if (index >= 0 && index < trails.length) {
      vehicleTrailSelected = trails[index];
    }
    emit(MapMovingStopSuccessState(
      vehicle: vehicle,
      vehicleTrailSelected: vehicleTrailSelected,
      vehicleTrails: trails,
      vehicleStatus: vehicleStatus,
      position: vehicleTrailSelected.trails.isNotEmpty
          ? LatLng(vehicleTrailSelected.trails.first.latitude,
              vehicleTrailSelected.trails.first.longitude)
          : null,
    ));
  }

  void clear() {
    emit(MapMovingStopInitialState());
  }
}
