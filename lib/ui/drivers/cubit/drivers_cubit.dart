import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/driver.dart';
import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/pagination.dart';
import 'package:rg_track/ui/drivers/cubit/drivers_state.dart';

class DriversCubit extends Cubit<DriversState> {
  final Map<int, List<DriversCubit>> accounts = {};
  Pagination<Driver>? currentPage;

  DriversCubit() : super(DriversInitial());

  Future<List<Driver>> nextPage() async {
    try {} on Exception {
      emit(ListDriversError(ErrorEntity.empty()));
    }
    return [];
  }

  Future<List<Driver>> refreshDrivers([bool initial = false]) async {
    try {} on Exception {
      emit(ListDriversError(ErrorEntity.empty()));
    }
    return [];
  }

  Future<Driver?> storeDriver(Driver account) async {
    emit(DriversStoreProcessingState());
    try {} on Exception {
      emit(DriverStoredFailsState(ErrorEntity.empty()));
    }
    return null;
  }

  Future<Driver?> showDriver(String id) async {
    try {} on Exception {
      emit(DriverShowFailsState(ErrorEntity.empty()));
    }
    return null;
  }

  Future deleteDriver(Driver account) async {
    try {} on Exception {
      emit(DriverDeleteFailsState(ErrorEntity.empty()));
    }
  }
}
