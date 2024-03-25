import 'package:rg_track/const/devices_supported.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/service/flespi/device/flespi_device.dart';

final _deviceTypeId = EnumModel.ST300R.flespiId;

class FlespiDeviceST300 extends FlespiDevice {
  FlespiDeviceST300(Device device)
      : super(
            imei: device.imei ?? '',
            cid: int.tryParse(device.cid ?? ''),
            id: int.tryParse(device.id ?? ''),
            phone: device.simNumber ?? '',
            deviceTypeId: _deviceTypeId,
            channelId: device.channelId);

  @override
  Map<String, dynamic> toMap() {
    return {
      "configuration": {"ident": imei, "phone": phone},
      "device_type_id": deviceTypeId
    };
  }
}
