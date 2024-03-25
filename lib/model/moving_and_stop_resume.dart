class ResumeMovingAndStop {
  final double totalDistance;
  final Duration totalTime;
  final Duration totalIdleTime;
  final int totalStops;
  final int totalMovements;

  ResumeMovingAndStop({
    required this.totalDistance,
    required this.totalTime,
    required this.totalIdleTime,
    required this.totalStops,
    required this.totalMovements,
  });

  Map<String, dynamic> toMap() {
    return {
      'total_distance': totalDistance,
      'total_time': totalTime.inSeconds,
      'total_idle_time': totalIdleTime.inSeconds,
      'total_stops': totalStops,
      'total_movements': totalMovements,
    };
  }

  factory ResumeMovingAndStop.fromMap(Map<String, dynamic> map) {
    return ResumeMovingAndStop(
      totalDistance: map['total_distance'] as double,
      totalTime: Duration(seconds: map['total_time'] ?? 0),
      totalIdleTime: Duration(seconds: map['total_idle_time'] ?? 0),
      totalStops: map['total_stops'] as int,
      totalMovements: map['total_movements'] as int,
    );
  }
}
