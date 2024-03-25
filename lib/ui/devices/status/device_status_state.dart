import 'package:equatable/equatable.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/device/status/flespi_device_status.dart';

abstract class DeviceStatusState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeviceStatusLoadingState extends DeviceStatusState {}

class DeviceStatusInitialState extends DeviceStatusState {}

class DeviceStatusErrorState extends DeviceStatusState {
  final ErrorEntity exception;

  DeviceStatusErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}

class DeviceStatusSuccessfulState extends DeviceStatusState {
  final FlespiDeviceStatus status;

  DeviceStatusSuccessfulState(this.status);

  @override
  List<Object> get props => [status];
}
