class FlespiChannelMessage {
  bool? _batteryChargingStatus;
  double? _batteryVoltage;
  int? _channelId;
  int? _deviceId;
  int? _deviceTypeId;
  bool? _engineBlockedStatus;
  bool? _engineIgnitionStatus;
  int? _engineMotorhours;
  double? _externalPowersourceVoltage;
  bool? _gnssStatus;
  int? _gsmCellid;
  int? _gsmLac;
  int? _gsmMcc;
  int? _gsmMnc;
  int? _gsmSignalLevel;
  String? _ident;
  String? _languageEnum;
  bool? _messageBufferedStatus;
  String? _peer;
  int? _positionDirection;
  double? _positionLatitude;
  double? _positionLongitude;
  int? _positionSatellites;
  int? _positionSpeed;
  int? _positionTimestamp;
  bool? _positionValid;
  int? _protocolId;
  int? _protocolNumber;
  double? _serverTimestamp;
  double? _timestamp;
  int? _vehicleMileage;

  FlespiChannelMessage(
      {bool? batteryChargingStatus,
      double? batteryVoltage,
      int? channelId,
      int? deviceId,
      int? deviceTypeId,
      bool? engineBlockedStatus,
      bool? engineIgnitionStatus,
      int? engineMotorhours,
      double? externalPowersourceVoltage,
      bool? gnssStatus,
      int? gsmCellid,
      int? gsmLac,
      int? gsmMcc,
      int? gsmMnc,
      int? gsmSignalLevel,
      String? ident,
      String? languageEnum,
      bool? messageBufferedStatus,
      String? peer,
      int? positionDirection,
      double? positionLatitude,
      double? positionLongitude,
      int? positionSatellites,
      int? positionSpeed,
      int? positionTimestamp,
      bool? positionValid,
      int? protocolId,
      int? protocolNumber,
      double? serverTimestamp,
      double? timestamp,
      int? vehicleMileage}) {
    if (batteryChargingStatus != null) {
      _batteryChargingStatus = batteryChargingStatus;
    }
    if (batteryVoltage != null) {
      _batteryVoltage = batteryVoltage;
    }
    if (channelId != null) {
      _channelId = channelId;
    }
    if (_deviceId != null) {
      _deviceId = deviceId;
    }
    if (_deviceTypeId != null) {
      _deviceTypeId = deviceId;
    }

    if (engineBlockedStatus != null) {
      _engineBlockedStatus = engineBlockedStatus;
    }
    if (engineIgnitionStatus != null) {
      _engineIgnitionStatus = engineIgnitionStatus;
    }
    if (engineMotorhours != null) {
      _engineMotorhours = engineMotorhours;
    }
    if (externalPowersourceVoltage != null) {
      _externalPowersourceVoltage = externalPowersourceVoltage.toDouble();
    }
    if (gnssStatus != null) {
      _gnssStatus = gnssStatus;
    }
    if (gsmCellid != null) {
      _gsmCellid = gsmCellid;
    }
    if (gsmLac != null) {
      _gsmLac = gsmLac;
    }
    if (gsmMcc != null) {
      _gsmMcc = gsmMcc;
    }
    if (gsmMnc != null) {
      _gsmMnc = gsmMnc;
    }
    if (gsmSignalLevel != null) {
      _gsmSignalLevel = gsmSignalLevel;
    }
    if (ident != null) {
      _ident = ident;
    }
    if (languageEnum != null) {
      _languageEnum = languageEnum;
    }
    if (messageBufferedStatus != null) {
      _messageBufferedStatus = messageBufferedStatus;
    }
    if (peer != null) {
      _peer = peer;
    }
    if (positionDirection != null) {
      _positionDirection = positionDirection;
    }
    if (positionLatitude != null) {
      _positionLatitude = positionLatitude;
    }
    if (positionLongitude != null) {
      _positionLongitude = positionLongitude;
    }
    if (positionSatellites != null) {
      _positionSatellites = positionSatellites;
    }
    if (positionSpeed != null) {
      _positionSpeed = positionSpeed;
    }
    if (positionTimestamp != null) {
      _positionTimestamp = positionTimestamp;
    }
    if (positionValid != null) {
      _positionValid = positionValid;
    }
    if (protocolId != null) {
      _protocolId = protocolId;
    }
    if (protocolNumber != null) {
      _protocolNumber = protocolNumber;
    }
    if (serverTimestamp != null) {
      _serverTimestamp = serverTimestamp;
    }
    if (timestamp != null) {
      _timestamp = timestamp;
    }
    if (vehicleMileage != null) {
      _vehicleMileage = vehicleMileage;
    }
  }

