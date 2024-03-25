class FlespiDeviceCommand {
  DateTime? date;
  String? response;
  int? id;
  String command;
  int? deviceId;
  bool executed;

  FlespiDeviceCommand({
    this.date,
    this.response,
    this.id,
    required this.command,
    this.deviceId,
    this.executed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": "custom",
      "properties": {
        "payload": command,
      },
      "timeout": 10
    };
  }

  Map<String, dynamic> toMapQueue() {
    return {
      "name": "custom",
      "properties": {
        "payload": command,
      },
      "ttl": 3600
    };
  }

  factory FlespiDeviceCommand.fromMap(Map<String, dynamic> map) {
    return FlespiDeviceCommand(
      id: map['id'],
      command: map['properties']?['payload'],
      deviceId: map['device_id'],
      date: map['timestamp'] == null
          ? null
          : DateTime.fromMicrosecondsSinceEpoch(map['timestamp'] * 1000),
      response: map['response'],
      executed: map['executed'] ?? false,
    );
  }
}
