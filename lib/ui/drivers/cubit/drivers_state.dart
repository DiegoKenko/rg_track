import 'package:rg_track/model/driver.dart';
import 'package:rg_track/model/error_entity.dart';

abstract class DriversState {}

class DriversInitial extends DriversState {}

class ListDriverState extends DriversState {
  final List<Driver> drivers;

  ListDriverState(this.drivers);
}

class ListDriversError extends DriversState {
  final ErrorEntity exception;

  ListDriversError(this.exception);
}

class DriverStoredSuccessfulState extends DriversState {
  final Driver driver;

  DriverStoredSuccessfulState(this.driver);
}

class DriverLoadByIdState extends DriversState {
  final Driver driver;

  DriverLoadByIdState(this.driver);
}

class DriverShowFailsState extends DriversState {
  final ErrorEntity exception;

  DriverShowFailsState(this.exception);
}

class DriverShowFailsUnKnowState extends DriversState {
  final ErrorEntity exception;

  DriverShowFailsUnKnowState(this.exception);
}

class DriverStoredFailsState extends DriversState {
  final ErrorEntity exception;

  DriverStoredFailsState(this.exception);
}

class DriverStoredFailsUnKnowState extends DriversState {
  final ErrorEntity exception;

  DriverStoredFailsUnKnowState(this.exception);
}

class DeleteDriverByIdState extends DriversState {
  final Driver driver;

  DeleteDriverByIdState(this.driver);
}

class DriverDeleteFailsState extends DriversState {
  final ErrorEntity exception;

  DriverDeleteFailsState(this.exception);
}

class DriverDeleteFailsUnKnowState extends DriversState {
  final ErrorEntity exception;

  DriverDeleteFailsUnKnowState(this.exception);
}

class DriversStoreProcessingState extends DriversState {}
