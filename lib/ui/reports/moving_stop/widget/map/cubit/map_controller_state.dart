import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapControllerState {}

class MapControllerInitialState extends MapControllerState {}

class MapControllerAnimateState extends MapControllerState {
  MapControllerAnimateState(this.position);
  final LatLng position;
}
