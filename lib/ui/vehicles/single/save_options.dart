import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/peripheral.dart';
import 'package:rg_track/model/vehicle.dart';

class SaveOptions {
  final Vehicle vehicle;
  final List<Customer> addedCustomers;
  final List<Customer> removedCustomers;
  final List<Device> addedDevices;
  final List<Device> removedDevices;
  final List<Peripheral> addedPeripherals;
  final List<Peripheral> removedPeripherals;

  SaveOptions({
    required this.vehicle,
    this.addedCustomers = const [],
    this.removedCustomers = const [],
    this.addedDevices = const [],
    this.removedDevices = const [],
    this.addedPeripherals = const [],
    this.removedPeripherals = const [],
  });
}

enum SaveOptionsType {
  create,
  update,
  delete,
}