  bool? get batteryChargingStatus => _batteryChargingStatus;
  set batteryChargingStatus(bool? batteryChargingStatus) =>
      _batteryChargingStatus = batteryChargingStatus;
  double? get batteryVoltage => _batteryVoltage;
  set batteryVoltage(double? batteryVoltage) =>
      _batteryVoltage = batteryVoltage;
  int? get channelId => _channelId;
  set channelId(int? channelId) => _channelId = channelId;
  int? get deviceId => _deviceId;
  set deviceId(int? deviceId) => _deviceId = deviceId;
  int? get deviceTypeId => _deviceTypeId;
  set deviceTypeId(int? deviceTypeId) => _deviceTypeId = deviceTypeId;

  bool? get engineBlockedStatus => _engineBlockedStatus;
  set engineBlockedStatus(bool? engineBlockedStatus) =>
      _engineBlockedStatus = engineBlockedStatus;
  bool? get engineIgnitionStatus => _engineIgnitionStatus;
  set engineIgnitionStatus(bool? engineIgnitionStatus) =>
      _engineIgnitionStatus = engineIgnitionStatus;
  int? get engineMotorhours => _engineMotorhours;
  set engineMotorhours(int? engineMotorhours) =>
      _engineMotorhours = engineMotorhours;
  double? get externalPowersourceVoltage => _externalPowersourceVoltage;
  set externalPowersourceVoltage(double? externalPowersourceVoltage) =>
      _externalPowersourceVoltage = externalPowersourceVoltage;
  bool? get gnssStatus => _gnssStatus;
  set gnssStatus(bool? gnssStatus) => _gnssStatus = gnssStatus;
  int? get gsmCellid => _gsmCellid;
  set gsmCellid(int? gsmCellid) => _gsmCellid = gsmCellid;
  int? get gsmLac => _gsmLac;
  set gsmLac(int? gsmLac) => _gsmLac = gsmLac;
  int? get gsmMcc => _gsmMcc;
  set gsmMcc(int? gsmMcc) => _gsmMcc = gsmMcc;
  int? get gsmMnc => _gsmMnc;
  set gsmMnc(int? gsmMnc) => _gsmMnc = gsmMnc;
  int? get gsmSignalLevel => _gsmSignalLevel;
  set gsmSignalLevel(int? gsmSignalLevel) => _gsmSignalLevel = gsmSignalLevel;
  String? get ident => _ident;
  set ident(String? ident) => _ident = ident;
  String? get languageEnum => _languageEnum;
  set languageEnum(String? languageEnum) => _languageEnum = languageEnum;
  bool? get messageBufferedStatus => _messageBufferedStatus;
  set messageBufferedStatus(bool? messageBufferedStatus) =>
      _messageBufferedStatus = messageBufferedStatus;
  String? get peer => _peer;
  set peer(String? peer) => _peer = peer;
  int? get positionDirection => _positionDirection;
  set positionDirection(int? positionDirection) =>
      _positionDirection = positionDirection;
  double? get positionLatitude => _positionLatitude;
  set positionLatitude(double? positionLatitude) =>
      _positionLatitude = positionLatitude;
  double? get positionLongitude => _positionLongitude;
  set positionLongitude(double? positionLongitude) =>
      _positionLongitude = positionLongitude;
  int? get positionSatellites => _positionSatellites;
  set positionSatellites(int? positionSatellites) =>
      _positionSatellites = positionSatellites;
  int? get positionSpeed => _positionSpeed;
  set positionSpeed(int? positionSpeed) => _positionSpeed = positionSpeed;
  int? get positionTimestamp => _positionTimestamp;
  set positionTimestamp(int? positionTimestamp) =>
      _positionTimestamp = positionTimestamp;
  bool? get positionValid => _positionValid;
  set positionValid(bool? positionValid) => _positionValid = positionValid;
  int? get protocolId => _protocolId;
  set protocolId(int? protocolId) => _protocolId = protocolId;
  int? get protocolNumber => _protocolNumber;
  set protocolNumber(int? protocolNumber) => _protocolNumber = protocolNumber;
  double? get serverTimestamp => _serverTimestamp;
  set serverTimestamp(double? serverTimestamp) =>
      _serverTimestamp = serverTimestamp;
  double? get timestamp => _timestamp;
  set timestamp(double? timestamp) => _timestamp = timestamp;
  int? get vehicleMileage => _vehicleMileage;
  set vehicleMileage(int? vehicleMileage) => _vehicleMileage = vehicleMileage;

