import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/device/device_delete_datasource.dart';
import 'package:rg_track/datasource/device/device_update_datasource.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/channel/flespi_service_channel.dart';
import 'package:rg_track/service/flespi/device/device_adapter/flespi_device_adapter.dart';
import 'package:rg_track/service/flespi/device/flespi_device.dart';
import 'package:rg_track/service/flespi/device/flespi_service_device.dart';

class DeviceDeletionUsecase {
  Future<Result<bool, ErrorEntity>> call(Device device) async {
    ErrorEntity error = ErrorEntity.empty();
    bool removeChannelFromDevice = false;

    if (device.channelId != null) {
      await _deleteFlepsiChannel(device.channelId!).fold((success) {}, (e) {
        error = e;
        removeChannelFromDevice = true;
      });
    }

    if (error.isEmpty) {
      await _deleteDevice(device).fold((success) {}, (e) => error = e);

      return error.toFailure();
    }

    if (removeChannelFromDevice) {
      return await _removeChannelDevice(device);
    }
    return true.toSuccess();
  }

  Future<Result<bool, ErrorEntity>> _deleteFlepsiChannel(
      String flespiChannelId) async {
    FlespiServiceChannel flespiServiceChannel = FlespiServiceChannel();
    return await flespiServiceChannel.delete(flespiChannelId);
  }

  Future<Result<bool, ErrorEntity>> _deleteDevice(Device device) async {
    FlespiDevice? flespiDevice = FlespiDeviceAdapter().call(device);
    DeviceDeleteDatasource deviceDatasource = DeviceDeleteDatasource();
    ErrorEntity error = ErrorEntity.empty();

    if (flespiDevice != null) {
      await deviceDatasource.delete(device.id ?? '').fold((success) {}, (e) {
        error = e;
      });

      if (error.isEmpty) {
        await _deleteFlepsiDevice(flespiDevice.id?.toString() ?? '')
            .fold((success) {}, (e) => error = e);
      } else {
        return ErrorEntity(code: EnumErrorCode.e05103, message: '').toFailure();
      }
      if (error.isEmpty) {
        return true.toSuccess();
      } else {
        return ErrorEntity(code: EnumErrorCode.e04220, message: '').toFailure();
      }
    } else {
      return ErrorEntity(code: EnumErrorCode.e04210, message: '').toFailure();
    }
  }

  Future<Result<bool, ErrorEntity>> _deleteFlepsiDevice(
      String flespiDeviceId) async {
    FlespiServiceDevice flespiServiceDevice = FlespiServiceDevice();

    return await flespiServiceDevice
        .delete(flespiDeviceId)
        .fold((success) => true.toSuccess(), (error) => error.toFailure());
  }

  Future<Result<bool, ErrorEntity>> _removeChannelDevice(Device device) async {
    DeviceUpdateDatasource deviceDatasource = DeviceUpdateDatasource();
    device.channelId = null;
    return await deviceDatasource
        .update(device)
        .fold((success) => true.toSuccess(), (error) => error.toFailure());
  }
}
