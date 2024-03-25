import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Plan extends Equatable {
  final String name;
  final String description;
  final int customerId;
  final String period;
  final int priceVehicleCents;
  final bool isActive;
  final List<String> abilities;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  const Plan({
    required this.name,
    required this.description,
    required this.customerId,
    required this.period,
    required this.priceVehicleCents,
    required this.isActive,
    required this.abilities,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Plan.fromMap(Map<String, dynamic> map) => Plan(
        name: map['name'],
        description: map['description'] ?? '',
        customerId: map['customer_id'],
        period: map['period'],
        priceVehicleCents: map['price_vehicle_cents'],
        isActive: map['is_active'],
        abilities: List<String>.from(map['abilities']),
        updatedAt: DateTime.parse(map['updated_at']),
        createdAt: DateTime.parse(map['created_at']),
        id: map['id'],
      );

  @override
  List<Object> get props => [
        name,
        description,
        customerId,
        period,
        priceVehicleCents,
        isActive,
        abilities,
        updatedAt,
        createdAt,
        id,
      ];

  Plan copyWith({
    String? name,
    String? description,
    int? customerId,
    String? period,
    int? priceVehicleCents,
    bool? isActive,
    List<String>? abilities,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) {
    return Plan(
      name: name ?? this.name,
      description: description ?? this.description,
      customerId: customerId ?? this.customerId,
      period: period ?? this.period,
      priceVehicleCents: priceVehicleCents ?? this.priceVehicleCents,
      isActive: isActive ?? this.isActive,
      abilities: abilities ?? this.abilities,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'customer_id': customerId,
        'period': period,
        'price_vehicle_cents': priceVehicleCents,
        'is_active': isActive,
        'abilities': abilities,
        'updated_at': updatedAt.toIso8601String(),
        'created_at': createdAt.toIso8601String(),
        'id': id,
      };

  String get price => NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(priceVehicleCents / 100);

  factory Plan.empty() => Plan(
        name: '',
        description: '',
        customerId: 0,
        period: '',
        priceVehicleCents: 0,
        isActive: false,
        abilities: const [],
        updatedAt: DateTime.now(),
        createdAt: DateTime.now(),
        id: 0,
      );
}
