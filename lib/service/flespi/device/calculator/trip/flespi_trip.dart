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
    ;
    duration = json['duration']?.toDouble();

    maxSpeed = json['max.speed']?.toDouble();
    distance = json['distance']?.toDouble();
    points = <Points>[];
    if (json['points'] != null) {
      if (json['points'] is List) {
        (json['points'] as List).forEach((v) {
          points.add(new Points.fromJson(v));
        });
      }
    }
    route = json['route'];
    avgSpeed = json['avg.speed']?.toDouble();
    ;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['begin'] = this.begin;
    data['end'] = this.end;
    data['duration'] = this.duration;
    data['max.speed'] = this.maxSpeed;
    data['distance'] = this.distance;
    data['points'] = this.points.map((v) => v.toJson()).toList();
    data['route'] = this.route;
    data['avg.speed'] = this.avgSpeed;
    return data;
  }
}
