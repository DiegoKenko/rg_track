import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/device/device_create_datasource.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/channel/flespi_channel.dart';
import 'package:rg_track/service/flespi/channel/flespi_service_channel.dart';
import 'package:rg_track/service/flespi/device/calculator/assign/flespi_service_calculator_assign.dart';
import 'package:rg_track/service/flespi/device/command/flespi_service_device_command.dart';
import 'package:rg_track/service/flespi/device/device_adapter/flespi_device_adapter.dart';
import 'package:rg_track/service/flespi/device/flespi_device.dart';
import 'package:rg_track/service/flespi/device/flespi_service_device.dart';
import 'package:rg_track/service/flespi/flespi_base.dart';

class DeviceCreationUsecase {
  Future<Result<Device, ErrorEntity>> call(Device device) async {
    FlespiChannel? _flespiChannel;
    ErrorEntity? _error;
    FlespiDevice? _flespiDevice = FlespiDeviceAdapter().call(device);

    if (_flespiDevice != null) {
      await _getChannel(_flespiDevice).fold(
        (success) => _flespiChannel = success,
        (e) => _error = e,
      );
    }
    if (_error != null) {
      _revert(_flespiDevice);
      return _error!.toFailure();
    }

    if (_flespiChannel != null && _error == null) {
      await _createDevice(device, _flespiDevice!, _flespiChannel!).fold(
          (success) {
        device = success;
      }, (e) => _error = e);
    }

    if (_error != null) {
      _revert(_flespiDevice);
      return _error!.toFailure();
    }

    await FlespiServiceCalculatorAssign()
        .call(device.id ?? '', flespiCalcTripDetector.toString())
        .onFailure((failure) {
      _error = failure;
    });

    await FlespiServiceCalculatorAssign()
        .call(device.id ?? '', flespiCalcCutPower.toString())
        .onFailure((failure) {
      _error = failure;
    });

    if (_error != null) {
      _revert(_flespiDevice);
      return _error!.toFailure();
    }

    await FlespiServiceDeviceCommand()
        .sendCommandQueue(
            device.id ?? '',
            _flespiDevice!.connectServerCommand(
                _flespiChannel!.host!, _flespiChannel!.port!))
        .fold((success) {}, (failure) {
      _error = failure;
    });

    if (_error != null) {
      _revert(_flespiDevice);
      return _error!.toFailure();
    }

    if (device.channelId == null) {
      _revert(_flespiDevice);
      return ErrorEntity(code: EnumErrorCode.e04211, message: '').toFailure();
    }
    if (device.id?.isNotEmpty ?? false) {
      return device.toSuccess();
    } else {
      return _error!.toFailure();
    }
  }

  Future<void> _revert(FlespiDevice? device) async {
    if (device != null) {
      FlespiServiceDevice flespiServiceDevice = FlespiServiceDevice();
      await flespiServiceDevice.delete(device.id.toString());
    }
  }

  Future<Result<FlespiChannel, ErrorEntity>> _getChannel(
      FlespiDevice device) async {
    if (device.channelId != null) {
      FlespiServiceChannel flespiServiceChannel = FlespiServiceChannel();
      return await flespiServiceChannel.get(device.channelId!.toString()).fold(
            (success) => success.toSuccess(),
            (error) => error.toFailure(),
          );
    } else {
      return ErrorEntity.empty().toFailure();
    }
  }

  Future<Result<Device, ErrorEntity>> _createDevice(
    Device device,
    FlespiDevice flespiDevice,
    FlespiChannel flespiChannel,
  ) async {
    ErrorEntity error = ErrorEntity.empty();

    await _createFlespiDevice(flespiDevice).fold((success) {
      flespiDevice = success;
      flespiDevice.channelId = flespiChannel.id.toString();
      device = device.copyWithFlespi(flespiDevice);
    }, (e) => error = e);

    if (error.isEmpty) {
      return await _createFirebaseDevice(device)
          .fold((success) => success.toSuccess(), (e) => e.toFailure());
    }
    return error.toFailure();
  }

  Future<Result<FlespiDevice, ErrorEntity>> _createFlespiDevice(
      FlespiDevice flespiDevice) async {
    FlespiServiceDevice flespiServiceDevice = FlespiServiceDevice();
    return await flespiServiceDevice.create(flespiDevice).fold(
      (success) {
        return success.toSuccess();
      },
      (error) => error.toFailure(),
    );
  }

  /*  Future<Result<bool, ErrorEntity>> _execConnection(
      FlespiDevice device, FlespiDeviceCommand command) async {
    FlespiServiceChannelDeviceConnection flespiServiceChannelDeviceConnection =
        FlespiServiceChannelDeviceConnection();
    return await flespiServiceChannelDeviceConnection
        .sendCommand(device, command)
        .fold(
          (success) => success.executed.toSuccess(),
          (error) => false.toSuccess(),
        );
  } */

  Future<Result<Device, ErrorEntity>> _createFirebaseDevice(
      Device device) async {
    DeviceCreateDatasource deviceDatasource = DeviceCreateDatasource();
    return await deviceDatasource.create(device).fold((success) {
      return success.toSuccess();
    }, (error) => error.toFailure());
  }
}
