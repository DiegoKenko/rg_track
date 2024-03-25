import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/widget/vehicles_form/vehicles_form_state.dart';

class VehiclesFormCubit extends Cubit<VehiclesFormState> {
  VehiclesFormCubit() : super(const VehiclesFormInitial.empty());

  Future<List<Vehicle>> getVehicles(Customer? customer) async {
    emit(const VehiclesFormLoadingState.empty());

    return [];
  }
}
