class Points {
  double? tm;
  double? lat;
  double? lng;

  Points({this.tm, this.lat, this.lng});

  Points.fromJson(Map<String, dynamic> json) {
    tm = json['tm']?.toDouble();
    lat = json['lat']?.toDouble();
    lng = json['lng']?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tm'] = tm;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
