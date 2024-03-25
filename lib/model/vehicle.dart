import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:ms_list_utils/ms_list_utils.dart';
import 'package:ms_map_utils/ms_map_utils.dart';
import 'package:rg_track/const/colors_rgt.dart';
import 'package:rg_track/const/enum/enum_max_speed.dart';
import 'package:rg_track/const/images.dart';
import 'package:rg_track/model/customer_vehicle.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/model/event.dart';
import 'package:rg_track/model/vehicle_kind.dart';

import 'package:rg_track/model/customer.dart';

class Vehicle {
  String? id;
  bool? status;
  DateTime? installationDate;
  VehicleKind? vehicleKind;
  String? licensePlate;
  String? color;
  String? renavam;
  int? mileage;
  String? manufacturer;
  String? model;
  String? year;
  String? chassi;
  String? uf;
  String? securityQuestion;
  String? securityAnswer;
  String? observations;
  String? fleet;
  String? specification;
  int? monthlyFeeCents;
  int? kindOfFuelId;
  bool? speeding;
  bool? timeStill;
  bool? withoutTransmission;
  bool? blockIngnition;
  String? startsWorkAt;
  String? endsWorkAt;
  bool? fineConsultation;
  DateTime? updatedAt;
  DateTime? createdAt;
  final List<Device> _devices = [];
  List<CustomerVehicle> customerVehicle = [];
  Customer? customer;
  String? customerKind;
  List<Event> events;
  String userId;
  String? deviceMainId;
  String? deviceRedundancyId;
  EnumMaxSpeed? maxSpeed;

  Device? get mainDevice {
    if (_devices.isNotEmpty) {
      return _devices.first;
    }
    return null;
  }

  String get description {
    return ('${manufacturer ?? ''} ${model ?? ''} ${year ?? ''} - ${licensePlate ?? ''}')
        .trim();
  }

  Device? get redundancyDevice {
    if (_devices.length > 1) {
      return _devices[1];
    }
    return null;
  }

  String get simpleID => id?.substring(0, 6) ?? '';

  Color? get iconColor {
    /* if (events.isEmpty || events.first.hasAlert) {
      return ColorsVehicle.iconAlert;
    }
    if (events.first.isIdle) {
      return ColorsVehicle.iconIdle;
    }
    if (events.first.isDriving) {
      return ColorsVehicle.iconDriving;
    } */

    return ColorsVehicle.iconParking;
  }

  IconData get icon {
    switch (vehicleKind) {
      case VehicleKind.carro:
        return MdiIcons.car;
      case VehicleKind.moto:
        return MdiIcons.motorbike;
      case VehicleKind.caminhao:
        return MdiIcons.truck;
      default:
        return MdiIcons.carBack;
    }
  }

  String get statusDescription => status ?? false ? 'Ativo' : 'Inativo';

  Future<Uint8List> iconMarker(int size, bool active) async {
    switch (vehicleKind) {
      case VehicleKind.carro:
        String icon = active ? iconMapMarkerCarOn : iconMapMarkerCarOff;
        return await getBytesFromAsset(icon, size);

      case VehicleKind.moto:
        String icon =
            active ? iconMapMarkerMotorBikeOn : iconMapMarkerMotorBikeOff;
        return await getBytesFromAsset(icon, size);
      default:
        return await getBytesFromAsset(iconMapMarkerCar, size);
    }
  }

  /*   return const {
          1: MdiIcons.car,
          2: MdiIcons.truckFlatbed,
          3: MdiIcons.truckFlatbed,
          4: MdiIcons.truck,
          5: MdiIcons.carPickup,
          6: MdiIcons.bus,
          7: MdiIcons.motorbike,
          8: MdiIcons.bus,
          9: MdiIcons.truckTrailer,
          10: MdiIcons.truckTrailer,
          11: MdiIcons.bicycleCargo,
          12: MdiIcons.vanUtility,
          13: MdiIcons.vanPassenger,
          14: MdiIcons.horseHuman,
          15: MdiIcons.airplane,
          16: MdiIcons.ferry,
          17: MdiIcons.bicycle,
          18: MdiIcons.train,
          19: MdiIcons.box,
          20: MdiIcons.cart,
          21: MdiIcons.bicycleCargo,
          22: MdiIcons.caravan,
          23: MdiIcons.engine,
          24: MdiIcons.moped,
          25: MdiIcons.crosshairsQuestion,
          26: MdiIcons.helicopter,
          27: Icons.water,
          28: MdiIcons.bagPersonal,
          29: MdiIcons.moped,
          30: MdiIcons.crosshairsQuestion,
          31: MdiIcons.crosshairsQuestion,
          32: MdiIcons.account,
          33: MdiIcons.at,
          34: MdiIcons.carSide,
          35: MdiIcons.tractor,
          36: MdiIcons.tractorVariant,
          37: MdiIcons.tractorVariant, */

