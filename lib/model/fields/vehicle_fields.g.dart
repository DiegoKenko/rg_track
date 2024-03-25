class VehicleFields {
  final String prefix = 'vehicle';
  bool _withPrefix = false;
  Iterable<String> available = [
    "id",
    "status",
    "installation_date",
    "vehicle_kind_id",
    "license_plate",
    "color",
    "renavam",
    "mileage",
    "manufacturer",
    "model",
    "year",
    "chassi",
    "uf",
    "security_question",
    "security_answer",
    "observations",
    "fleet",
    "specification",
    "monthly_fee_cents",
    "kind_of_fuel_id",
    "speeding",
    "time_still",
    "without_transmission",
    "starts_work_at",
    "ends_work_at",
    "fine_consultation",
    "updated_at",
    "created_at",
  ];
  final Set<String> _selected = {};

  VehicleFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  VehicleFields get id {
    _selected.add('id');
    return this;
  }

  VehicleFields get status {
    _selected.add('status');
    return this;
  }

  VehicleFields get installationDate {
    _selected.add('installation_date');
    return this;
  }

  VehicleFields get vehicleKindId {
    _selected.add('vehicle_kind_id');
    return this;
  }

  VehicleFields get licensePlate {
    _selected.add('license_plate');
    return this;
  }

  VehicleFields get color {
    _selected.add('color');
    return this;
  }

  VehicleFields get renavam {
    _selected.add('renavam');
    return this;
  }

  VehicleFields get mileage {
    _selected.add('mileage');
    return this;
  }

  VehicleFields get manufacturer {
    _selected.add('manufacturer');
    return this;
  }

  VehicleFields get model {
    _selected.add('model');
    return this;
  }

  VehicleFields get year {
    _selected.add('year');
    return this;
  }

  VehicleFields get chassi {
    _selected.add('chassi');
    return this;
  }

  VehicleFields get uf {
    _selected.add('uf');
    return this;
  }

  VehicleFields get securityQuestion {
    _selected.add('security_question');
    return this;
  }

  VehicleFields get securityAnswer {
    _selected.add('security_answer');
    return this;
  }

  VehicleFields get observations {
    _selected.add('observations');
    return this;
  }

  VehicleFields get fleet {
    _selected.add('fleet');
    return this;
  }

  VehicleFields get specification {
    _selected.add('specification');
    return this;
  }

  VehicleFields get monthlyFeeCents {
    _selected.add('monthly_fee_cents');
    return this;
  }

  VehicleFields get kindOfFuelId {
    _selected.add('kind_of_fuel_id');
    return this;
  }

  VehicleFields get speeding {
    _selected.add('speeding');
    return this;
  }

  VehicleFields get timeStill {
    _selected.add('time_still');
    return this;
  }

  VehicleFields get withoutTransmission {
    _selected.add('without_transmission');
    return this;
  }

  VehicleFields get startsWorkAt {
    _selected.add('starts_work_at');
    return this;
  }

  VehicleFields get endsWorkAt {
    _selected.add('ends_work_at');
    return this;
  }

  VehicleFields get fineConsultation {
    _selected.add('fine_consultation');
    return this;
  }

  VehicleFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }

  VehicleFields get createdAt {
    _selected.add('created_at');
    return this;
  }
}
