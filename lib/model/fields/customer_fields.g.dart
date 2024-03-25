class CustomerFields {
  final String prefix = 'customer';
  bool _withPrefix = false;
  Iterable<String> available = [
    "id",
    "type",
    "document",
    "social_name",
    "full_name",
    "fantasy_name",
    "state_registration",
    "registration_date",
    "birth_date",
    "phone_number",
    "mobile_phone_number",
    "status",
    "is_whatsapp",
    "email",
    "service_password",
    "notify_email",
    "notify_sms",
    "notify_push",
    "is_person",
    "is_business",
    "updated_at",
    "created_at",
    "addresses",
    "contacts",
    "gender",
    "marital_state",
    "customer_plan",
  ];
  final Set<String> _selected = {};

  CustomerFields get addresses {
    _selected.add('addresses');
    return this;
  }

  CustomerFields get birthDate {
    _selected.add('birth_date');
    return this;
  }

  CustomerFields get contacts {
    _selected.add('contacts');
    return this;
  }

  CustomerFields get createdAt {
    _selected.add('created_at');
    return this;
  }

  CustomerFields get customerPlan {
    _selected.add('customer_plan');
    return this;
  }

  CustomerFields get document {
    _selected.add('document');
    return this;
  }

  CustomerFields get email {
    _selected.add('email');
    return this;
  }

  CustomerFields get fantasyName {
    _selected.add('fantasy_name');
    return this;
  }

  CustomerFields get fullName {
    _selected.add('full_name');
    return this;
  }

  CustomerFields get gender {
    _selected.add('gender');
    return this;
  }

  CustomerFields get id {
    _selected.add('id');
    return this;
  }

  CustomerFields get isBusiness {
    _selected.add('is_business');
    return this;
  }

  CustomerFields get isPerson {
    _selected.add('is_person');
    return this;
  }

  CustomerFields get isWhatsapp {
    _selected.add('is_whatsapp');
    return this;
  }

  CustomerFields get maritalState {
    _selected.add('marital_state');
    return this;
  }

  CustomerFields get mobilePhoneNumber {
    _selected.add('mobile_phone_number');
    return this;
  }

  CustomerFields get notifyEmail {
    _selected.add('notify_email');
    return this;
  }

  CustomerFields get notifyPush {
    _selected.add('notify_push');
    return this;
  }

  CustomerFields get notifySms {
    _selected.add('notify_sms');
    return this;
  }

  CustomerFields get phoneNumber {
    _selected.add('phone_number');
    return this;
  }

  CustomerFields get registrationDate {
    _selected.add('registration_date');
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  CustomerFields get servicePassword {
    _selected.add('service_password');
    return this;
  }

  CustomerFields get socialName {
    _selected.add('social_name');
    return this;
  }

  CustomerFields get stateRegistration {
    _selected.add('state_registration');
    return this;
  }

  CustomerFields get status {
    _selected.add('status');
    return this;
  }

  CustomerFields get type {
    _selected.add('type');
    return this;
  }

  CustomerFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }

  CustomerFields get withPrefix {
    _withPrefix = true;
    return this;
  }
}
