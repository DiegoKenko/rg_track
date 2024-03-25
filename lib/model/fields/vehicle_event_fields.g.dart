class VehicleEventFields {
  final String prefix = 'vehicle_event';
  bool _withPrefix = false;
  Iterable<String> available = [
    "id",
    "name",
    "description",
    "alert_central",
    "active",
    "message",
    "max_time",
    "customer_id",
    "updated_at",
    "created_at",
  ];
  final Set<String> _selected = {};

  VehicleEventFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  VehicleEventFields get id {
    _selected.add('id');
    return this;
  }

  VehicleEventFields get name {
    _selected.add('name');
    return this;
  }

  VehicleEventFields get description {
    _selected.add('description');
    return this;
  }

  VehicleEventFields get alertCentral {
    _selected.add('alert_central');
    return this;
  }

  VehicleEventFields get active {
    _selected.add('active');
    return this;
  }

  VehicleEventFields get message {
    _selected.add('message');
    return this;
  }

  VehicleEventFields get maxTime {
    _selected.add('max_time');
    return this;
  }

  VehicleEventFields get customerId {
    _selected.add('customer_id');
    return this;
  }

  VehicleEventFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }

  VehicleEventFields get createdAt {
    _selected.add('created_at');
    return this;
  }
}
