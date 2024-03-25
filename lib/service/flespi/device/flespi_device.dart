class FlespiDevice {
  int? deviceTypeId;
  int? id;
  String imei;
  String phone;
  String? channelId;
  int? cid;
  bool connected;

  FlespiDevice({
    required this.imei,
    required this.deviceTypeId,
    required this.phone,
    this.id,
    this.cid,
    this.channelId,
    this.connected = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'device_type_id': deviceTypeId,
      'configuration': {
        'ident': imei,
      },
    };
  }

  factory FlespiDevice.fromMap(Map<String, dynamic> map) {
    return FlespiDevice(
      phone: map['phone'] ?? '',
      id: map['id'],
      cid: map['cid'],
      deviceTypeId: map['device_type_id'],
      imei: map['configuration']?['ident'] ?? '',
    );
  }

  String connectServerCommand(String host, String port) {
    return 'SERVER,$host,$port#';
  }

  String checkConnectionCommand() {
    return 'PARAM#';
  }

  String sleepCommand(bool on) {
    String onOff = on ? 'ON' : 'OFF';
    return 'SLP$onOff#';
  }

  String timerMove(int seconds) {
    return 'TIMER,$seconds#';
  }

  String timerStatic(int hours) {
    return 'STATIC,$hours#';
  }

  String bend(int angle, bool on) {
    if (on) {
      return 'BEND,1,$angle#';
    } else {
      return 'BEND,0#';
    }
  }

  String speedMax(int value) {
    return 'SPEEDING,$value,3#';
  }

  String speedMaxInterval() {
    return 'STIME,10#';
  }
}
