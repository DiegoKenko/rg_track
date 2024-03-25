class FlespiCalcCutPower {
  double? lat;
  double? lng;
  DateTime date;

  FlespiCalcCutPower(
      {required this.lat, required this.lng, required this.date});

  factory FlespiCalcCutPower.fromMap(Map<String, dynamic> map) {
    int timestamp = 0;
    if (map['date'] != null) {
      if (map['date'] > 0) {
        timestamp = double.tryParse(map['date'].toString())?.floor() ?? 0;
      }
    }
    return FlespiCalcCutPower(
        lat: map['lat'],
        lng: map['lng'],
        date: DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
  }
}
