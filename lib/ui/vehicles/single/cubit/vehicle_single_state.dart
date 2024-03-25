import 'package:rg_track/model/error_entity.dart';

abstract class VehicleSingleState {}

class VehicleSingleInitialState extends VehicleSingleState {}

class VehicleSingleLoadingState extends VehicleSingleState {}

class VehicleSingleErrorState extends VehicleSingleState {
  final ErrorEntity exception;

  VehicleSingleErrorState(this.exception);
}

class VehicleSingleSaveSuccessfulState extends VehicleSingleState {
  VehicleSingleSaveSuccessfulState();
}
