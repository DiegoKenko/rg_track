import 'package:rg_track/model/plan.dart';

class CustomerPlan {
  int? id;
  int? planId;
  Plan? plan;
  String? customerId;
  int? priceVehicleCents;
  bool isActive;
  DateTime? startDate;
  DateTime? endDate;
  int? dueDay;

  CustomerPlan({
    this.id,
    this.planId,
    this.plan,
    this.customerId,
    this.priceVehicleCents,
    this.isActive = false,
    this.startDate,
    this.endDate,
    this.dueDay,
  });

  factory CustomerPlan.fromMap(Map<String, dynamic> map) => CustomerPlan(
        id: map['id'] as int?,
        planId: map['plan_id'] as int,
        plan: Plan.fromMap(Map<String, dynamic>.from(map['plan'])),
        customerId: map['customer_id'] as String?,
        priceVehicleCents: map['price_vehicle_cents'] as int?,
        isActive: map['is_active'] as bool,
        startDate: map['start_date'] == null
            ? null
            : DateTime.parse(map['start_date']),
        endDate:
            map['end_date'] == null ? null : DateTime.parse(map['end_date']),
        dueDay: map['due_day'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'plan_id': planId,
        'plan': plan?.toMap(),
        'customer_id': customerId,
        'price_vehicle_cents': priceVehicleCents,
        'is_active': isActive,
        'start_date': startDate?.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
        'due_day': dueDay,
      };

  CustomerPlan copyWith({
    int? id,
    int? planId,
    Plan? plan,
    String? customerId,
    int? priceVehicleCents,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    int? dueDay,
  }) {
    return CustomerPlan(
      id: id ?? this.id,
      planId: planId ?? this.planId,
      plan: plan ?? this.plan,
      customerId: customerId ?? this.customerId,
      priceVehicleCents: priceVehicleCents ?? this.priceVehicleCents,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      dueDay: dueDay ?? this.dueDay,
    );
  }
}
