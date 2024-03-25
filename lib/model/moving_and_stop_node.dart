import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rg_track/model/driver.dart';
import 'package:rg_track/utils/dynamic_util.dart';

class NodeMovingAndStop {
  final LatLng startLocation;
  final DateTime start;
  final LatLng endLocation;
  final DateTime end;
  final Duration duration;
  final double distanceMeters;
  final bool isDriving;
  final Driver? driver;

  NodeMovingAndStop({
    required this.startLocation,
    required this.start,
    required this.endLocation,
    required this.end,
    required this.duration,
    required this.distanceMeters,
    required this.isDriving,
    this.driver,
  });

  String get distanceString => distanceMeters.toStringAsFixed(2);

  String get speedString =>
      (distanceMeters / duration.inSeconds * 3.6).toStringAsFixed(2);

  String get startString => start.toIso8601String();

  String get endString => end.toIso8601String();

  Map<String, dynamic> toMap() {
    return {
      'start_location': startLocation,
      'start': start,
      'end_location': endLocation,
      'end': end,
      'duration_seconds': duration.inSeconds,
      'distance_meters': distanceMeters,
      'is_driving': isDriving,
      'driver': driver?.toMap(),
    };
  }

  factory NodeMovingAndStop.fromMap(Map<String, dynamic> map) {
    return NodeMovingAndStop(
      startLocation: LatLng(map['start_location'][0], map['start_location'][1]),
      start: toDateTime(map['start']),
      endLocation: LatLng(map['end_location'][0], map['end_location'][1]),
      end: toDateTime(map['end']),
      duration: Duration(seconds: toInt(map['duration_seconds'])),
      distanceMeters: map['distance_meters'] as double,
      isDriving: map['is_driving'] as bool,
      driver: map['driver'] as Driver,
    );
  }

  NodeMovingAndStop copyWith({
    LatLng? startLocation,
    DateTime? start,
    LatLng? endLocation,
    DateTime? end,
    Duration? duration,
    double? distanceMeters,
    bool? isDriving,
    Driver? driver,
  }) {
    return NodeMovingAndStop(
      startLocation: startLocation ?? this.startLocation,
      start: start ?? this.start,
      endLocation: endLocation ?? this.endLocation,
      end: end ?? this.end,
      duration: duration ?? this.duration,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      isDriving: isDriving ?? this.isDriving,
      driver: driver ?? this.driver,
    );
  }
}
