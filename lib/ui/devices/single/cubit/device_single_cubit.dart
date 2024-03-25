import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/customer/customer_datasource.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/service/flespi/device/flespi_service_device.dart';
import 'package:rg_track/ui/devices/single/cubit/device_single_state.dart';
import 'package:rg_track/usecase/device/device_creation_usecase.dart';
import 'package:rg_track/usecase/device/device_update_usecase.dart';

class DeviceSingleCubit extends Cubit<DeviceSingleState> {
  final DeviceUpdateUsecase deviceUpdateUsecase = DeviceUpdateUsecase();
  final FlespiServiceDevice flespiServiceDevice = FlespiServiceDevice();
  final DeviceCreationUsecase deviceCreationUsecase = DeviceCreationUsecase();

  DeviceSingleCubit() : super(DeviceSingleInitialState());

  Future<Device?> show(String id) async {
    try {} on Exception {}
    return null;
  }

  Future<Result<Device, ErrorEntity>> create(Device device) async {
    emit(DeviceSingleLoadingState());
    return await deviceCreationUsecase.call(device).fold((success) {
      emit(DeviceSingleSuccessfulState(success));
      return success.toSuccess();
    }, (error) {
      emit(DeviceSingleErrorState(error));
      return error.toFailure();
    });
  }

  Future<Result<Device, ErrorEntity>> update(Device device) async {
    emit(DeviceSingleLoadingState());

    return deviceUpdateUsecase.call(device).fold((success) {
      emit(DeviceSingleSuccessfulState(success));
      return success.toSuccess();
    }, (error) {
      emit(DeviceSingleErrorState(error));
      return error.toFailure();
    });
  }

  Future<List<Customer>> getCustomers(String userId) async {
    return await CustomerDatasource().getCustomersUser(userId).fold((success) {
      return success;
    }, (error) => []);
  }
}
