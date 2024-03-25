class DriverFields {
  final String prefix = 'driver';
  bool _withPrefix = false;
  Iterable<String> available = [
    "id",
    "customer_id",
    "name",
    "document",
    "rg",
    "cnh",
    "cnh_category",
    "cnh_expires_at",
    "cnh_first_enablement",
    "gender",
    "marital_state",
    "birthday",
    "status",
    "service_password",
    "indication",
    "phone",
    "mobile_phone",
    "is_whatsapp",
    "email",
    "secret_question",
    "secret_answer",
    "driver_code",
    "observations",
    "starts_work_at",
    "ends_work_at",
    "lunch_starts_at",
    "lunch_stops_at",
    "updated_at",
    "created_at",
    "contacts",
    "addresses",
  ];
  final Set<String> _selected = {};

  DriverFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  DriverFields get id {
    _selected.add('id');
    return this;
  }

  DriverFields get customerId {
    _selected.add('customer_id');
    return this;
  }

  DriverFields get name {
    _selected.add('name');
    return this;
  }

  DriverFields get document {
    _selected.add('document');
    return this;
  }

  DriverFields get rg {
    _selected.add('rg');
    return this;
  }

  DriverFields get cnh {
    _selected.add('cnh');
    return this;
  }

  DriverFields get cnhCategory {
    _selected.add('cnh_category');
    return this;
  }

  DriverFields get cnhExpiresAt {
    _selected.add('cnh_expires_at');
    return this;
  }

  DriverFields get cnhFirstEnablement {
    _selected.add('cnh_first_enablement');
    return this;
  }

  DriverFields get gender {
    _selected.add('gender');
    return this;
  }

  DriverFields get maritalState {
    _selected.add('marital_state');
    return this;
  }

  DriverFields get birthday {
    _selected.add('birthday');
    return this;
  }

  DriverFields get status {
    _selected.add('status');
    return this;
  }

  DriverFields get servicePassword {
    _selected.add('service_password');
    return this;
  }

  DriverFields get indication {
    _selected.add('indication');
    return this;
  }

  DriverFields get phone {
    _selected.add('phone');
    return this;
  }

  DriverFields get mobilePhone {
    _selected.add('mobile_phone');
    return this;
  }

  DriverFields get isWhatsapp {
    _selected.add('is_whatsapp');
    return this;
  }

  DriverFields get email {
    _selected.add('email');
    return this;
  }

  DriverFields get secretQuestion {
    _selected.add('secret_question');
    return this;
  }

  DriverFields get secretAnswer {
    _selected.add('secret_answer');
    return this;
  }

  DriverFields get driverCode {
    _selected.add('driver_code');
    return this;
  }

  DriverFields get observations {
    _selected.add('observations');
    return this;
  }

  DriverFields get startsWorkAt {
    _selected.add('starts_work_at');
    return this;
  }

  DriverFields get endsWorkAt {
    _selected.add('ends_work_at');
    return this;
  }

  DriverFields get lunchStartsAt {
    _selected.add('lunch_starts_at');
    return this;
  }

  DriverFields get lunchStopsAt {
    _selected.add('lunch_stops_at');
    return this;
  }

  DriverFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }

  DriverFields get createdAt {
    _selected.add('created_at');
    return this;
  }

  DriverFields get contacts {
    _selected.add('contacts');
    return this;
  }

  DriverFields get addresses {
    _selected.add('addresses');
    return this;
  }
}
