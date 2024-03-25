import 'package:ms_map_utils/ms_map_utils.dart';

class Address {
  int? id;
  String? zipCode;
  String? state;
  String? country;
  String? city;
  String? neighborhood;
  String? street;
  String? number;
  String? complement;
  String? pointOfTheReference;
  double? lat;
  double? long;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.zipCode,
    this.state,
    this.country,
    this.city,
    this.neighborhood,
    this.street,
    this.number,
    this.complement,
    this.pointOfTheReference,
    this.lat,
    this.long,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] as int,
      zipCode: map['zip_code'] ?? '',
      state: map['state'] ?? '',
      country: map['country'] ?? '',
      city: map['city'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      street: map['street'] ?? '',
      number: map['number'] ?? '',
      complement: map['complement'] ?? '',
      pointOfTheReference: map['point_of_the_reference'] ?? '',
      lat: map['lat'] as double?,
      long: map['long'] as double?,
      createdAt: map.doIfContains<DateTime>(
        'created_at',
        doWork: (key, value) => DateTime.parse(value),
      ),
      updatedAt: map.doIfContains<DateTime>(
        'updated_at',
        doWork: (key, value) => DateTime.parse(value),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'zip_code': zipCode,
      'state': state,
      'country': country,
      'city': city,
      'neighborhood': neighborhood,
      'street': street,
      'number': number,
      'complement': complement,
      'point_of_the_reference': pointOfTheReference,
      'lat': lat,
      'long': long,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
