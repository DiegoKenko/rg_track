import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/device/flespi_device.dart';
import 'package:rg_track/service/flespi/flespi_base.dart';
import 'package:rg_track/service/flespi/flespi_service.dart';

class FlespiServiceDevice {
  final String baseUrl = flespiBasePath + flespiDevicePath;
  final FlespiService flespiService = FlespiService();
  FlespiServiceDevice() {}

  Future<Result<FlespiDevice, ErrorEntity>> get(FlespiDevice device) async {
    return await flespiService.get(baseUrl, params: device.toMap()).fold(
        (success) {
      return FlespiDevice.fromMap(success).toSuccess();
    }, (error) => error.toFailure());
  }

  Future<Result<bool, ErrorEntity>> delete(String deviceId) async {
    return await flespiService
        .delete(
      baseUrl + '/' + deviceId,
    )
        .fold((success) {
      return true.toSuccess();
    }, (error) => error.toFailure());
  }

  Future<Result<FlespiDevice, ErrorEntity>> create(FlespiDevice device) async {
    return await flespiService.post(baseUrl, data: [device.toMap()]).fold(
        (success) {
      return FlespiDevice.fromMap(success).toSuccess();
    }, (error) => error.toFailure());
  }
}
