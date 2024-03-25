import 'package:rg_track/model/customer.dart';
import 'package:rg_track/model/vehicle.dart';

class CustomerVehicle {
  String? vehicleId, customerId;
  bool owner;
  DateTime? createdAt, updatedAt;
  Vehicle? vehicle;
  Customer? customer;

  CustomerVehicle({
    this.vehicleId,
    this.customerId,
    this.createdAt,
    this.updatedAt,
    this.vehicle,
    this.customer,
    this.owner = false,
  });

  CustomerVehicle.fromCustomer(this.customer, this.owner)
      : customerId = customer!.id;

  factory CustomerVehicle.fromMap(Map<String, dynamic> map) {
    return CustomerVehicle(
      vehicleId: map['vehicle_id'] as String?,
      customerId: map['customer_id'] as String?,
      createdAt: map['created_at'] as DateTime?,
      updatedAt: map['updated_at'] as DateTime?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vehicle_id': vehicleId,
      'customer_id': customerId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'vehicle': vehicle?.toMap(),
      'customer': customer?.toMap(),
    };
  }
}
