class PeripheralFields {
  final String prefix = 'peripheral';
  bool _withPrefix = false;
  Iterable<String> available = [
    "id",
    "brand",
    "model",
    "serial",
    "observations",
    "created_at",
    "updated_at",
  ];
  final Set<String> _selected = {};

  PeripheralFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  PeripheralFields get id {
    _selected.add('id');
    return this;
  }

  PeripheralFields get brand {
    _selected.add('brand');
    return this;
  }

  PeripheralFields get model {
    _selected.add('model');
    return this;
  }

  PeripheralFields get serial {
    _selected.add('serial');
    return this;
  }

  PeripheralFields get observations {
    _selected.add('observations');
    return this;
  }

  PeripheralFields get createdAt {
    _selected.add('created_at');
    return this;
  }

  PeripheralFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }
}
