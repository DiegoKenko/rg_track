import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/customer/customer_datasource.dart';
import 'package:rg_track/datasource/vehicle/vehicle_datasource.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/vehicle.dart';

class VehicleGetAllUsecase {
  CustomerDatasource customerDatasource = CustomerDatasource();
  VehicleDatasource vehicleDatasource = VehicleDatasource();
  Future<Result<List<Vehicle>, ErrorEntity>> call(
      String userId, bool customersVehicles) async {
    List<Vehicle> vehicles = await vehicleDatasource.getVehiclesUser(userId);

    if (customersVehicles) {
      List<Vehicle> vehiclesTemp = await _getOthersUsersVehicle(userId);

      vehicles.addAll(vehiclesTemp);
    }

    return vehicles.toSuccess();
  }

  Future<List<Vehicle>> _getOthersUsersVehicle(String userId) async {
    List<Customer> customers = [];
    List<Vehicle> vehicles = [];

    await customerDatasource
        .getCustomersUser(userId)
        .fold((success) => customers = success, (error) => null);

    for (var element in customers) {
      List<Vehicle> temp = await vehicleDatasource.getVehiclesUser(element.id!);
      vehicles.addAll(temp);
    }

    return vehicles;
  }
}
