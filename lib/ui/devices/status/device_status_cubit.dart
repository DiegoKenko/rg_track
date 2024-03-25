import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/channel/flespi_channel.dart';
import 'package:rg_track/service/flespi/channel/flespi_service_channel.dart';
import 'package:rg_track/service/flespi/device/device_adapter/flespi_device_adapter.dart';
import 'package:rg_track/service/flespi/device/flespi_device.dart';
import 'package:rg_track/service/flespi/device/status/flespi_device_status.dart';
import 'package:rg_track/service/flespi/device/status/flespi_service_device_status.dart';
import 'package:rg_track/ui/devices/status/device_status_state.dart';

class DeviceStatusCubit extends Cubit<DeviceStatusState> {
  DeviceStatusCubit() : super(DeviceStatusInitialState());
  FlespiServiceChannel flespiServiceChannel = FlespiServiceChannel();
  FlespiServiceDeviceStatus flespiServiceDeviceStatus =
      FlespiServiceDeviceStatus();

  Future<void> loadDeviceStatus(Device device) async {
    emit(DeviceStatusLoadingState());
    FlespiDevice? flespiDevice = FlespiDeviceAdapter().call(device);
    FlespiChannel? channel;
    ErrorEntity error = ErrorEntity.empty();

    if (flespiDevice == null) {
      _deviceStatusError(ErrorEntity(code: EnumErrorCode.e04210, message: ''));
      return;
    }

    if (flespiDevice.channelId == null) {
      _deviceStatusError(ErrorEntity(code: EnumErrorCode.e04211, message: ''));
      return;
    }

    await flespiServiceChannel.get(flespiDevice.channelId.toString()).fold(
        (success) {
      channel = success;
    }, (e) => error = e);

    if (channel != null) {
      return await flespiServiceDeviceStatus
          .getStatus(channel!.id.toString(), flespiDevice.imei)
          .fold((success) {
        _deviceStatusSuccessful(success);
        success;
      }, (error) => error);
    }

    _deviceStatusError(error);
  }

  void _deviceStatusError(ErrorEntity error) {
    emit(DeviceStatusErrorState(error));
  }

  void _deviceStatusSuccessful(FlespiDeviceStatus status) {
    emit(DeviceStatusSuccessfulState(status));
  }
}
