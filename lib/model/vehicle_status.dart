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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['battery.charging.status'] = this.batteryChargingStatus;
    data['battery.voltage'] = this.batteryVoltage;
    data['channel.id'] = this.channelId;
    data['device.id'] = this.deviceId;
    data['device.type.id'] = this.deviceTypeId;
    data['engine.blocked.status'] = this.engineBlockedStatus;
    data['engine.ignition.status'] = this.engineIgnitionStatus;
    data['engine.motorhours'] = this.engineMotorhours;
    data['external.powersource.voltage'] = this.externalPowersourceVoltage;
    data['gnss.status'] = this.gnssStatus;
    data['gsm.cellid'] = this.gsmCellid;
    data['gsm.lac'] = this.gsmLac;
    data['gsm.mcc'] = this.gsmMcc;
    data['gsm.mnc'] = this.gsmMnc;
    data['gsm.signal.level'] = this.gsmSignalLevel;
    data['ident'] = this.ident;
    data['language.enum'] = this.languageEnum;
    data['message.buffered.status'] = this.messageBufferedStatus;
    data['peer'] = this.peer;
    data['position.direction'] = this.positionDirection;
    data['position.latitude'] = this.positionLatitude;
    data['position.longitude'] = this.positionLongitude;
    data['position.satellites'] = this.positionSatellites;
    data['position.speed'] = this.positionSpeed;
    data['position.timestamp'] = this.positionTimestamp;
    data['position.valid'] = this.positionValid;
    data['protocol.id'] = this.protocolId;
    data['protocol.number'] = this.protocolNumber;
    data['server.timestamp'] = this.serverTimestamp;
    data['timestamp'] = this.timestamp;
    data['vehicle.mileage'] = this.vehicleMileage;
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
