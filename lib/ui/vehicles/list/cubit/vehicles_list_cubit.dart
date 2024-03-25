import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/datasource/vehicle/vehicle_datasource.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/vehicles/list/cubit/vehicles_list_state.dart';
import 'package:rg_track/usecase/vehicle/vehicle_get_all_usecase.dart';

class VehicleListCubit extends Cubit<VehiclesListState> {
  final Map<int, List<Vehicle>> vehicles = {};

  VehicleListCubit() : super(VehiclesListInitialState());

  Future<void> deleteVehicle(Vehicle vehicle) async {
    final VehicleDatasource vehiclesDataSource = VehicleDatasource();
    emit(VehiclesListLoadingState());
    try {
      await vehiclesDataSource.delete(vehicle.id!);
    } on Exception catch (err) {
      emit(VehiclesListErrorState(err));
    }
  }

  Future<void> loadVehicles(String userId) async {
    List<Vehicle> vehicles = [];
    final VehicleGetAllUsecase vehicleGetAll = VehicleGetAllUsecase();
    emit(VehiclesListLoadingState());
    try {
      await vehicleGetAll
          .call(AuthService.instance.user.id ?? '', true)
          .fold((success) => vehicles = success, (error) => null);
      emit(VehicleListSuccessfulState(vehicles));
    } on Exception catch (err) {
      emit(VehiclesListErrorState(err));
    }
  }

  Future<List<Vehicle>> refreshVehicles(String userId) async {
    try {
      await loadVehicles(userId);
    } on Exception catch (err) {
      emit(VehiclesListErrorState(err));
    }
    return [];
  }
}
