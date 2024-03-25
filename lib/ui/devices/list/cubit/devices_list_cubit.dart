import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/user.dart';
import 'package:rg_track/service/flespi/device/flespi_service_device.dart';
import 'package:rg_track/ui/devices/list/cubit/devices_list_state.dart';
import 'package:rg_track/usecase/device/device_deletion_usecase.dart';
import 'package:rg_track/usecase/device/device_get_all_usecase.dart';

class DevicesListCubit extends Cubit<DevicesListState> {
  final DeviceDeletionUsecase deviceDeletionUsecase = DeviceDeletionUsecase();
  final DeviceGetAllUsecase deviceGetAllUsecase = DeviceGetAllUsecase();
  final FlespiServiceDevice flespiServiceDevice = FlespiServiceDevice();

  DevicesListCubit() : super(DevicesListInitialState());

  Future<void> loadDevices(UserEntity user) async {
    emit(DeviceListLoadingState());

    await deviceGetAllUsecase.call(user, true).then((value) {
      emit(DevicesListSuccessfulState(value));
    });
  }

  Future<Result<bool, ErrorEntity>> delete(Device device) async {
    if (device.id != null) {
      return await deviceDeletionUsecase
          .call(device)
          .fold((success) => true.toSuccess(), (error) {
        return error.toFailure();
      });
    }
    return Failure(ErrorEntity(code: EnumErrorCode.e05103, message: ''));
  }
}
