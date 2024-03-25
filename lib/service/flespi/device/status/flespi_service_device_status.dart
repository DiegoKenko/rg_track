import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/device/status/flespi_device_status.dart';
import 'package:rg_track/service/flespi/flespi_base.dart';
import 'package:rg_track/service/flespi/flespi_service.dart';

class FlespiServiceDeviceStatus {
  final String _baseChannelUrl = flespiBasePath + flespiChannelPath;
  final FlespiService _flespiService = FlespiService();
  FlespiServiceDeviceStatus() {}

  Future<Result<FlespiDeviceStatus, ErrorEntity>> getStatus(
    String channelId,
    String imei,
  ) async {
    return await _flespiService
        .get(_baseChannelUrl + '/' + channelId + flespiIdentPath + '/' + imei)
        .fold((success) {
      return FlespiDeviceStatus.fromMap(success).toSuccess();
    }, (error) => error.toFailure());
  }
}
