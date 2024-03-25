import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/device/device_update_datasource.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';

class DeviceUpdateUsecase {
  Future<Result<Device, ErrorEntity>> call(Device device) async {
    DeviceUpdateDatasource deviceDatasource = DeviceUpdateDatasource();

    ErrorEntity error = ErrorEntity.empty();

    await deviceDatasource.update(device).fold((success) {}, (e) => error = e);

    if (error.isEmpty) {
      return device.toSuccess();
    } else {
      return error.toFailure();
    }
  }
}
