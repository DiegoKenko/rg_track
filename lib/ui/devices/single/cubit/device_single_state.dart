import 'package:equatable/equatable.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';

abstract class DeviceSingleState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeviceSingleLoadingState extends DeviceSingleState {}

class DeviceSingleInitialState extends DeviceSingleState {}

class DeviceSingleSuccessfulState extends DeviceSingleState {
  final Device device;

  DeviceSingleSuccessfulState(this.device);

  @override
  List<Object> get props => [device];
}

class DeviceSingleErrorState extends DeviceSingleState {
  final ErrorEntity exception;

  DeviceSingleErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}
