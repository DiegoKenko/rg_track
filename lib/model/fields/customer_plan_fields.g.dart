class CustomerPlanFields {
  final String prefix = 'customer_plan';
  bool _withPrefix = false;
  Iterable<String> available = [
    "id",
    "plan_id",
    "plan",
    "customer_id",
    "price_vehicle_cents",
    "is_active",
    "start_date",
    "end_date",
    "due_day",
  ];
  final Set<String> _selected = {};

  CustomerPlanFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  CustomerPlanFields get id {
    _selected.add('id');
    return this;
  }

  CustomerPlanFields get planId {
    _selected.add('plan_id');
    return this;
  }

  CustomerPlanFields get plan {
    _selected.add('plan');
    return this;
  }

  CustomerPlanFields get customerId {
    _selected.add('customer_id');
    return this;
  }

  CustomerPlanFields get priceVehicleCents {
    _selected.add('price_vehicle_cents');
    return this;
  }

  CustomerPlanFields get isActive {
    _selected.add('is_active');
    return this;
  }

  CustomerPlanFields get startDate {
    _selected.add('start_date');
    return this;
  }

  CustomerPlanFields get endDate {
    _selected.add('end_date');
    return this;
  }

  CustomerPlanFields get dueDay {
    _selected.add('due_day');
    return this;
  }
}
