import 'package:rg_track/model/vehicle.dart';
import 'package:rg_track/service/flespi/device/calculator/cut_power/flespi_calc_cut_power.dart';
import 'package:rg_track/service/flespi/device/calculator/max_speed/flespi_calc_max_speed.dart';

class Event {
  final int id;
  final int? vehicleId;
  final Vehicle? vehicle;
  final DateTime? date;
  final String? value;
  final String? eventDescription;
  final double? lat;
  final double? lng;
  final String? address;

  Event({
    required this.id,
    this.vehicleId,
    this.vehicle,
    this.date,
    this.value,
    this.lat,
    this.lng,
    this.eventDescription,
    this.address,
  });

  Event copyWith({
    int? id,
    int? vehicleId,
    Vehicle? vehicle,
    DateTime? date,
    String? value,
    double? lat,
    double? lng,
    String? eventDescription,
  }) {
    return Event(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      vehicle: vehicle ?? this.vehicle,
      date: date ?? this.date,
      value: value ?? this.value,
      eventDescription: eventDescription ?? this.eventDescription,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'vehicleId': vehicleId,
      'vehicle': vehicle?.toMap(),
      'date': date?.millisecondsSinceEpoch,
      'value': value,
      'eventDescription': eventDescription,
      'lat': lat,
      'lng': lng,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'],
      vehicleId: map['vehicleId'],
      vehicle: Vehicle.fromMap(map['vehicle']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      value: map['value'],
      eventDescription: map['eventDescription'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  factory Event.fromFlespiCalcMaxSpeed(
      Vehicle vehicle, FlespiCalcMaxSpeed flespiCalcMaxSpeed) {
    return Event(
      id: flespiCalcMaxSpeed.hashCode,
      vehicle: vehicle,
      date: flespiCalcMaxSpeed.dateTime,
      lat: flespiCalcMaxSpeed.lat,
      lng: flespiCalcMaxSpeed.lng,
      eventDescription: 'Velocidade máxima excedida',
      value: flespiCalcMaxSpeed.speed.toString() + ' km/h',
    );
  }
  factory Event.fromFlespiCalcCutPower(
      Vehicle vehicle, FlespiCalcCutPower flespiCalcCutPower) {
    return Event(
      id: flespiCalcCutPower.hashCode,
      vehicle: vehicle,
      date: flespiCalcCutPower.date,
      lat: flespiCalcCutPower.lat,
      lng: flespiCalcCutPower.lng,
      eventDescription: 'Rastreador desligado',
      value: '',
    );
  }
}
