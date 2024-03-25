import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rg_track/service/flespi/device/calculator/trip/flespi_trip.dart';
import 'package:rg_track/service/flespi/device/message/flespi_channel_message.dart';
import 'package:rg_track/utils/date_utils.dart';
import 'package:rg_track/utils/duration.dart';

class VehicleTrail {
  List<LatLng> trails = [];
  double? startDateTimestamp;
  double? endDateTimestamp;
  double? averageSpeed;
  double? maxSpeed;
  double? distanceKm;
  double? duration;

  DateTime? get startDate => startDateTimestamp == null
      ? null
      : DateTime.fromMillisecondsSinceEpoch(startDateTimestamp!.toInt() * 1000);
  DateTime? get endDate => endDateTimestamp == null
      ? null
      : DateTime.fromMillisecondsSinceEpoch(endDateTimestamp!.toInt() * 1000);

  String get startDateFormatted =>
      startDate == null ? '-' : startDate!.formatDataDmyHm();
  String get endDateFormatted =>
      endDate == null ? '-' : endDate!.formatDataDmyHm();
  String get durationFormatted =>
      duration == null ? '-' : Duration(seconds: duration!.toInt()).format();
  String get distanceFormatted =>
      distanceKm == null ? '-' : '${(distanceKm!).toStringAsFixed(2)} km';
  String get averageSpeedFormatted =>
      averageSpeed == null ? '-' : '${(averageSpeed!).toStringAsFixed(2)} km/h';
  String get maxSpeedFormatted =>
      maxSpeed == null ? '-' : '${(maxSpeed!).toStringAsFixed(2)} km/h';

  VehicleTrail({
    this.trails = const [],
    this.startDateTimestamp,
    this.endDateTimestamp,
    this.averageSpeed,
    this.maxSpeed,
    this.distanceKm,
    this.duration,
  });

  factory VehicleTrail.empty() {
    return VehicleTrail(trails: []);
  }

  factory VehicleTrail.fromFlespiCalcTrip(FlespiTrip trip) {
    List<LatLng> trails = [];
    for (var element in trip.points) {
      if (element.lat != null && element.lng != null) {
        trails.add(LatLng(element.lat!, element.lng!));
      }
    }

    return VehicleTrail(
      trails: trails,
      averageSpeed: trip.avgSpeed,
      startDateTimestamp: trip.begin,
      endDateTimestamp: trip.end,
      duration: trip.duration,
      maxSpeed: trip.maxSpeed,
      distanceKm: trip.distance,
    );
  }

  factory VehicleTrail.fromFlespiChannelMessage(
      List<FlespiChannelMessage> messages) {
    VehicleTrail ret = VehicleTrail.empty();
    messages.forEach((element) {
      double lastLongitude = 0;
      double lastLatitude = 0;
      if (!(lastLatitude == element.positionLatitude &&
          lastLongitude == element.positionLongitude)) {
        if (element.positionLatitude != null &&
            element.positionLongitude != null) {
          ret.trails.add(
              LatLng(element.positionLatitude!, element.positionLongitude!));
          lastLongitude = element.positionLongitude!;
          lastLatitude = element.positionLatitude!;
        }
      }
    });

    return ret;
  }
}
