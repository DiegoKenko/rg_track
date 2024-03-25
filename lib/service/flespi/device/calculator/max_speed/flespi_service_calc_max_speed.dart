import 'package:result_dart/result_dart.dart';
import 'package:rg_track/const/enum/enum_max_speed.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/device/calculator/max_speed/flespi_calc_max_speed.dart';
import 'package:rg_track/service/flespi/flespi_base.dart';
import 'package:rg_track/service/flespi/flespi_service_multiple.dart';

class FlespiServiceCalculatorMaxSpeed {
  final String baseChannelUrl = flespiBasePath + flespiDevicePath;
  final FlespiServiceMultiple flespiServiceMultiple = FlespiServiceMultiple();
  FlespiServiceCalculatorMaxSpeed();

  Future<Result<List<FlespiCalcMaxSpeed>, ErrorEntity>> getMaxsSpeed(
    String deviceId,
    EnumMaxSpeed maxSpeed,
  ) async {
    if (deviceId.isEmpty) {
      return Failure(ErrorEntity(code: EnumErrorCode.e04210, message: ''));
    }
    return await flespiServiceMultiple
        .post('$baseChannelUrl/$deviceId$flespiCalculatePath', data: {
      "calc_id": maxSpeed.calcId,
    }).fold((success) {
      return success
          .map((e) => FlespiCalcMaxSpeed.fromMap(e))
          .toList()
          .toSuccess();
    }, (error) => error.toFailure());
  }
}
