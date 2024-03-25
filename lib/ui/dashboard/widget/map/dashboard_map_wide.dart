import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rg_track/const/const_map.dart';
import 'package:rg_track/const/images.dart';
import 'package:rg_track/const/theme.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/ui/widget/elavated.dart';

class DashboardMapWide extends StatefulWidget {
  const DashboardMapWide({
    super.key,
    required this.completer,
    this.event,
  });
  final Event? event;
  final Completer<GoogleMapController> completer;

  @override
  State<DashboardMapWide> createState() => _DashboardMapWideState();
}

class _DashboardMapWideState extends State<DashboardMapWide> {
  final MapType mapType = MapType.hybrid;
  final Color polylinesColor = primaryColor;
  BitmapDescriptor eventMarkerIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen);
  List<Marker> markers = [];
  Future<bool> _getMarker() async {
    eventMarkerIcon =
        BitmapDescriptor.fromBytes(await getBytesFromAsset(iconMapBegin, 60));
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
          if (widget.event != null) {
            markers = [
              Marker(
                markerId: MarkerId(
                  eventMarkerIcon.hashCode.toString(),
                ),
                infoWindow: InfoWindow(
                  title: widget.event?.value.toString(),
                  snippet: widget.event?.eventDescription,
                ),
                icon: eventMarkerIcon,
                position: LatLng(widget.event!.lat ?? defaultLatLong.latitude,
                    widget.event!.lng ?? defaultLatLong.longitude),
              )
            ];
          }

          return Elevated(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  widget.completer.complete(controller);
                },
                indoorViewEnabled: false,
                compassEnabled: true,
                myLocationEnabled: false,
                mapType: mapType,
                initialCameraPosition: CameraPosition(
                  target: LatLng(widget.event?.lat ?? defaultLatLong.latitude,
                      widget.event?.lng ?? defaultLatLong.longitude),
                  zoom: 16,
                ),
                markers: Set.from(markers),
                polylines: Set.from([]),
              ),
            ),
          );
        });
  }
}
