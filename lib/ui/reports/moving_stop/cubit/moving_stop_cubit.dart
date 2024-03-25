import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/ui/reports/moving_stop/cubit/moving_stop_state.dart';
import 'package:rg_track/usecase/vehicle/vehicle_get_all_usecase.dart';

class MovingStopCubit extends Cubit<MovingStopState> {
  MovingStopCubit() : super(MovingStopInitialState());
  final VehicleGetAllUsecase _vehicleGetAll = VehicleGetAllUsecase();

  Future<void> init() async {
    emit(MovingStopLoadingState());
    if (AuthService.instance.user.authorized) {
      await _vehicleGetAll.call(AuthService.instance.user.id ?? '', true).fold(
          (success) {
        emit(MovingStopSuccessState(vehicles: success));
      }, (error) {
        emit(MovingStopErrorState());
      });
    } else {
      emit(MovingStopErrorState());
    }
  }
}
