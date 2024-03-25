class AccountFields {
  final String prefix = 'account';
  bool _withPrefix = false;
  Iterable<String> available = [
    "id",
    "name",
    "email",
    "phone",
    "document",
    "is_whatsapp",
    "email_verified_at",
    "phone_verified_at",
    "password",
    "start_of_the_journey",
    "end_of_the_journey",
    "status",
    "kind",
    "created_at",
    "updated_at",
    "token",
    "remember_session",
    "customer",
    "abilities",
  ];
  final Set<String> _selected = {};

  AccountFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  AccountFields get id {
    _selected.add('id');
    return this;
  }

  AccountFields get name {
    _selected.add('name');
    return this;
  }

  AccountFields get email {
    _selected.add('email');
    return this;
  }

  AccountFields get phone {
    _selected.add('phone');
    return this;
  }

  AccountFields get document {
    _selected.add('document');
    return this;
  }

  AccountFields get isWhatsapp {
    _selected.add('is_whatsapp');
    return this;
  }

  AccountFields get emailVerifiedAt {
    _selected.add('email_verified_at');
    return this;
  }

  AccountFields get phoneVerifiedAt {
    _selected.add('phone_verified_at');
    return this;
  }

  AccountFields get password {
    _selected.add('password');
    return this;
  }

  AccountFields get startOfTheJourney {
    _selected.add('start_of_the_journey');
    return this;
  }

  AccountFields get endOfTheJourney {
    _selected.add('end_of_the_journey');
    return this;
  }

  AccountFields get status {
    _selected.add('status');
    return this;
  }

  AccountFields get kind {
    _selected.add('kind');
    return this;
  }

  AccountFields get createdAt {
    _selected.add('created_at');
    return this;
  }

  AccountFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }

  AccountFields get token {
    _selected.add('token');
    return this;
  }

  AccountFields get rememberSession {
    _selected.add('remember_session');
    return this;
  }

  AccountFields get customer {
    _selected.add('customer');
    return this;
  }

  AccountFields get abilities {
    _selected.add('abilities');
    return this;
  }
}
