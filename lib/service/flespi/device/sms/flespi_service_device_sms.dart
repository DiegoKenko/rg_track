import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/device/sms/flespi_sms.dart';
import 'package:rg_track/service/flespi/flespi_base.dart';
import 'package:rg_track/service/flespi/flespi_service.dart';

class FlespiServiceDeviceSms {
  final FlespiService flespiService = FlespiService();

  Future<Result<bool, ErrorEntity>> sendSms(
      String deviceId, FlespiSms sms) async {
    if (deviceId.isEmpty || sms.name.isEmpty) {
      return Failure(ErrorEntity(code: EnumErrorCode.e04450, message: ''));
    }
    final String url =
        '$flespiBasePath$flespiDevicePath/$deviceId$flespiSmsPath';
    return await flespiService.post(
      url,
      data: [sms.toMap()],
    ).fold((success) {
      return true.toSuccess();
    },
        (error) =>
            Failure(ErrorEntity(code: EnumErrorCode.e04450, message: '')));
  }
}
