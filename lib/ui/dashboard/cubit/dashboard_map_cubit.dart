import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/dashboard/cubit/dashboard_map_state.dart';
import 'package:rg_track/usecase/vehicle/vehicle_get_all_usecase.dart';

class DashboardMapCubit extends Cubit<DashboardMapState> {
  DashboardMapCubit() : super(DashboardMapInitialState());
  final VehicleGetAllUsecase _vehicleGetAll = VehicleGetAllUsecase();

  Future<void> init() async {
    List<Vehicle> vehicles = [];
    emit(DashboardMapLoadingState());
    if (AuthService.instance.user.authorized) {
      await _vehicleGetAll
          .call(AuthService.instance.user.id ?? '', true)
          .fold((success) => vehicles = success, (error) => null);
      emit(DashboardMapSuccessState(vehicles: vehicles));
    } else {
      emit(DashboardMapErrorState(ErrorEntity.empty()));
    }
  }
}
