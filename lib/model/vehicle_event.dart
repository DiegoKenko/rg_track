import 'package:ms_map_utils/ms_map_utils.dart';

class VehicleEvent {
  int? id;
  String? name;
  String? description;
  bool? alertCentral;
  bool? active;
  String? message;
  int? maxTime;
  int? customerId;
  DateTime? updatedAt;
  DateTime? createdAt;

  VehicleEvent({
    this.id,
    this.name,
    this.description,
    this.alertCentral,
    this.active = true,
    this.message,
    this.maxTime,
    this.customerId,
    this.updatedAt,
    this.createdAt,
  });

  factory VehicleEvent.fromMap(Map<String, dynamic> map) {
    return VehicleEvent(
      id: map['id'] as int?,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      alertCentral: map['alert_central'] as bool?,
      active: map['active'] as bool?,
      message: map['message'] ?? '',
      maxTime: map['max_time'] as int?,
      customerId: map['customer_id'] as int?,
      updatedAt: DateTime.parse(map["updated_at"]),
      createdAt: DateTime.parse(map["created_at"]),
    );
  }

  Map<String, dynamic> toMap() {
    return compact<String, dynamic>({
      'id': id,
      'name': name,
      'description': description,
      'alert_central': alertCentral,
      'active': active,
      'message': message,
      'max_time': maxTime,
      'customer_id': customerId,
      "updated_at": updatedAt?.toIso8601String(),
      "created_at": createdAt?.toIso8601String(),
    });
  }
}
