import 'package:rg_track/model/vehicle.dart';

abstract class VehiclesFormState {
  final List<Vehicle> all;
  final List<Vehicle> selected;

  const VehiclesFormState(this.all, this.selected);
}

class VehiclesFormInitial extends VehiclesFormState {
  const VehiclesFormInitial(super.all, super.selected);

  const VehiclesFormInitial.empty() : super(const [], const []);
}

class VehiclesFormLoadingState extends VehiclesFormState {
  const VehiclesFormLoadingState(super.all, super.selected);

  const VehiclesFormLoadingState.empty() : super(const [], const []);
}

class VehiclesFormLoadedState extends VehiclesFormState {
  const VehiclesFormLoadedState(super.all, super.selected);

  const VehiclesFormLoadedState.empty() : super(const [], const []);
}
