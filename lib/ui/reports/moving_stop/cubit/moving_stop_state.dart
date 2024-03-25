import 'package:equatable/equatable.dart';
import 'package:rg_track/model/vehicle.dart';

abstract class MovingStopState extends Equatable {
  const MovingStopState();

  @override
  List<Object> get props => [];
}

class MovingStopInitialState extends MovingStopState {}

class MovingStopLoadingState extends MovingStopState {}

class MovingStopErrorState extends MovingStopState {}

class MovingStopSuccessState extends MovingStopState {
  final List<Vehicle> vehicles;

  const MovingStopSuccessState({required this.vehicles});

  @override
  List<Object> get props => [...vehicles];
}
