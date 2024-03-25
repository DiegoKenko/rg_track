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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel_id'] = channelId;
    data['source'] = source;
    data['last_active'] = lastActive;
    data['device_id'] = deviceId;
    data['ident'] = ident;
    return data;
  }
}
