class FlespiCalcMaxSpeed {
  int? begin;
  int? end;
  int? duration;
  double? speed;
  double? lat;
  double? lng;
  int? time;

  DateTime? get dateTime =>
      time == null ? null : DateTime.fromMillisecondsSinceEpoch(time! * 1000);

  FlespiCalcMaxSpeed(
      {this.begin,
      this.end,
      this.duration,
      this.lat,
      this.lng,
      this.speed,
      this.time});

  FlespiCalcMaxSpeed.fromMap(Map<String, dynamic> json) {
    begin = json['begin'];
    end = json['end'];
    duration = json['duration'];
    speed = json['speed']?.toDouble();
    lat = json['lat'];
    lng = json['lng'];
    time = json['time'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['begin'] = this.begin;
    data['end'] = this.end;
    data['duration'] = this.duration;
    data['speed'] = this.speed;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['time'] = this.time;
    return data;
  }
}
