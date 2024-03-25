class PlanFields {
  final String prefix = 'plan';
  bool _withPrefix = false;
  Iterable<String> available = [
    "name",
    "description",
    "customer_id",
    "period",
    "price_vehicle_cents",
    "is_active",
    "abilities",
    "updated_at",
    "created_at",
    "id",
  ];
  final Set<String> _selected = {};

  PlanFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  PlanFields get name {
    _selected.add('name');
    return this;
  }

  PlanFields get description {
    _selected.add('description');
    return this;
  }

  PlanFields get customerId {
    _selected.add('customer_id');
    return this;
  }

  PlanFields get period {
    _selected.add('period');
    return this;
  }

  PlanFields get priceVehicleCents {
    _selected.add('price_vehicle_cents');
    return this;
  }

  PlanFields get isActive {
    _selected.add('is_active');
    return this;
  }

  PlanFields get abilities {
    _selected.add('abilities');
    return this;
  }

  PlanFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }

  PlanFields get createdAt {
    _selected.add('created_at');
    return this;
  }

  PlanFields get id {
    _selected.add('id');
    return this;
  }
}
