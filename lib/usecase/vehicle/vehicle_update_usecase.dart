import 'package:result_dart/result_dart.dart';
import 'package:rg_track/const/enum/enum_max_speed.dart';
import 'package:rg_track/datasource/device/device_get_datasource.dart';
import 'package:rg_track/datasource/vehicle/vehicle_datasource.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/service/flespi/device/calculator/assign/flespi_service_calculator_assign.dart';
import 'package:rg_track/service/flespi/device/command/flespi_service_device_command.dart';
import 'package:rg_track/service/flespi/device/device_adapter/flespi_device_adapter.dart';
import 'package:rg_track/service/flespi/device/flespi_device.dart';

class VehicleUpdateUsecase {
  Future<Result<Vehicle, ErrorEntity>> call(Vehicle vehicle) async {
    VehicleDatasource vehicleDatasource = VehicleDatasource();
    DeviceGetDatasource deviceDatasource = DeviceGetDatasource();
    Device? device;
    ErrorEntity e = ErrorEntity.empty();

    if ((vehicle.deviceMainId?.isNotEmpty ?? false) &&
        vehicle.maxSpeed != null) {
      await deviceDatasource.getDevice(vehicle.deviceMainId!).fold((success) {
        device = success;
      }, (error) => e = error);

      if (e.isEmpty || device != null) {
        FlespiDevice? flespiDevice = FlespiDeviceAdapter().call(device!);
        if (flespiDevice != null) {
          await FlespiServiceDeviceCommand().sendCommandQueue(
              flespiDevice.id?.toString() ?? '',
              flespiDevice.speedMax(vehicle.maxSpeed?.speed ?? 100));
          await FlespiServiceCalculatorAssign()
              .call(flespiDevice.id?.toString() ?? '',
                  vehicle.maxSpeed?.calcId.toString() ?? '0')
              .onFailure((failure) {});
        }
      }
    }

    return await vehicleDatasource
        .update(vehicle)
        .fold((success) => success.toSuccess(), (error) => error.toFailure());
  }
}
