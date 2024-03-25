import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rg_track/const/const_map.dart';
import 'package:rg_track/const/images.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_controller_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_controller_state.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_moving_stop_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_moving_stop_state.dart';
import 'package:rg_track/ui/map/rgtrack_polyline.dart';
import 'package:rg_track/ui/widget/alert_dialog_fails.dart';

class MovingStopMapMobile extends StatefulWidget {
  const MovingStopMapMobile({
    super.key,
    required this.vehicle,
  });
  final Vehicle vehicle;

  @override
  State<MovingStopMapMobile> createState() => _MovingStopMapMobileState();
}

class _MovingStopMapMobileState extends State<MovingStopMapMobile> {
  List<Polyline> _polylineList = [];
  List<Marker> _markerList = [];

  late GoogleMapController _controller;
  final MapType mapType = MapType.hybrid;
  BitmapDescriptor vehicleMarkerOff =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  BitmapDescriptor vehicleMarkerOn =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  BitmapDescriptor beginMarker =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  BitmapDescriptor endMarker =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);

  void _moveCameraPosition(LatLng position) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: position,
        zoom: 16,
      ),
    ));
  }

  Future<bool> _getMarker() async {
    vehicleMarkerOff =
        BitmapDescriptor.fromBytes(await widget.vehicle.iconMarker(120, false));
    vehicleMarkerOn =
        BitmapDescriptor.fromBytes(await widget.vehicle.iconMarker(120, true));

    beginMarker =
        BitmapDescriptor.fromBytes(await getBytesFromAsset(iconMapBegin, 120));
    endMarker =
        BitmapDescriptor.fromBytes(await getBytesFromAsset(iconMapEnd, 120));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getMarker(),
        builder: (context, snap) {
          if (snap.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: BlocConsumer<MapMovingStopCubit, MapMovingStopState>(
              listener: (context, state) {
                if (state is MapMovingStopSuccessState) {
                  if (state.position != null) {
                    _moveCameraPosition(state.position!);
                  }
                }
              },
              bloc: context.read<MapMovingStopCubit>()..init(widget.vehicle),
              builder: (context, state) {
                if (state is MapMovingStopSuccessState) {
                  BitmapDescriptor vehicleMarker = state.vehicleStatus.isActive
                      ? vehicleMarkerOn
                      : vehicleMarkerOff;

                  _polylineList = [];
                  _markerList = [];
                  if (state.vehicleStatus.positionLatitude != null ||
                      state.vehicleStatus.positionLongitude != null) {
                    _markerList.add(
                      Marker(
                        markerId: MarkerId(state.vehicle.simpleID),
                        icon: vehicleMarker,
                        position: LatLng(state.vehicleStatus.positionLatitude!,
                            state.vehicleStatus.positionLongitude!),
                        infoWindow:
                            InfoWindow(title: state.vehicle.licensePlate),
                      ),
                    );
                  }
                  if (state.vehicleTrailSelected.trails.isNotEmpty) {
                    _markerList.add(Marker(
                      icon: beginMarker,
                      markerId: MarkerId('${state.vehicle.simpleID}start'),
                      position: LatLng(
                          state.vehicleTrailSelected.trails.first.latitude,
                          state.vehicleTrailSelected.trails.first.longitude),
                      infoWindow: InfoWindow(
                        title: 'Início',
                        snippet: state.vehicle.simpleID,
                      ),
                    ));
                    _markerList.add(Marker(
                      icon: endMarker,
                      markerId: MarkerId('${state.vehicle.simpleID}end'),
                      position: LatLng(
                          state.vehicleTrailSelected.trails.last.latitude,
                          state.vehicleTrailSelected.trails.last.longitude),
                      infoWindow: InfoWindow(
                        title: 'Fim',
                        snippet: state.vehicle.simpleID,
                      ),
                    ));
                    _polylineList.add(
                      RGTrackPolyline(
                        id: state.vehicle.simpleID,
                        points: state.vehicleTrailSelected.trails,
                      ),
                    );
                  } else {
                    _polylineList
                        .add(RGTrackPolyline(id: state.vehicle.simpleID));
                  }

                  return BlocListener<MapControllerCubit, MapControllerState>(
                    listener: (BuildContext context, MapControllerState state) {
                      if (state is MapControllerAnimateState) {
                        _moveCameraPosition(state.position);
                      }
                    },
                    child: GoogleMap(
                      onMapCreated: (GoogleMapController controller) {
                        _controller = controller;
                      },
                      indoorViewEnabled: false,
                      compassEnabled: true,
                      myLocationEnabled: false,
                      mapType: mapType,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            _polylineList.first.points.first.latitude,
                            _polylineList.first.points.last.longitude),
                        zoom: 12,
                      ),
                      markers: Set.from(_markerList),
                      polylines: Set.from(_polylineList),
                    ),
                  );
                }
                if (state is MapMovingStopErrorState) {
                  return Center(
                    child: AlertDialogFails(
                      exception: state.error,
                      actionEnable: false,
                    ),
                  );
                }
                return Opacity(
                  opacity: 0.3,
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _controller = controller;
                    },
                    myLocationEnabled: false,
                    mapType: mapType,
                    initialCameraPosition: CameraPosition(
                      target: defaultLatLong,
                      zoom: 12,
                    ),
                    markers: const <Marker>{},
                    polylines: const <Polyline>{},
                  ),
                );
              },
            ),
          );
        });
  }
}
