import 'package:intl/intl.dart';

class FlespiDeviceStatus {
  int? channelId;
  String? source;
  num? lastActive;
  int? deviceId;
  String? ident;

  String get lastActiveFormatted => lastActive != null
      ? DateFormat('dd/MM/yyyy HH:mm').format(
          DateTime.fromMillisecondsSinceEpoch((lastActive! * 1000).toInt()))
      : '';

  FlespiDeviceStatus({
    this.channelId,
    this.source,
    this.lastActive,
    this.deviceId,
    this.ident,
  });

  FlespiDeviceStatus.fromMap(Map<String, dynamic> json) {
    channelId = json['channel_id'];
    source = json['source'];
    lastActive = json['last_active'];
    deviceId = json['device_id'];
    ident = json['ident'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['channel_id'] = this.channelId;
    data['source'] = this.source;
    data['last_active'] = this.lastActive;
    data['device_id'] = this.deviceId;
    data['ident'] = this.ident;
    return data;
  }
}
