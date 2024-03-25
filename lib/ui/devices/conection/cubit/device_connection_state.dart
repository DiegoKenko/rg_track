import 'package:equatable/equatable.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/channel/flespi_channel.dart';

abstract class DeviceConnectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DeviceConnectionLoadingState extends DeviceConnectionState {}

class DeviceConnectionInitialState extends DeviceConnectionState {}

class DeviceConnectionLoadErrorState extends DeviceConnectionState {
  final ErrorEntity exception;

  DeviceConnectionLoadErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}

class DeviceConnectionLoadSuccessfulState extends DeviceConnectionState {
  final FlespiChannel channel;

  DeviceConnectionLoadSuccessfulState(this.channel);

  @override
  List<Object> get props => [channel];
}

class DeviceConnectionCommandErrorState extends DeviceConnectionState {
  final ErrorEntity exception;

  DeviceConnectionCommandErrorState(this.exception);

  @override
  List<Object?> get props => [exception];
}

class DeviceConnectionCommandSuccessfulState extends DeviceConnectionState {}
