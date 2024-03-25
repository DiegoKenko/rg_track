import 'package:rg_track/model/map_points.dart';

class FlespiTrip {
  double? begin;
  double? end;
  double? duration;
  double? maxSpeed;
  double? distance;
  List<Points> points = [];
  String? route;
  double? avgSpeed;

  FlespiTrip(
      {this.begin,
      this.end,
      this.duration,
      this.maxSpeed,
      this.distance,
      this.points = const [],
      this.route,
      this.avgSpeed});

  FlespiTrip.fromMap(Map<String, dynamic> json) {
    begin = json['begin']?.toDouble();
    end = json['end']?.toDouble();
    duration = json['duration']?.toDouble();

    maxSpeed = json['max.speed']?.toDouble();
    distance = json['distance']?.toDouble();
    points = <Points>[];
    if (json['points'] != null) {
      if (json['points'] is List) {
        for (var v in (json['points'] as List)) {
          points.add(Points.fromJson(v));
        }
      }
    }
    route = json['route'];
    avgSpeed = json['avg.speed']?.toDouble();
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['begin'] = begin;
    data['end'] = end;
    data['duration'] = duration;
    data['max.speed'] = maxSpeed;
    data['distance'] = distance;
    data['points'] = points.map((v) => v.toJson()).toList();
    data['route'] = route;
    data['avg.speed'] = avgSpeed;
    return data;
  }
}
