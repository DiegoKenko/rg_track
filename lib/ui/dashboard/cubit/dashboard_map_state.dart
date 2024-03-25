import 'package:equatable/equatable.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/vehicle.dart';

abstract class DashboardMapState extends Equatable {
  const DashboardMapState();

  @override
  List<Object> get props => [];
}

class DashboardMapInitialState extends DashboardMapState {}

class DashboardMapLoadingState extends DashboardMapState {}

class DashboardMapErrorState extends DashboardMapState {
  final ErrorEntity message;

  const DashboardMapErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class DashboardMapSuccessState extends DashboardMapState {
  final List<Vehicle> vehicles;

  const DashboardMapSuccessState({required this.vehicles});

  @override
  List<Object> get props => [...vehicles];
}
