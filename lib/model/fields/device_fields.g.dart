class DeviceFields {
  final String prefix = 'device';
  bool _withPrefix = false;
  Iterable<String> available = [
    "brand",
    "model",
    "serial",
    "control_number",
    "imei",
    "password",
    "firmware_version",
    "busy",
    "mobile_operator",
    "habilitated_at",
    "sim_number",
    "sim_phone_number",
    "sim_pin",
    "sim_puk",
    "sim_apn",
    "sim_apn_user",
    "sim_apn_password",
    "sim_iccid",
    "updated_at",
    "created_at",
    "vehicle",
    "customer",
    "id",
  ];
  final Set<String> _selected = {};

  DeviceFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  DeviceFields get brand {
    _selected.add('brand');
    return this;
  }

  DeviceFields get model {
    _selected.add('model');
    return this;
  }

  DeviceFields get serial {
    _selected.add('serial');
    return this;
  }

  DeviceFields get controlNumber {
    _selected.add('control_number');
    return this;
  }

  DeviceFields get imei {
    _selected.add('imei');
    return this;
  }

  DeviceFields get password {
    _selected.add('password');
    return this;
  }

  DeviceFields get firmwareVersion {
    _selected.add('firmware_version');
    return this;
  }

  DeviceFields get busy {
    _selected.add('busy');
    return this;
  }

  DeviceFields get mobileOperator {
    _selected.add('mobile_operator');
    return this;
  }

  DeviceFields get habilitatedAt {
    _selected.add('habilitated_at');
    return this;
  }

  DeviceFields get simNumber {
    _selected.add('sim_number');
    return this;
  }

  DeviceFields get simPhoneNumber {
    _selected.add('sim_phone_number');
    return this;
  }

  DeviceFields get simPin {
    _selected.add('sim_pin');
    return this;
  }

  DeviceFields get simPuk {
    _selected.add('sim_puk');
    return this;
  }

  DeviceFields get simApn {
    _selected.add('sim_apn');
    return this;
  }

  DeviceFields get simApnUser {
    _selected.add('sim_apn_user');
    return this;
  }

  DeviceFields get simApnPassword {
    _selected.add('sim_apn_password');
    return this;
  }

  DeviceFields get simIccid {
    _selected.add('sim_iccid');
    return this;
  }

  DeviceFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }

  DeviceFields get createdAt {
    _selected.add('created_at');
    return this;
  }

  DeviceFields get vehicle {
    _selected.add('vehicle');
    return this;
  }

  DeviceFields get customer {
    _selected.add('customer');
    return this;
  }

  DeviceFields get id {
    _selected.add('id');
    return this;
  }
}
