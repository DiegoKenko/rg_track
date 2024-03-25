class CustomerVehicleFields {
  final String prefix = 'customer_vehicle';
  bool _withPrefix = false;
  Iterable<String> available = [
    "vehicle_id",
    "customer_id",
    "created_at",
    "updated_at",
    "vehicle",
    "customer",
  ];
  final Set<String> _selected = {};

  CustomerVehicleFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  CustomerVehicleFields get vehicleId {
    _selected.add('vehicle_id');
    return this;
  }

  CustomerVehicleFields get customerId {
    _selected.add('customer_id');
    return this;
  }

  CustomerVehicleFields get createdAt {
    _selected.add('created_at');
    return this;
  }

  CustomerVehicleFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }

  CustomerVehicleFields get vehicle {
    _selected.add('vehicle');
    return this;
  }

  CustomerVehicleFields get customer {
    _selected.add('customer');
    return this;
  }
}
