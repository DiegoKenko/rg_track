import 'package:rg_track/model/error_entity.dart';
import 'package:rg_track/model/vehicle_event.dart';

abstract class VehicleEventsState {}

class VehicleEventsInitial extends VehicleEventsState {}

class ListVehicleEventState extends VehicleEventsState {
  final List<VehicleEvent> vehicleEvents;

  ListVehicleEventState(this.vehicleEvents);
}

class ListVehicleEventsError extends VehicleEventsState {
  final ErrorEntity exception;

  ListVehicleEventsError(this.exception);
}

class VehicleEventStoredSuccessfulState extends VehicleEventsState {
  final VehicleEvent vehicleEvent;

  VehicleEventStoredSuccessfulState(this.vehicleEvent);
}

class VehicleEventLoadByIdState extends VehicleEventsState {
  final VehicleEvent vehicleEvent;

  VehicleEventLoadByIdState(this.vehicleEvent);
}

class VehicleEventShowFailsState extends VehicleEventsState {
  final ErrorEntity exception;

  VehicleEventShowFailsState(this.exception);
}

class VehicleEventShowFailsUnKnowState extends VehicleEventsState {
  final ErrorEntity exception;

  VehicleEventShowFailsUnKnowState(this.exception);
}

class VehicleEventStoredFailsState extends VehicleEventsState {
  final ErrorEntity exception;

  VehicleEventStoredFailsState(this.exception);
}

class VehicleEventStoredFailsUnKnowState extends VehicleEventsState {
  final ErrorEntity exception;

  VehicleEventStoredFailsUnKnowState(this.exception);
}

class DeleteVehicleEventByIdState extends VehicleEventsState {
  final VehicleEvent vehicleEvent;

  DeleteVehicleEventByIdState(this.vehicleEvent);
}

class VehicleEventDeleteFailsState extends VehicleEventsState {
  final ErrorEntity exception;

  VehicleEventDeleteFailsState(this.exception);
}

class VehicleEventDeleteFailsUnKnowState extends VehicleEventsState {
  final ErrorEntity exception;

  VehicleEventDeleteFailsUnKnowState(this.exception);
}

class VehicleEventsStoreProcessingState extends VehicleEventsState {}
