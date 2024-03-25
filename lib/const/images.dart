import 'dart:ui' as ui;

import 'package:flutter/services.dart';

const iconMapMarkerCarOn = 'assets/images/car_on.png';
const iconMapMarkerCarOff = 'assets/images/car_off.png';
const iconMapMarkerCar = 'assets/images/car.png';
const iconMapMarkerMotorBike = 'assets/images/motorbike.png';
const iconMapMarkerMotorBikeOff = 'assets/images/motorbike_off.png';
const iconMapMarkerMotorBikeOn = 'assets/images/motorbike_on.png';
const iconMapBegin = 'assets/images/start_flag.png';
const iconMapEnd = 'assets/images/end_flag.png';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  ByteData? byteData =
      await fi.image.toByteData(format: ui.ImageByteFormat.png);
  if (byteData == null) {
    return ByteData(1).buffer.asUint8List();
  } else {
    return byteData.buffer.asUint8List();
  }
}
