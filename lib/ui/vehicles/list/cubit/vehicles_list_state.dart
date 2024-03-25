import 'package:rg_track/model/vehicle.dart';

abstract class VehiclesListState {}

class VehiclesListInitialState extends VehiclesListState {}

class VehiclesListLoadingState extends VehiclesListState {}

class VehiclesListErrorState extends VehiclesListState {
  final Exception? exception;

  VehiclesListErrorState(this.exception);
}

class VehicleListSuccessfulState extends VehiclesListState {
  final List<Vehicle> vehicles;

  VehicleListSuccessfulState(this.vehicles);
}
