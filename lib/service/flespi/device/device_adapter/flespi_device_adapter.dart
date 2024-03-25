import 'package:rg_track/const/devices_supported.dart';
import 'package:rg_track/model/device.dart';
import 'package:rg_track/service/flespi/device/flespi_device.dart';
import 'package:rg_track/service/flespi/device/flespi_device_nt20.dart';

class FlespiDeviceAdapter {
  FlespiDevice? call(Device device) {
    if (device.brand == EnumBrand.X3Tech) {
      if (device.model == EnumModel.NT20) {
        return FlespiDeviceNT20(device);
      }
    } /* else if (device.brand == EnumBrand.SunTech) {
      if (device.model == EnumModel.ST300Series) {
        return FlespiDeviceST300(device);
      }
    } */
    return null;
  }
}
