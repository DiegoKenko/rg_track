import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_controller_state.dart';

class MapControllerCubit extends Cubit<MapControllerState> {
  MapControllerCubit() : super(MapControllerInitialState());

  animate(double lat, double lng) {
    emit(MapControllerAnimateState(LatLng(lat, lng)));
  }
}
