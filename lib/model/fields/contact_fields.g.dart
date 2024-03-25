class ContactFields {
  final String prefix = 'contact';
  bool _withPrefix = false;
  Iterable<String> available = [
    "id",
    "email",
    "phone",
    "contact_name",
    "created_at",
    "updated_at",
  ];
  final Set<String> _selected = {};

  ContactFields get withPrefix {
    _withPrefix = true;
    return this;
  }

  Iterable<String> get selected {
    if (_withPrefix) {
      return _selected.map((field) => '$prefix.$field');
    }
    return _selected;
  }

  ContactFields get id {
    _selected.add('id');
    return this;
  }

  ContactFields get email {
    _selected.add('email');
    return this;
  }

  ContactFields get phone {
    _selected.add('phone');
    return this;
  }

  ContactFields get contactName {
    _selected.add('contact_name');
    return this;
  }

  ContactFields get createdAt {
    _selected.add('created_at');
    return this;
  }

  ContactFields get updatedAt {
    _selected.add('updated_at');
    return this;
  }
}
