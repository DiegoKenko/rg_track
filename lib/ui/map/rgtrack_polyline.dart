import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rg_track/const/const_map.dart';

class RGTrackPolyline extends Polyline {
  RGTrackPolyline({required String id, List<LatLng> points = const []})
      : super(
          color: const Color.fromARGB(255, 6, 210, 13),
          patterns: [PatternItem.dash(5)],
          polylineId: PolylineId(id),
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          width: 5,
          points: points.isEmpty ? [defaultLatLong] : points,
        );
}
