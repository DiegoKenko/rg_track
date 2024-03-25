class FineAlertFields {
  final String prefix = 'fine_alert';
  bool _withPrefix = false;
  Iterable<String> available = [
    "id",
    "status",
    "vehicleKindId",
    "licensePlate",
    "color",
    "renavam",
    "manufacturer",
    "model",
    "year",
    "chassi",
    "uf",
    "observations",
    "fleet",
    "fineConsultation",
    "updatedAt",
    "createdAt",
  ];
  final Set<String> _selected = {};

  FineAlertFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  FineAlertFields get id {
    _selected.add('id');
    return this;
  }

  FineAlertFields get status {
    _selected.add('status');
    return this;
  }

  FineAlertFields get vehicleKindId {
    _selected.add('vehicleKindId');
    return this;
  }

  FineAlertFields get licensePlate {
    _selected.add('licensePlate');
    return this;
  }

  FineAlertFields get color {
    _selected.add('color');
    return this;
  }

  FineAlertFields get renavam {
    _selected.add('renavam');
    return this;
  }

  FineAlertFields get manufacturer {
    _selected.add('manufacturer');
    return this;
  }

  FineAlertFields get model {
    _selected.add('model');
    return this;
  }

  FineAlertFields get year {
    _selected.add('year');
    return this;
  }

  FineAlertFields get chassi {
    _selected.add('chassi');
    return this;
  }

  FineAlertFields get uf {
    _selected.add('uf');
    return this;
  }

  FineAlertFields get observations {
    _selected.add('observations');
    return this;
  }

  FineAlertFields get fleet {
    _selected.add('fleet');
    return this;
  }

  FineAlertFields get fineConsultation {
    _selected.add('fineConsultation');
    return this;
  }

  FineAlertFields get updatedAt {
    _selected.add('updatedAt');
    return this;
  }

  FineAlertFields get createdAt {
    _selected.add('createdAt');
    return this;
  }
}
