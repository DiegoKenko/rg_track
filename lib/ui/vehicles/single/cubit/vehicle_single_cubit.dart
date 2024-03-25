import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/customer/customer_datasource.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/vehicles/single/cubit/vehicle_single_state.dart';
import 'package:rg_track/usecase/device/device_get_all_usecase.dart';
import 'package:rg_track/usecase/vehicle/vehicle_create_usecase.dart';
import 'package:rg_track/usecase/vehicle/vehicle_update_usecase.dart';

class VehicleSingleCubit extends Cubit<VehicleSingleState> {
  final VehicleUpdateUsecase vehicleUpdateUsecase = VehicleUpdateUsecase();
  final VehicleCreateUsecase vehicleCreateUsecase = VehicleCreateUsecase();
  final DeviceGetAllUsecase deviceGetAllUsecase = DeviceGetAllUsecase();
  VehicleSingleCubit() : super(VehicleSingleInitialState());

  Future<Vehicle?> update(Vehicle vehicle) async {
    emit(VehicleSingleLoadingState());
    Vehicle? v;
    try {
      await vehicleUpdateUsecase(vehicle).fold(
        (success) {
          v = success;
          emit(VehicleSingleSaveSuccessfulState());
        },
        (e) => emit(VehicleSingleErrorState(e)),
      );
      return v;
    } on Exception {
      emit(VehicleSingleErrorState(ErrorEntity.empty()));
      return v;
    }
  }

  Future<Vehicle?> createVehicle(Vehicle vehicle) async {
    emit(VehicleSingleLoadingState());
    Vehicle? v;
    try {
      await vehicleCreateUsecase(vehicle).fold(
        (success) {
          v = success;
          emit(VehicleSingleSaveSuccessfulState());
        },
        (e) => emit(VehicleSingleErrorState(e)),
      );
      return v;
    } on Exception {
      emit(VehicleSingleErrorState(ErrorEntity.empty()));
      return v;
    }
  }

  Future<List<Device>> loadDevicesOptions(UserEntity user) async {
    return await deviceGetAllUsecase.call(user, false);
  }

  Future<List<Customer>> getCustomers(String userId) async {
    return await CustomerDatasource().getCustomersUser(userId).fold((success) {
      return success;
    }, (error) => []);
  }
}
