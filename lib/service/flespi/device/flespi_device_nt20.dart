import 'package:rg_track/const/devices_supported.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/service/flespi/device/flespi_device.dart';

final _deviceTypeId = EnumModel.NT20.flespiId;

class FlespiDeviceNT20 extends FlespiDevice {
  FlespiDeviceNT20(Device device)
      : super(
          imei: device.imei ?? '',
          channelId: '1176716',
          cid: int.tryParse(device.cid ?? ''),
          id: int.tryParse(device.id ?? ''),
          phone: device.simNumber ?? '',
          deviceTypeId: _deviceTypeId,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      "configuration": {"ident": imei, "settings_polling": "once"},
      "device_type_id": deviceTypeId
    };
  }

  @override
  String connectServerCommand(String host, String port) {
    return 'SERVER,8520,$host,$port,0#';
  }

  @override
  String checkConnectionCommand() {
    return 'PARAM#';
  }

  @override
  String sleepCommand(bool on) {
    String onOff = on ? 'ON' : 'OFF';
    return 'SLP$onOff#';
  }

  @override
  String timerMove(int seconds) {
    return 'TIMER,$seconds#';
  }

  @override
  String timerStatic(int hours) {
    return 'STATIC,$hours#';
  }

  @override
  String bend(int angle, bool on) {
    if (on) {
      return 'BEND,1,$angle#';
    } else {
      return 'BEND,0#';
    }
  }

  @override
  String speedMax(int value) {
    return 'SPEEDING,$value,3#';
  }

  @override
  String speedMaxInterval() {
    return 'STIME,10#';
  }
}