  bool get devicesLoaded {
    if (_devices.isEmpty) {
      if ((deviceMainId?.isNotEmpty ?? false) ||
          (deviceRedundancyId?.isNotEmpty ?? false)) {
        return false;
      }
    }
    return true;
  }

  bool get isEmpty {
    return userId.isEmpty;
  }

  set newDeviceMain(Device device) {
    if (_devices.isEmpty) {
      _devices.add(device);
    } else {
      _devices[0] = device;
    }
  }

  set newDeviceRedundancy(Device device) {
    if (_devices.length < 2) {
      _devices.add(device);
    } else {
      _devices[1] = device;
    }
  }

  Vehicle({
    required this.userId,
    this.chassi,
    this.color,
    this.createdAt,
    this.customer,
    this.customerKind = 'user',
    this.deviceMainId,
    this.deviceRedundancyId,
    this.endsWorkAt,
    this.events = const [],
    this.fineConsultation = false,
    this.fleet,
    this.id,
    this.installationDate,
    this.kindOfFuelId,
    this.licensePlate,
    this.maxSpeed,
    this.manufacturer,
    this.mileage,
    this.model,
    this.monthlyFeeCents,
    this.observations,
    this.renavam,
    this.securityAnswer,
    this.securityQuestion,
    this.specification,
    this.speeding = false,
    this.startsWorkAt,
    this.status = true,
    this.timeStill = false,
    this.uf,
    this.updatedAt,
    this.vehicleKind,
    this.withoutTransmission = false,
    this.blockIngnition = false,
    this.year,
  });

