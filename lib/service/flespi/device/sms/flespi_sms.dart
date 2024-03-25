class FlespiSms {
  String name;
  Map<String, dynamic> properties;

  FlespiSms({
    required this.name,
    required this.properties,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'properties': properties,
    };
  }

  factory FlespiSms.fromCommand(String command) {
    return FlespiSms(
      name: 'send',
      properties: {'command': command},
    );
  }

  factory FlespiSms.fromMap(Map<String, dynamic> map) {
    return FlespiSms(
      name: map['name'] ?? '',
      properties: map['properties'] ?? '',
    );
  }
}
