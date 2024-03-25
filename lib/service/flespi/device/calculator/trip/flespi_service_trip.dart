import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/device/calculator/trip/flespi_trip.dart';
import 'package:rg_track/service/flespi/flespi_base.dart';
import 'package:rg_track/service/flespi/flespi_service_multiple.dart';

class FlespiServiceCalculatorTrip {
  final String baseChannelUrl = flespiBasePath + flespiDevicePath;
  final FlespiServiceMultiple flespiServiceMultiple = FlespiServiceMultiple();
  FlespiServiceCalculatorTrip();

  Future<Result<List<FlespiTrip>, ErrorEntity>> getTrips(
      String deviceId) async {
    if (deviceId.isEmpty) {
      return Failure(ErrorEntity(code: EnumErrorCode.e04210, message: ''));
    }
    return await flespiServiceMultiple
        .post('$baseChannelUrl/$deviceId$flespiCalculatePath', data: {
      "calc_id": flespiCalcTripDetector,
    }).fold((success) {
      return success.map((e) => FlespiTrip.fromMap(e)).toList().toSuccess();
    }, (error) => error.toFailure());
  }
}
