class KindOfFuelFields {
  final String prefix = 'kind_of_fuel';
  bool _withPrefix = false;
  Iterable<String> available = [
    "title",
    "updated_at",
    "created_at",
    "id",
  ];
  final Set<String> _selected = {};

  KindOfFuelFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  KindOfFuelFields get title {
    _selected.add('title');
    return this;
  }

  KindOfFuelFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }

  KindOfFuelFields get createdAt {
    _selected.add('created_at');
    return this;
  }

  KindOfFuelFields get id {
    _selected.add('id');
    return this;
  }
}
