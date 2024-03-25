import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rg_track/const/const_map.dart';
import 'package:rg_track/const/images.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/model/vehicle_status.dart';
import 'package:rg_track/ui/map/rgtrack_polyline.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_controller_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_controller_state.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_moving_stop_cubit.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/cubit/map_moving_stop_state.dart';
import 'package:rg_track/ui/reports/moving_stop/widget/map/widget/tabbar_map_wide.dart';
import 'package:rg_track/ui/widget/alert_dialog_fails.dart';
import 'package:rg_track/ui/widget/elavated.dart';

class MovingStopMapWide extends StatefulWidget {
  const MovingStopMapWide({
    super.key,
    required this.vehicle,
  });
  final Vehicle vehicle;

  @override
  State<MovingStopMapWide> createState() => _MovingStopMapWideState();
}

class _MovingStopMapWideState extends State<MovingStopMapWide> {
  List<Polyline> _polylineList = [];
  List<Marker> _markerList = [];

  late GoogleMapController _controller;
  final MapType mapType = MapType.hybrid;
  final Color polylinesColor = primaryColor;
  BitmapDescriptor vehicleMarkerOn =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  BitmapDescriptor vehicleMarkerOff =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  BitmapDescriptor beginMarker =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  BitmapDescriptor endMarker =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);

  Future<bool> _getMarker() async {
    vehicleMarkerOn =
        BitmapDescriptor.fromBytes(await widget.vehicle.iconMarker(65, true));
    vehicleMarkerOff =
        BitmapDescriptor.fromBytes(await widget.vehicle.iconMarker(65, false));
    beginMarker =
        BitmapDescriptor.fromBytes(await getBytesFromAsset(iconMapBegin, 40));
    endMarker =
        BitmapDescriptor.fromBytes(await getBytesFromAsset(iconMapEnd, 40));
    return true;
  }

  void _moveCameraPosition(LatLng position) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: position,
        zoom: 16,
      ),
    ));
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
          return BlocConsumer<MapMovingStopCubit, MapMovingStopState>(
            listener: (context, state) {
              if (state is MapMovingStopSuccessState) {
                if (state.position != null) {
                  _moveCameraPosition(state.position!);
                }
              }
            },
            bloc: context.read<MapMovingStopCubit>()..init(widget.vehicle),
            builder: (context, state) {
              Widget bottomWidget = TabBarMapWide(
                vehicle: Vehicle.empty(),
                vehicleTrails: const [],
                vehicleStatus: VehicleStatus.empty(),
              );
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
                      infoWindow: InfoWindow(title: state.vehicle.licensePlate),
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
                    infoWindow: const InfoWindow(
                      title: 'Início',
                    ),
                  ));
                  _markerList.add(Marker(
                    icon: endMarker,
                    markerId: MarkerId('${state.vehicle.simpleID}end'),
                    position: LatLng(
                        state.vehicleTrailSelected.trails.last.latitude,
                        state.vehicleTrailSelected.trails.last.longitude),
                    infoWindow: const InfoWindow(
                      title: 'Fim',
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

                return Column(
                  children: [
                    Expanded(
                      child: Elevated(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BlocListener<MapControllerCubit,
                              MapControllerState>(
                            listener: (BuildContext context,
                                MapControllerState state) {
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
                                    _polylineList.first.points.first.longitude),
                                zoom: 13,
                              ),
                              markers: Set.from(_markerList),
                              polylines: Set.from(_polylineList),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TabBarMapWide(
                      vehicle: state.vehicle,
                      vehicleTrails: state.vehicleTrails,
                      vehicleStatus: state.vehicleStatus,
                    )
                  ],
                );
              }
              if (state is MapMovingStopLoadingState) {
                bottomWidget = Elevated(
                    child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  color: Colors.white,
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    child: const CircularProgressIndicator(),
                  ),
                ));
              }
              if (state is MapMovingStopErrorState) {
                bottomWidget = AlertDialogFails(
                  exception: state.error,
                  actionEnable: false,
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: Elevated(
                      child: Opacity(
                        opacity: 0.3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: GoogleMap(
                            onMapCreated: (GoogleMapController controller) {
                              _controller = controller;
                            },
                            indoorViewEnabled: false,
                            compassEnabled: true,
                            myLocationEnabled: false,
                            mapType: mapType,
                            initialCameraPosition: CameraPosition(
                              target: defaultLatLong,
                              zoom: 13,
                            ),
                            markers: const <Marker>{},
                            polylines: const <Polyline>{},
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  bottomWidget
                ],
              );
            },
          );
        });
  }
}
