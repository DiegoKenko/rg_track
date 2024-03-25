import 'package:rg_track/model/vehicle.dart';

abstract class LocationVehicleState {}

class LocationVehicleInitial extends LocationVehicleState {}

class LocationVehicleLoading extends LocationVehicleState {}

class LocationVehicleLoaded extends LocationVehicleState {
  final Vehicle vehicle;

  LocationVehicleLoaded(this.vehicle);
}

class LocationVehicleError extends LocationVehicleState {
  final String message;

  LocationVehicleError(this.message);
}
