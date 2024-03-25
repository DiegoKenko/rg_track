import 'package:rg_track/model/driver.dart';
import 'package:rg_track/model/moving_and_stop_node.dart';
import 'package:rg_track/model/moving_and_stop_resume.dart';
import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/utils/dynamic_util.dart';

class MovingAndStop {
  final ResumeMovingAndStop resume;
  final List<NodeMovingAndStop> nodes;
  final DateTime start;
  final DateTime end;
  final Vehicle vehicle;
  final Driver? driver;

  MovingAndStop({
    required this.resume,
    required this.nodes,
    required this.start,
    required this.end,
    required this.vehicle,
    this.driver,
  });

  Map<String, dynamic> toMap() {
    return {
      'resume': resume.toMap(),
      'nodes': nodes.map((NodeMovingAndStop e) => e.toMap()).toList(),
      'start': start,
      'end': end,
      'vehicle': vehicle.toMap(),
      'driver': driver?.toMap(),
    };
  }

  factory MovingAndStop.fromMap(Map<String, dynamic> map) {
    return MovingAndStop(
      resume: ResumeMovingAndStop.fromMap(map['resume']),
      nodes: (map['nodes'] as List)
          .map((e) => NodeMovingAndStop.fromMap(e))
          .toList(),
      start: toDateTime(map['start']),
      end: toDateTime(map['end']),
      vehicle: Vehicle.fromMap(map['vehicle']),
      driver: map['driver'] != null ? Driver.fromMap(map['driver']) : null,
    );
  }
}
