import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/customer/customer_datasource.dart';
import 'package:rg_track/datasource/device/device_get_all_datasource.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/user.dart';

class DeviceGetAllUsecase {
  Future<List<Device>> call(UserEntity user, bool customersDevices) async {
    DeviceGetAllDatasource _deviceDatasource = DeviceGetAllDatasource();
    CustomerDatasource _customerDatasource = CustomerDatasource();
    List<Device> devices = [];

    await _deviceDatasource.getDevicesUser(user.id ?? '').fold((success) {
      devices.addAll(success);
    }, (error) {
      return null;
    });
    if (customersDevices) {
      List<Customer> customers = await _customerDatasource
          .getCustomersUser(user.id ?? '')
          .fold((success) => success, (error) => []);

      for (var element in customers) {
        await _deviceDatasource.getDevicesUser(element.id ?? '').fold(
            (success) {
          devices.addAll(success);
        }, (error) {
          return null;
        });
      }
    }

    return devices;
  }
}
