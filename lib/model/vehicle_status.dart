import 'package:rg_track/service/flespi/device/message/flespi_channel_message.dart';

class VehicleStatus {
  bool? batteryChargingStatus;
  double? batteryVoltage;
  int? channelId;
  int? deviceId;
  int? deviceTypeId;
  bool? engineBlockedStatus;
  bool? engineIgnitionStatus;
  int? engineMotorhours;
  double? externalPowersourceVoltage;
  bool? gnssStatus;
  int? gsmCellid;
  int? gsmLac;
  int? gsmMcc;
  int? gsmMnc;
  int? gsmSignalLevel;
  String? ident;
  String? languageEnum;
  bool? messageBufferedStatus;
  String? peer;
  int? positionDirection;
  double? positionLatitude;
  double? positionLongitude;
  int? positionSatellites;
  int? positionSpeed;
  int? positionTimestamp;
  bool? positionValid;
  int? protocolId;
  int? protocolNumber;
  double? serverTimestamp;
  double? timestamp;
  int? vehicleMileage;

  int get inactiveTime => DateTime.now()
      .difference(
          DateTime.fromMillisecondsSinceEpoch((timestamp ?? 0).toInt() * 1000))
      .inHours;

  bool get isActive => inactiveTime < 6;

  VehicleStatus(
      {this.batteryChargingStatus,
      this.batteryVoltage,
      this.channelId,
      this.deviceId,
      this.deviceTypeId,
      this.engineBlockedStatus,
      this.engineIgnitionStatus,
      this.engineMotorhours,
      this.externalPowersourceVoltage,
      this.gnssStatus,
      this.gsmCellid,
      this.gsmLac,
      this.gsmMcc,
      this.gsmMnc,
      this.gsmSignalLevel,
      this.ident,
      this.languageEnum,
      this.messageBufferedStatus,
      this.peer,
      this.positionDirection,
      this.positionLatitude,
      this.positionLongitude,
      this.positionSatellites,
      this.positionSpeed,
      this.positionTimestamp,
      this.positionValid,
      this.protocolId,
      this.protocolNumber,
      this.serverTimestamp,
      this.timestamp,
      this.vehicleMileage});

  VehicleStatus.fromMap(Map<String, dynamic> json) {
    batteryChargingStatus = json['battery.charging.status'];
    batteryVoltage = json['battery.voltage'];
    channelId = json['channel.id'];
    deviceId = json['device.id'];
    deviceTypeId = json['device.type.id'];
    engineBlockedStatus = json['engine.blocked.status'];
    engineIgnitionStatus = json['engine.ignition.status'];
    engineMotorhours = json['engine.motorhours'];
    externalPowersourceVoltage = json['external.powersource.voltage'];
    gnssStatus = json['gnss.status'];
    gsmCellid = json['gsm.cellid'];
    gsmLac = json['gsm.lac'];
    gsmMcc = json['gsm.mcc'];
    gsmMnc = json['gsm.mnc'];
    gsmSignalLevel = json['gsm.signal.level'];
    ident = json['ident'];
    languageEnum = json['language.enum'];
    messageBufferedStatus = json['message.buffered.status'];
    peer = json['peer'];
    positionDirection = json['position.direction'];
    positionLatitude = json['position.latitude'];
    positionLongitude = json['position.longitude'];
    positionSatellites = json['position.satellites'];
    positionSpeed = json['position.speed'];
    positionTimestamp = json['position.timestamp'];
    positionValid = json['position.valid'];
    protocolId = json['protocol.id'];
    protocolNumber = json['protocol.number'];
    serverTimestamp = json['server.timestamp'];
    timestamp = json['timestamp'];
    vehicleMileage = json['vehicle.mileage'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['battery.charging.status'] = batteryChargingStatus;
    data['battery.voltage'] = batteryVoltage;
    data['channel.id'] = channelId;
    data['device.id'] = deviceId;
    data['device.type.id'] = deviceTypeId;
    data['engine.blocked.status'] = engineBlockedStatus;
    data['engine.ignition.status'] = engineIgnitionStatus;
    data['engine.motorhours'] = engineMotorhours;
    data['external.powersource.voltage'] = externalPowersourceVoltage;
    data['gnss.status'] = gnssStatus;
    data['gsm.cellid'] = gsmCellid;
    data['gsm.lac'] = gsmLac;
    data['gsm.mcc'] = gsmMcc;
    data['gsm.mnc'] = gsmMnc;
    data['gsm.signal.level'] = gsmSignalLevel;
    data['ident'] = ident;
    data['language.enum'] = languageEnum;
    data['message.buffered.status'] = messageBufferedStatus;
    data['peer'] = peer;
    data['position.direction'] = positionDirection;
    data['position.latitude'] = positionLatitude;
    data['position.longitude'] = positionLongitude;
    data['position.satellites'] = positionSatellites;
    data['position.speed'] = positionSpeed;
    data['position.timestamp'] = positionTimestamp;
    data['position.valid'] = positionValid;
    data['protocol.id'] = protocolId;
    data['protocol.number'] = protocolNumber;
    data['server.timestamp'] = serverTimestamp;
    data['timestamp'] = timestamp;
    data['vehicle.mileage'] = vehicleMileage;
    return data;
  }

  factory VehicleStatus.empty() {
    return VehicleStatus();
  }

  factory VehicleStatus.fromFlespiMessage(
      FlespiChannelMessage flespiChannelMessage) {
    return VehicleStatus(
      batteryChargingStatus: flespiChannelMessage.batteryChargingStatus,
      batteryVoltage: flespiChannelMessage.batteryVoltage,
      channelId: flespiChannelMessage.channelId,
      deviceId: flespiChannelMessage.deviceId,
      deviceTypeId: flespiChannelMessage.deviceTypeId,
      engineBlockedStatus: flespiChannelMessage.engineBlockedStatus ?? false,
      engineIgnitionStatus: flespiChannelMessage.engineIgnitionStatus ?? false,
      engineMotorhours: flespiChannelMessage.engineMotorhours,
      externalPowersourceVoltage:
          flespiChannelMessage.externalPowersourceVoltage,
      gnssStatus: flespiChannelMessage.gnssStatus,
      gsmCellid: flespiChannelMessage.gsmCellid,
      gsmLac: flespiChannelMessage.gsmLac,
      gsmMcc: flespiChannelMessage.gsmMcc,
      gsmMnc: flespiChannelMessage.gsmMnc,
      gsmSignalLevel: flespiChannelMessage.gsmSignalLevel,
      ident: flespiChannelMessage.ident,
      languageEnum: flespiChannelMessage.languageEnum,
      messageBufferedStatus: flespiChannelMessage.messageBufferedStatus,
      peer: flespiChannelMessage.peer,
      positionDirection: flespiChannelMessage.positionDirection,
      positionLatitude: flespiChannelMessage.positionLatitude,
      positionLongitude: flespiChannelMessage.positionLongitude,
      positionSatellites: flespiChannelMessage.positionSatellites,
      positionSpeed: flespiChannelMessage.positionSpeed,
      positionTimestamp: flespiChannelMessage.positionTimestamp,
      positionValid: flespiChannelMessage.positionValid,
      protocolId: flespiChannelMessage.protocolId,
      protocolNumber: flespiChannelMessage.protocolNumber,
      serverTimestamp: flespiChannelMessage.serverTimestamp,
      timestamp: flespiChannelMessage.timestamp,
      vehicleMileage: flespiChannelMessage.vehicleMileage,
    );
  }
}
