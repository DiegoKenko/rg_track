class AddressFields {
  final String prefix = 'address';
  bool _withPrefix = false;
  Iterable<String> available = [
    "id",
    "zip_code",
    "state",
    "country",
    "city",
    "neighborhood",
    "street",
    "number",
    "complement",
    "point_of_the_reference",
    "lat",
    "long",
    "created_at",
    "updated_at",
  ];
  final Set<String> _selected = {};

  AddressFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  AddressFields get id {
    _selected.add('id');
    return this;
  }

  AddressFields get zipCode {
    _selected.add('zip_code');
    return this;
  }

  AddressFields get state {
    _selected.add('state');
    return this;
  }

  AddressFields get country {
    _selected.add('country');
    return this;
  }

  AddressFields get city {
    _selected.add('city');
    return this;
  }

  AddressFields get neighborhood {
    _selected.add('neighborhood');
    return this;
  }

  AddressFields get street {
    _selected.add('street');
    return this;
  }

  AddressFields get number {
    _selected.add('number');
    return this;
  }

  AddressFields get complement {
    _selected.add('complement');
    return this;
  }

  AddressFields get pointOfTheReference {
    _selected.add('point_of_the_reference');
    return this;
  }

  AddressFields get lat {
    _selected.add('lat');
    return this;
  }

  AddressFields get long {
    _selected.add('long');
    return this;
  }

  AddressFields get createdAt {
    _selected.add('created_at');
    return this;
  }

  AddressFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }
}