  Vehicle copyWith({
    String? id,
    bool? status,
    DateTime? installationDate,
    int? vehicleKindId,
    String? licensePlate,
    String? color,
    String? renavam,
    int? mileage,
    String? manufacturer,
    String? model,
    String? year,
    String? chassi,
    String? uf,
    String? securityQuestion,
    String? securityAnswer,
    String? observations,
    String? fleet,
    String? specification,
    int? monthlyFeeCents,
    List<Device>? devices,
    int? kindOfFuelId,
    bool? speeding,
    bool? timeStill,
    bool? withoutTransmission,
    bool? blockIngnition,
    String? startsWorkAt,
    String? endsWorkAt,
    bool? fineConsultation,
    DateTime? updatedAt,
    DateTime? createdAt,
    List<CustomerVehicle>? customerVehicle,
    Customer? customer,
    String? customerKind,
    VehicleKind? vehicleKind,
    List<Event>? events,
    String? userId,
    String? deviceMainId,
    String? deviceRedundancyId,
    EnumMaxSpeed? maxSpeed,
  }) {
    return Vehicle(
      blockIngnition: blockIngnition ?? this.blockIngnition,
      chassi: chassi ?? this.chassi,
      color: color ?? this.color,
      createdAt: createdAt ?? this.createdAt,
      customer: customer ?? this.customer,
      customerKind: customerKind ?? this.customerKind,
      endsWorkAt: endsWorkAt ?? this.endsWorkAt,
      events: events ?? this.events,
      fineConsultation: fineConsultation ?? this.fineConsultation,
      fleet: fleet ?? this.fleet,
      id: id ?? this.id,
      installationDate: installationDate ?? this.installationDate,
      kindOfFuelId: kindOfFuelId ?? this.kindOfFuelId,
      licensePlate: licensePlate ?? this.licensePlate,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      manufacturer: manufacturer ?? this.manufacturer,
      mileage: mileage ?? this.mileage,
      model: model ?? this.model,
      monthlyFeeCents: monthlyFeeCents ?? this.monthlyFeeCents,
      observations: observations ?? this.observations,
      renavam: renavam ?? this.renavam,
      securityAnswer: securityAnswer ?? this.securityAnswer,
      securityQuestion: securityQuestion ?? this.securityQuestion,
      specification: specification ?? this.specification,
      speeding: speeding ?? this.speeding,
      startsWorkAt: startsWorkAt ?? this.startsWorkAt,
      status: status ?? this.status,
      timeStill: timeStill ?? this.timeStill,
      uf: uf ?? this.uf,
      updatedAt: updatedAt ?? this.updatedAt,
      userId: userId ?? this.userId,
      vehicleKind: vehicleKind ?? this.vehicleKind,
      withoutTransmission: withoutTransmission ?? this.withoutTransmission,
      year: year ?? this.year,
    );
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      blockIngnition: map['block_ingnition'] as bool?,
      chassi: map['chassi'],
      color: map['color'],
      createdAt: DateTime.tryParse(map['created_at'] ?? ''),
      customer: map['customer'] == null
          ? null
          : Customer.fromMap(map['customer'] ?? {}),
      userId: map['user_id'],
      customerKind: map['customer_kind'],
      deviceMainId: map['device_main_id'],
      deviceRedundancyId: map['device_redundancy_id'],
      endsWorkAt: map['ends_work_at'],
      fineConsultation: map['fine_consultation'] ?? false,
      fleet: map['fleet'],
      id: map['id'] as String?,
      installationDate: DateTime.tryParse(map['installation_date'] ?? ''),
      kindOfFuelId: map['kind_of_fuel_id'] as int?,
      licensePlate: map['license_plate'],
      maxSpeed: EnumMaxSpeed.values
          .firstWhereOrNull((element) => element.speed == map['max_speed']),
      manufacturer: map['manufacturer'],
      mileage: map['mileage'] as int?,
      model: map['model'],
      monthlyFeeCents: map['monthly_fee_cents'] as int?,
      observations: map['observations'],
      renavam: map['renavam'],
      securityAnswer: map['security_answer'],
      securityQuestion: map['security_question'],
      specification: map['specification'],
      speeding: map['speeding'] as bool?,
      startsWorkAt: map['starts_work_at'],
      status: map['status'],
      timeStill: map['time_still'] as bool?,
      uf: map['uf'],
      updatedAt: DateTime.tryParse(map['updated_at'] ?? ''),
      vehicleKind: map['vehicle_kind'] != null
          ? VehicleKind.values.firstWhere(
              (element) => element.description == map['vehicle_kind'],
              orElse: () => VehicleKind.carro)
          : null,
      withoutTransmission: map['without_transmission'] as bool?,
      year: map['year'],
    );
  }

  factory Vehicle.empty() {
    return Vehicle(userId: '');
  }

  Map<String, dynamic> toMap() {
    return compact({
      'block_ingnition': blockIngnition,
      'chassi': chassi,
      'color': color,
      'created_at': createdAt?.toIso8601String(),
      'customer': customer?.toMap(),
      'customer_kind': customerKind,
      'device_main_id': mainDevice?.id ?? '',
      'device_redundancy_id': redundancyDevice?.id ?? '',
      'ends_work_at': endsWorkAt,
      'fine_consultation': fineConsultation,
      'fleet': fleet,
      'id': id,
      'installation_date': installationDate?.toIso8601String(),
      'kind_of_fuel_id': kindOfFuelId,
      'license_plate': licensePlate,
      'manufacturer': manufacturer,
      'max_speed': maxSpeed?.speed,
      'mileage': mileage,
      'model': model,
      'monthly_fee_cents': monthlyFeeCents,
      'observations': observations,
      'renavam': renavam,
      'security_answer': securityAnswer,
      'security_question': securityQuestion,
      'specification': specification,
      'speeding': speeding,
      'starts_work_at': startsWorkAt,
      'status': status,
      'time_still': timeStill,
      'uf': uf,
      'user_id': userId,
      'updated_at': updatedAt?.toIso8601String(),
      'vehicle_kind': vehicleKind != null ? vehicleKind!.description : null,
      'without_transmission': withoutTransmission,
      'year': year,
    });
  }
}
