import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/channel/flespi_channel.dart';
import 'package:rg_track/service/flespi/channel/flespi_service_channel.dart';
import 'package:rg_track/service/flespi/device/device_adapter/flespi_device_adapter.dart';
import 'package:rg_track/service/flespi/device/flespi_device.dart';
import 'package:rg_track/service/flespi/device/sms/flespi_service_device_sms.dart';
import 'package:rg_track/service/flespi/device/sms/flespi_sms.dart';
import 'package:rg_track/service/flespi/device/status/flespi_service_device_status.dart';
import 'package:rg_track/ui/devices/conection/cubit/device_connection_state.dart';

class DeviceConnectionCubit extends Cubit<DeviceConnectionState> {
  DeviceConnectionCubit() : super(DeviceConnectionInitialState());
  FlespiServiceChannel flespiServiceChannel = FlespiServiceChannel();
  FlespiServiceDeviceStatus flespiServiceDeviceStatus =
      FlespiServiceDeviceStatus();

  Future<void> loadDeviceConnectionParams(Device device) async {
    emit(DeviceConnectionLoadingState());
    FlespiDevice? flespiDevice = FlespiDeviceAdapter().call(device);

    if (flespiDevice == null) {
      _deviceConnectionError(
          ErrorEntity(code: EnumErrorCode.e04210, message: ''));
      return;
    }

    if (flespiDevice.channelId == null) {
      _deviceConnectionError(
          ErrorEntity(code: EnumErrorCode.e04211, message: ''));
      return;
    }

    await flespiServiceChannel.get(flespiDevice.channelId.toString()).fold(
        (success) {
      _deviceConnectionLoadSuccessful(success);
    }, (error) {
      _deviceConnectionError(error);
    });
  }

  Future<void> connectCommand(Device device, FlespiChannel channel) async {
    emit(DeviceConnectionLoadingState());
    FlespiDevice? flespiDevice = FlespiDeviceAdapter().call(device);

    if (flespiDevice == null) {
      _deviceConnectionError(
          ErrorEntity(code: EnumErrorCode.e04210, message: ''));
      return;
    }

    FlespiServiceDeviceSms()
        .sendSms(
          flespiDevice.id.toString(),
          FlespiSms.fromCommand(
            flespiDevice.connectServerCommand(
              channel.host ?? '',
              channel.port ?? '',
            ),
          ),
        )
        .fold(
          (success) => emit(DeviceConnectionCommandSuccessfulState()),
          (error) => emit(DeviceConnectionLoadSuccessfulState(channel)),
        );
  }

  Future<void> loadDeviceStatus(Device device) async {
    emit(DeviceConnectionLoadingState());
  }

  void _deviceConnectionError(ErrorEntity error) {
    emit(DeviceConnectionLoadErrorState(error));
  }

  void _deviceConnectionLoadSuccessful(FlespiChannel channel) {
    emit(DeviceConnectionLoadSuccessfulState(channel));
  }

  /*  void _deviceConnectionCommandSuccessful() {
    emit(DeviceConnectionCommandSuccessfulState());
  } */
}
