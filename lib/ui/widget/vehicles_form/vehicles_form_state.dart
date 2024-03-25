import 'package:rg_track/model/vehicle.dart';

abstract class VehiclesFormState {
  final List<Vehicle> all;
  final List<Vehicle> selected;

  const VehiclesFormState(this.all, this.selected);
}

class VehiclesFormInitial extends VehiclesFormState {
  const VehiclesFormInitial(List<Vehicle> all, List<Vehicle> selected)
      : super(all, selected);

  const VehiclesFormInitial.empty() : super(const [], const []);
}

class VehiclesFormLoadingState extends VehiclesFormState {
  const VehiclesFormLoadingState(List<Vehicle> all, List<Vehicle> selected)
      : super(all, selected);

  const VehiclesFormLoadingState.empty() : super(const [], const []);
}

class VehiclesFormLoadedState extends VehiclesFormState {
  const VehiclesFormLoadedState(List<Vehicle> all, List<Vehicle> selected)
      : super(all, selected);

  const VehiclesFormLoadedState.empty() : super(const [], const []);
}
