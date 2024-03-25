class VehicleKindFields {
  final String prefix = 'vehicle_kind';
  bool _withPrefix = false;
  Iterable<String> available = [
    "id",
    "title",
    "description",
    "created_at",
    "updated_at",
  ];
  final Set<String> _selected = {};

  VehicleKindFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  VehicleKindFields get id {
    _selected.add('id');
    return this;
  }

  VehicleKindFields get title {
    _selected.add('title');
    return this;
  }

  VehicleKindFields get description {
    _selected.add('description');
    return this;
  }

  VehicleKindFields get createdAt {
    _selected.add('created_at');
    return this;
  }

  VehicleKindFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }
}
