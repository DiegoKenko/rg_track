import 'package:equatable/equatable.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';

abstract class DevicesListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeviceListLoadingState extends DevicesListState {}

class DevicesListInitialState extends DevicesListState {}

class DevicesListErrorState extends DevicesListState {
  final ErrorEntity? exception;

  DevicesListErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}

class DevicesListSuccessfulState extends DevicesListState {
  final List<Device> devices;

  DevicesListSuccessfulState(this.devices);

  @override
  List<Object> get props => [...devices];
}
