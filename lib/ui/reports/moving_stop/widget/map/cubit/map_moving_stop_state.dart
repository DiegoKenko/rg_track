import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/model/vehicle_status.dart';
import 'package:rg_track/model/vehicle_trail.dart';

abstract class MapMovingStopState extends Equatable {
  const MapMovingStopState();

  @override
  List<Object> get props => [];
}

class MapMovingStopInitialState extends MapMovingStopState {}

class MapMovingStopLoadingState extends MapMovingStopState {}

class MapMovingStopErrorState extends MapMovingStopState {
  final ErrorEntity error;

  const MapMovingStopErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class MapMovingStopSuccessState extends MapMovingStopState {
  final Vehicle vehicle;
  final VehicleStatus vehicleStatus;
  final VehicleTrail vehicleTrailSelected;
  final List<VehicleTrail> vehicleTrails;
  final LatLng? position;

  const MapMovingStopSuccessState({
    required this.vehicle,
    required this.vehicleTrailSelected,
    required this.vehicleTrails,
    required this.vehicleStatus,
    this.position,
  });

  @override
  List<Object> get props => [vehicle, vehicleTrailSelected];
}
