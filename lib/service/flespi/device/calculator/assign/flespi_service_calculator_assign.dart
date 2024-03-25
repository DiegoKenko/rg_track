import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/flespi_base.dart';
import 'package:rg_track/service/flespi/flespi_service.dart';

class FlespiServiceCalculatorAssign {
  final FlespiService flespiService = FlespiService();

  Future<Result<bool, ErrorEntity>> call(
      String deviceId, String calculatorId) async {
    if (deviceId.isEmpty || calculatorId.isEmpty) {
      return Failure(ErrorEntity(code: EnumErrorCode.e04602, message: ''));
    }
    final String url = '$flespiBasePath$flespiCalculatorsPath/$calculatorId/devices/$deviceId';
    return await flespiService.post(url).fold((success) {
      return true.toSuccess();
    },
        (error) =>
            Failure(ErrorEntity(code: EnumErrorCode.e04602, message: '')));
  }
}
