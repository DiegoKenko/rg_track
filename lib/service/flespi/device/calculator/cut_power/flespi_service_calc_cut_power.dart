import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/device/calculator/cut_power/flespi_calc_cut_power.dart';
import 'package:rg_track/service/flespi/flespi_base.dart';
import 'package:rg_track/service/flespi/flespi_service_multiple.dart';

class FlespiServiceCalcCutPower {
  final String _baseChannelUrl = flespiBasePath + flespiDevicePath;
  final FlespiServiceMultiple _flespiServiceMultiple = FlespiServiceMultiple();

  Future<Result<List<FlespiCalcCutPower>, ErrorEntity>> call(
      String deviceId) async {
    if (deviceId.isEmpty) {
      return Failure(ErrorEntity(code: EnumErrorCode.e04210, message: ''));
    }
    return await _flespiServiceMultiple
        .post(_baseChannelUrl + '/' + deviceId + flespiCalculatePath, data: {
      "calc_id": flespiCalcCutPower,
    }).fold((success) {
      return success
          .map((e) => FlespiCalcCutPower.fromMap(e))
          .toList()
          .toSuccess();
    }, (error) => error.toFailure());
  }
}
