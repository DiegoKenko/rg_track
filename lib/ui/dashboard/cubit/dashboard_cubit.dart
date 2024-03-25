import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/service/auth/auth_service.dart';
import 'package:rg_track/service/flespi/device/message/flespi_channel_message.dart';
import 'package:rg_track/service/flespi/device/message/flespi_service_channel_message.dart';
import 'package:rg_track/ui/dashboard/cubit/dashboard_state.dart';
import 'package:rg_track/usecase/event/load_events_usecase.dart';
import 'package:rg_track/usecase/vehicle/vehicle_get_all_usecase.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final LoadEventsUseCase _loadEventsUseCase = LoadEventsUseCase();

  DashboardCubit() : super(DashboardInitialState());
  final VehicleGetAllUsecase _vehicleGetAll = VehicleGetAllUsecase();

  Future<void> init() async {
    List<Event> events = [];
    List<Vehicle> vehicles = [];
    emit(DashboardLoadingState());
    if (AuthService.instance.user.authorized) {
      await _vehicleGetAll.call(AuthService.instance.user.id ?? '', true).fold(
          (success) {
        vehicles = success;
      }, (error) => null);
      for (var element in vehicles) {
        List<Event> e = await _loadEventsUseCase.load(element);
        events.addAll(e);
      }

      (int, int, int) status =
          await _getDevicesLastStatus(AuthService.instance.user.id ?? '');
      events.sort((a, b) => b.date!.compareTo(a.date!));
      emit(DashboardSuccessState(
        events: events,
        countGreenStatus: status.$1,
        countYellowStatus: status.$2,
        countRedStatus: status.$3,
      ));
    } else {
      emit(DashboardErrorState());
    }
  }

  Future<(int, int, int)> _getDevicesLastStatus(String userId) async {
    final FlespiServiceChannelMessage flespiServiceChannelMessage =
        FlespiServiceChannelMessage();
    final VehicleGetAllUsecase vehicleGetAll = VehicleGetAllUsecase();
    int offline0a6 = 0;
    int offline6a72 = 0;
    int offline72mais = 0;
    List<FlespiChannelMessage> messages = [];
    List<Vehicle> vehicles = await vehicleGetAll
        .call(userId, true)
        .fold((success) => success, (error) => []);

    if (userId.isEmpty) {
      return (0, 0, 0);
    }

    for (var element in vehicles) {
      if (element.deviceMainId?.isNotEmpty ?? false) {
        await flespiServiceChannelMessage
            .getMessages(element.deviceMainId!, limit: 1, reverse: true)
            .fold((success) => messages.addAll(success), (error) => []);
      }
    }

    for (var element in messages) {
      int diff = DateTime.now()
          .difference(DateTime.fromMillisecondsSinceEpoch(
              (element.timestamp ?? 0).toInt() * 1000))
          .inHours;
      if (diff < 6) {
        offline0a6++;
      } else if (diff < 72) {
        offline6a72++;
      } else {
        offline72mais++;
      }
    }

    return (offline0a6, offline6a72, offline72mais);
  }
}
