import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/device/command/flespi_device_command.dart';
import 'package:rg_track/service/flespi/flespi_base.dart';
import 'package:rg_track/service/flespi/flespi_service.dart';

class FlespiServiceDeviceCommand {
  final FlespiService _flespiService = FlespiService();
  FlespiServiceDeviceCommand();

  Future<Result<bool, ErrorEntity>> checkServerStatus() async {
    return ErrorEntity.empty().toFailure();
  }

  Future<Result<FlespiDeviceCommand, ErrorEntity>> sendCommand(
    String deviceId,
    String command,
  ) async {
    try {
      if (deviceId.isNotEmpty) {
        return _flespiService.post(
          '$flespiBasePath$flespiDevicePath/$deviceId$flespiDeviceCommandPath',
          data: [FlespiDeviceCommand(command: command).toMap()],
        ).fold((success) {
          return FlespiDeviceCommand.fromMap(success).toSuccess();
        }, (error) {
          return error.toFailure();
        });
      } else {
        return ErrorEntity(code: EnumErrorCode.e04410, message: '').toFailure();
      }
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04420, message: e.toString())
          .toFailure();
    }
  }

  Future<Result<FlespiDeviceCommand, ErrorEntity>> sendCommandQueue(
    String deviceId,
    String command,
  ) async {
    try {
      if (deviceId.isNotEmpty) {
        return _flespiService.post(
          '$flespiBasePath$flespiDevicePath/$deviceId$flespiDeviceCommandQueuePath',
          data: [FlespiDeviceCommand(command: command).toMapQueue()],
        ).fold((success) {
          return FlespiDeviceCommand.fromMap(success).toSuccess();
        }, (error) {
          return error.toFailure();
        });
      } else {
        return ErrorEntity(code: EnumErrorCode.e04410, message: '').toFailure();
      }
    } catch (e) {
      return ErrorEntity(code: EnumErrorCode.e04420, message: e.toString())
          .toFailure();
    }
  }
}