  FlespiChannelMessage.fromMap(Map<String, dynamic> json) {
    _batteryChargingStatus = json['battery.charging.status'];
    _batteryVoltage = json['battery.voltage'];
    _deviceId = json['device.id'];
    _deviceTypeId = json['device.type.id'];
    _channelId = json['channel.id'];
    _engineBlockedStatus = json['engine.blocked.status'];
    _engineIgnitionStatus = json['engine.ignition.status'];
    _engineMotorhours = json['engine.motorhours'];
    _externalPowersourceVoltage =
        json['external.powersource.voltage']?.toDouble();
    _gnssStatus = json['gnss.status'];
    _gsmCellid = json['gsm.cellid'];
    _gsmLac = json['gsm.lac'];
    _gsmMcc = json['gsm.mcc'];
    _gsmMnc = json['gsm.mnc'];
    _gsmSignalLevel = json['gsm.signal.level'];
    _ident = json['ident'];
    _languageEnum = json['language.enum'];
    _messageBufferedStatus = json['message.buffered.status'];
    _peer = json['peer'];
    _positionDirection = json['position.direction'];
    _positionLatitude = json['position.latitude'];
    _positionLongitude = json['position.longitude'];
    _positionSatellites = json['position.satellites'];
    _positionSpeed = json['position.speed'];
    _positionTimestamp = json['position.timestamp'];
    _positionValid = json['position.valid'];
    _protocolId = json['protocol.id'];
    _protocolNumber = json['protocol.number'];
    _serverTimestamp = json['server.timestamp'];
    _timestamp = double.tryParse(json['timestamp'].toString());
    _vehicleMileage = json['vehicle.mileage'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['battery.charging.status'] = _batteryChargingStatus;
    data['battery.voltage'] = _batteryVoltage;
    data['channel.id'] = _channelId;
    data['device.id'] = _deviceId;
    data['device.type.id'] = _deviceTypeId;
    data['engine.blocked.status'] = _engineBlockedStatus;
    data['engine.ignition.status'] = _engineIgnitionStatus;
    data['engine.motorhours'] = _engineMotorhours;
    data['external.powersource.voltage'] = _externalPowersourceVoltage;
    data['gnss.status'] = _gnssStatus;
    data['gsm.cellid'] = _gsmCellid;
    data['gsm.lac'] = _gsmLac;
    data['gsm.mcc'] = _gsmMcc;
    data['gsm.mnc'] = _gsmMnc;
    data['gsm.signal.level'] = _gsmSignalLevel;
    data['ident'] = _ident;
    data['language.enum'] = _languageEnum;
    data['message.buffered.status'] = _messageBufferedStatus;
    data['peer'] = _peer;
    data['position.direction'] = _positionDirection;
    data['position.latitude'] = _positionLatitude;
    data['position.longitude'] = _positionLongitude;
    data['position.satellites'] = _positionSatellites;
    data['position.speed'] = _positionSpeed;
    data['position.timestamp'] = _positionTimestamp;
    data['position.valid'] = _positionValid;
    data['protocol.id'] = _protocolId;
    data['protocol.number'] = _protocolNumber;
    data['server.timestamp'] = _serverTimestamp;
    data['timestamp'] = _timestamp;
    data['vehicle.mileage'] = _vehicleMileage;
    return data;
  }
}
